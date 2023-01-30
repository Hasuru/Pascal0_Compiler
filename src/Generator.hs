module Generator where

import              DataTypes
import              Data.Map (Map)
import qualified    Data.Map as Map
import              Control.Monad.State

type Table = Map Ident String

-- Definicao de Temporarios e Labels (tirado do codigo dado pelo professor)
type Count = (Int, Int, Int)

newTemp :: State Count Temp
newTemp = do (t,l,p)<-get; put (t+1,l,p); return ("t"++show t)

popTemp :: Int -> State Count ()
popTemp k = modify (\(t,l,p) -> (t-k,l,p))

popParam :: Int -> State Count ()
popParam k = modify (\(t,l,p) -> (t,l,p-k))

newLabel :: State Count Label
newLabel = do (t,l,p)<-get; put (t,l+1,p); return ("L"++show l)

newParam :: State Count Label
newParam = do (t,l,p)<-get; put (t, l, p+1); return ("s"++show p)

-- traducao do prog
{-transProg :: Table -> Prog -> State Count [Instr]
transProg tabl (Prog id body)
    = do (code, temps) <- transBody tabl body
         return ([LABEL id]++code)

transBody tabl (Body consts procs vars stm)
    = do (tabl1, code1) <- transConst tabl consts
         (tabl2, code2) <- transProc tabl1 procs
         (tabl3, code3) <- transVar tabl2 vars
         code4 <- transStm tbl3 stm
         return (code1++code2++code3++code4)
-}
-- traducao de expressoes
transExpr :: Table -> Expr -> Ident -> State Count [Instr]
transExpr tabl (Num n) dest = return [MOVEI dest n]     
transExpr tabl (Var x) dest                     
    = case Map.lookup x tabl of
        Just temp -> return [MOVE x dest]
        Nothing -> error "Variable undeclared!"
transExpr tabl (BinOp op e1 e2) dest            
    = do temp1 <- newTemp
         temp2 <- newTemp
         code1 <- transExpr tabl e1 temp1
         code2 <- transExpr tabl e2 temp2
         popTemp 2
         return (code1++code2++[OP op dest temp1 temp2])
transExpr tabl (Expressions id exprs) dest    
    = do (code, temps) <- transExprList tabl exprs
         return (code++[CALL dest id temps])


transExprList tabl exprs = worker exprs
    where
        worker [] = return ([],[])
        worker (exp:exps)
            = do temp <- newParam
                 code <- transExpr tabl exp temp
                 (code', temps') <- worker exps
                 return (code++code', temp:temps')


-- traducao de statements
transStm :: Table -> Stm -> State Count [Instr]
transStm tabl (Assign (Var x) e2)
    = case Map.lookup x tabl of
        Just dest -> transExpr tabl e2 dest
        Nothing -> error "Variable undeclared!"
transStm tabl (Statements stms)
    = do (code, temps) <- transStmList tabl stms
         return code
transStm tabl (If cond stm)
    = do label1 <- newLabel
         label2 <- newLabel
         code1 <- transCond tabl cond label1 label2
         code2 <- transStm tabl stm
         return (code1++[LABEL label1]++code2++[LABEL label2])
transStm tabl (IfElse cond stmThen stmElse)
    = do label1 <- newLabel
         label2 <- newLabel
         label3 <- newLabel
         code1 <- transCond tabl cond label1 label2
         code2 <- transStm tabl stmThen
         code3 <- transStm tabl stmElse
         return (code1++[LABEL label1]++code2++[LABEL label2]++code3++[LABEL label3])
transStm tabl (While cond stm)
    = do label1 <- newLabel
         label2 <- newLabel
         label3 <- newLabel
         code1 <- transCond tabl cond label2 label3
         code2 <- transStm tabl stm
         return ([LABEL label1]++code1++[LABEL label2]++code2++[JUMP label1, LABEL label3])
transStm tabl (For id expr cond stm)
    = case Map.lookup id tabl of
        Just temp -> do label1 <- newLabel --assign inicial
                        label2 <- newLabel --salto do while
                        label3 <- newLabel
                        label4 <- newLabel
                        code1 <- transStm tabl (Assign (Var id) expr)
                        code2 <- transCond tabl (RelOp Leq (Var id) cond) label3 label4
                        code3 <- transStm tabl stm
                        return ([LABEL label1]++code1++[LABEL label2]++code2++[LABEL label3]++code3++[OPI Plus temp temp 1]++[JUMP label2, LABEL label4])
        Nothing -> error "Variable Undeclared"
transStm tabl (ProcCall id exprs)
    =  do temp <- newTemp
          (code,temps) <- transExprList tabl exprs
          return (code++[CALL temp id temps])

transStmList tabl stms = worker stms
    where
        worker [] = return ([],[])
        worker (stm:statements)
            = do temp <- newTemp
                 code <- transStm tabl stm
                 (code', temps') <- worker statements
                 return (code++code', temp:temps')

-- traducao de condicoes
transCond :: Table -> Expr -> Label -> Label -> State Count [Instr]
transCond tabl TRue labelt labelf
    = return [LABEL labelt]
transCond tabl FAlse labelt labelf
    = return [LABEL labelf]
transCond tabl (RelOp op e1 e2) labelt labelf
    = do temp1 <- newTemp
         temp2 <- newTemp
         code1 <- transExpr tabl e1 temp1
         code2 <- transExpr tabl e2 temp2
         popTemp 2
         return (code1++code2++[COND temp1 op temp2 labelt labelf])
transCond tabl (UnOp Not e1) labelt labelf
    = transCond tabl e1 labelf labelt
transCond tabl (LogOp And cond1 cond2) labelt labelf
    = do label2 <- newLabel
         code1 <-transCond tabl cond1 label2 labelf
         code2 <- transCond tabl cond2 labelt labelf
         return (code1++[LABEL label2]++code2)
transCond tabl (LogOp Or cond1 cond2) labelt labelf
    = do label2 <- newLabel
         code1 <- transCond tabl cond1 labelt label2
         code2 <- transCond tabl cond2 labelt labelf
         return (code1++[LABEL label2]++code2)
transCond tabl expr labelt labelf
    = do temp <- newTemp
         code <- transExpr tabl expr temp
         return (code++[COND temp Notequal "0" labelt labelf])

transConst :: Table -> [Const] -> State Count (Table, [Instr])
transConst tabl [] = return (tabl, []) 
transConst tabl ((const, int):constList) 
        = do temp <- newTemp
             (temps2, code2) <-transConst (Map.insert const temp tabl) constList
             return (tabl, ([MOVEI temp int]++code2))

-- transformar id no retorno
transform :: Table -> State Count Table
transform t = return (t)

transProc :: Table -> [Proc] -> State Count (Table, [Instr])
transProc tabl [] = return (tabl, [])
transProc tabl ((Procedure id param, (vars, stms)):procList)
        = do temps1 <- transParam tabl param
             (temps2, code1) <- transVar temps1 vars
             popParam (length temps1)
             code2 <- transStm temps2 stms
             (temps3, code3) <- transProc tabl procList
             return (tabl, ([LABEL id]++code2++code3))
transProc tabl ((Function id param t, (vars, stms)):procList)
        = do temp0 <- transform (Map.insert id "v0" tabl) 
             temps1 <- transParam temp0 param
             (temps2, code1) <- transVar temps1 vars
             popParam (length temps1)
             code2 <- transStm temps2 stms
             (temps3, code3) <- transProc tabl procList
             return (tabl, [LABEL id]++code2++[RETURN "v0"]++code3)


transVar :: Table -> [Var] -> State Count (Table, [Instr])
transVar tabl [] = return (tabl, [])
transVar tabl ((var, value): varList)
    = do temp <- newTemp
         (temps2, code2) <- transVar (Map.insert var temp tabl) varList
         return (tabl, code2)


transParam :: Table -> [Parameter] -> State Count Table
transParam tabl [] = return (tabl)
transParam tabl ((var, value): varList)
    = do temp <- newParam
         (temps2) <- transParam (Map.insert var temp tabl) varList
         return (tabl)

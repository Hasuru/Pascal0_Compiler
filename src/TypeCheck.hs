module TypeCheck where
import              DataTypes

import              Data.Map(Map)
import qualified    Data.Map as Map

type TypeEnv = Map Ident Type

-- Expressoes
checkExpr :: TypeEnv -> Expr -> Type
checkExpr env (Num n)               = TyBasic TyInt
checkExpr env (Str s)               = TyBasic TyStr
checkExpr env (TRue)                = TyBasic TyBool
checkExpr env (FAlse)               = TyBasic TyBool
checkExpr env (Var id)              = case Map.lookup id env of
    Nothing -> error "variable undeclared"
    Just t -> t
checkExpr env (BinOp op e1 e2)
    = let type1 = checkExpr env e1
          type2 = checkExpr env e2
      in if type1==TyBasic TyInt && type2==TyBasic TyInt then TyBasic TyInt
         else error ("type error in BinOp " ++ show op)
checkExpr env (RelOp op e1 e2)
    = let type1 = checkExpr env e1
          type2 = checkExpr env e2
      in if type1 == type2 then TyBasic TyBool
         else error ("type error in RelOp " ++ show op)
checkExpr env (UnOp op e)
    = case op of
        Neg -> if (checkExpr env e) == TyBasic TyInt then TyBasic TyInt
               else error "type error in UnOp Neg"
        Not -> if (checkExpr env e) == TyBasic TyBool then TyBasic TyBool
               else error "type error in UnOp Not"
checkExpr env (Expressions id exprList)
    = case Map.lookup id env of
        Just typ -> if all (==typ) (map (checkExpr env) exprList)
                    then typ
                    else error ("type error in Expressions " ++ show id)
        Nothing -> error "invalid expression name"



checkStm :: TypeEnv -> Stm -> Bool
checkStm env (Assign e1 e2)
    = let type1 = checkExpr env e1
          type2 = checkExpr env e2
      in if type1 == type2 then True
         else error "type error in assign"
checkStm env (If cond stm)
    = let typeCond = checkExpr env cond
          typeCheck = checkStm env stm
      in if typeCond == (TyBasic TyBool) && typeCheck
         then True
         else error "type error in if"
checkStm env (IfElse cond stm1 stm2)
    = let tCond = checkExpr env cond
          check1 = checkStm env stm1
          check2 = checkStm env stm2
      in if tCond == (TyBasic TyBool) && check1 && check2
         then True
         else error "type error in if and else"
checkStm env (While cond stm)
    = let tCond = checkExpr env cond
          check = checkStm env stm
      in if tCond == TyBasic TyBool && check
         then True
         else error "type error in while"
checkStm env (For id exp cond stm) = case Map.lookup id env of
        Just typeId -> let typeExp = checkExpr env exp
                           typeCond = checkExpr env cond
                           typeCheck = checkStm env stm
                       in if typeId == typeExp && typeCond == (TyBasic TyBool) && typeCheck
                          then True
                          else error "type error in for" 
checkStm env (ProcCall id exps)
    = case Map.lookup id env of
        Just typ ->  if all (==typ) (map (checkExpr env) exps)
                     then True
                     else error "type error in ProcStm"
        Nothing -> error "invalid procedure name"
checkStm env (Statements stms)
    = if all (==True) (map (checkStm env) stms)
      then True
      else error "type error in Statements"

--checkBody :: TypeEnv -> ProgBody -> Bool
--checkBody env (Body consts procs vars stm)
{-
checkProg :: Prog -> Bool
checkProg (Prog id body)
    = checkBody Map.empty body
-}
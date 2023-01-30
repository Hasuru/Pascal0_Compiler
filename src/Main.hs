module Main where
import Lexer
import Parser
import DataTypes
import Generator
import Assembly

import              Data.Map (Map)
import qualified    Data.Map as Map
import              Control.Monad.State

main :: IO ()
main = do
    txt <- getContents
    let lexer = alexScanTokens txt
        parser = parse $ lexer
        print parse
    {-}
    let tabl = Map.fromList[("x", "t0"), ("y", "t1"), ("z", "t3"), ("w", "t4"), ("func", "t6")]
    let res = evalState (transStm tabl (Statements [(Assign (Var "x") (BinOp Minus (Num 3) (Num 2))), (If (TRue) (Assign (Var "x") (BinOp Minus (Num 3) (Num 2))))])) (4,0,0)
    let assembly = parseToAssembly res
    print res
    putStrLn ("-=-")  
    print assembly -}s

{-
example1 = transExpr tabl (Num 6) "t5"
example2 = transExpr tabl (Var "x") "t5"
example3 = transExpr tabl (BinOp Minus (Num 3) (Num 2)) "t5"
example4 = transExpr tabl (Expressions "test" [(BinOp Minus (Num 3) (Num 2)), (Var "x"), (Num 6)])

example5 = transStm tabl (Assign (Var "x") (BinOp Minus (Num 3) (Num 2)))
example6 = transStm tabl (If (TRue) (Assign (Var "x") (BinOp Minus (Num 3) (Num 2))))
example7 = transStm tabl (IfElse (BinOp Equal (Var "x") (Var "y")) (Assign (Var "x") (BinOp Minus (Num 3) (Num 2))) (Assign (Var "y") (BinOp Mult (Num 1) (Num 2))))
example8 = transStm tabl (While (UnOp Not ((BinOp Equal (Var "x") (Var "y")))) (Var "x") (BinOp Minus (Num 3) (Num 2)))
example9 = transStm tabl (For "x" (Num 0) (Num 5) (Assign (Var "y") (BinOp Plus (Var "y") (Num 1))))
example10 = transStm tabl (ProcCall "func" [(BinOp Minus (Num 3) (Num 2)), (Var "x"), (Num 6)])
example11 = transStm tabl (Statements [(Assign (Var "x") (BinOp Minus (Num 3) (Num 2))), (If (TRue) (Assign (Var "x") (BinOp Minus (Num 3) (Num 2))))]) 

example12 = transCond tabl (LogOp And (Unop not (Var "x")) (RelOp Leq (Var "y") (Var "z"))) labelt labelf
example13 = transCond tabl (Var "x") labelt labelf
-}
module DataTypes where

-- LEXER
data Token = IDENT String           
           | NUM Int                
           | STR String   
           | LPAREN                 
           | RPAREN                 
           | LSQPAREN               
           | RSQPAREN               
           | COMMA                  
           | DOT                    
           | COLON                  
           | SEMICOLON              
           | PLUS                   
           | MINUS                  
           | MULT                   
           | DIV                    
           | MOD                    
           | EQUAL                  
           | NOTEQ                  
           | LESS                   
           | LEQ                    
           | GREATER                
           | GEQ                    
           | AND                    
           | OR                     
           | NOT                    
           | ASSIGN                 
           | PROGRAM
           | FUNCTION
           | PROCEDURE
           | CONST
           | VAR
           | BEGIN
           | END
           | IF
           | THEN
           | ELSE
           | WHILE
           | DO
           | FOR
           | TO
           | TRUE
           | FALSE
           | INT
           | BOOL
           | STRING
           | ARRAY
           | OF
           | BREAK
           | RANGE
           deriving(Eq, Show)

-- PARSER
-- Programs
data Prog = Prog Ident ProgBody
          deriving (Eq,Show)

data ProgBody = Body [Const] [Proc] [Var] Stm
              deriving (Eq,Show)

type Const = (Ident, Int)

type Var = (Ident, Type)

-- Types
data Type = TyBasic BasicType
          | TyArray BasicType Expr Expr
          deriving (Eq, Show)

data BasicType = TyInt
               | TyBool
               | TyStr
               deriving (Eq,Show)


-- Expressions (& identifier)
type Ident = String

data Expr = Num Int
          | Str String
          | TRue
          | FAlse
          | Var Ident
          | Array Ident Expr
          | BinOp Op Expr Expr
          | RelOp Op Expr Expr
          | LogOp Op Expr Expr
          | UnOp Op Expr
          | Expressions Ident [Expr]
          deriving (Eq,Show)

data Op = Plus
        | Minus
        | Mult
        | Div
        | Mod
        | Equal
        | Notequal
        | Less
        | Leq
        | Greater
        | Geq
        | And
        | Or
        | Not
        | Neg
        deriving (Eq,Show)

-- Statements   
data Stm = Assign Expr Expr
         | If Expr Stm
         | IfElse Expr Stm Stm
         | While Expr Stm
         | For Ident Expr Expr Stm
         | Break
         | ProcCall Ident [Expr] -- chamada de procedimentos ou funcoes
         | Statements [Stm]
         deriving (Eq,Show)

    
-- Procedures/Functions
type Proc = (ProcHeader, ProcBody)

data ProcHeader = Procedure Ident [Parameter]
                | Function Ident [Parameter] Type
                deriving (Eq,Show)

type ProcBody = ([Var], Stm)

type Parameter = (Ident, Type)


-- CODIGO INTERMEDIO
type Temp       = String
type Label      = String

data Instr = MOVE Temp Temp
           | MOVEI Temp Int
           | OP Op Temp Temp Temp
           | OPI Op Temp Temp Int
           | LABEL Label
           | JUMP Label
           | COND Temp Op Temp Label Label
           | CALL Temp Label [Temp]
           | RETURN Temp
           deriving (Eq, Show)
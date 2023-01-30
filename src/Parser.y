{
module Parser where
import Lexer
import DataTypes
}

-- Config
%name parse
%tokentype { Token }
%error { parseError }


-- Tokens
%token
-- tokens reservados
program                 { PROGRAM }
function                { FUNCTION }
procedure               { PROCEDURE }
const                   { CONST }
var                     { VAR }
begin                   { BEGIN }
end                     { END }
if                      { IF }
then                    { THEN }
else                    { ELSE }
while                   { WHILE }
do                      { DO }
for                     { FOR }
to                      { TO }
true                    { TRUE }
false                   { FALSE }
integer                 { INT }
boolean                 { BOOL }
string                  { STRING }
array                   { ARRAY }
of                      { OF }
break                   { BREAK }

-- identificadores
identifier              { IDENT $$ }

-- numerais
numeral                 { NUM $$ }

-- strings das write functions
str                     { STR $$ }

-- caratéres especiais
'('                     { LPAREN }
')'                     { RPAREN }
'['                     { LSQPAREN }
']'                     { RSQPAREN }
','                     { COMMA }
'.'                     { DOT }
':'                     { COLON }
';'                     { SEMICOLON }

-- caratéres operacionais
'+'                     { PLUS }
'-'                     { MINUS }
'*'                     { MULT }
'div'                   { DIV }
'mod'                   { MOD }

-- caratéres booleanos
'='                     { EQUAL }
'<>'                    { NOTEQ }
'<'                     { LESS }
'<='                    { LEQ }
'>'                     { GREATER }
'>='                    { GEQ }

-- caratéres extra
'and'                   { AND }
'or'                    { OR }
'not'                   { NOT }
':='                    { ASSIGN }

-- range
'..'                    { RANGE }
--//

-- Associacoes
%nonassoc '<>' '=' '<' '>' '<=' '>='
%left '+' '-' 'or'
%left '*' 'div' 'mod' 'and'
%nonassoc 'not'
--//
%%

-- Gramatica
-- Program
Prog : ProgHeader ProgBody '.'      { Prog $1 $2 }

ProgHeader : program identifier ';' { $2 }

ProgBody : ConstDecls ProcDecls VarDecls Stm { Body $1 $2 $3 $4 }


-- Declarations
ConstDecls : const ConstDefSeq          { $2 }
           | {- empty -}                { [] }

VarDecls : var VarDefSeq        { $2 }
         | {- empty -}          { [] }

ConstDefSeq : ConstDef              { [$1] }
            | ConstDef ConstDefSeq  { $1 : $2 }

VarDefSeq : VarDef                  { [$1] }
          | VarDef VarDefSeq        { $1 : $2 }

ConstDef : identifier '=' numeral ';'   { ($1,$3) }

VarDef : identifier ':' Type ';'   { ($1,$3) }


Type : BasicType                                  { TyBasic $1}
     | array '['Const'..'Const']' of Type         { TyArray $8 $3 $5 }

BasicType : integer      { TyInt }
          | boolean      { TyBool }
          | string       { TyStr }


Const : identifier          { Var $1 }
      | numeral             { Num $1 }

-- Expressions
Expr : numeral                          { Num $1 }
     | str                              { Str $1 }
     | true                             { TRue }
     | false                            { FAlse }
     | VarAccess                        { $1 }
     | Expr '+' Expr                    { BinOp Plus $1 $3 }
     | Expr '-' Expr                    { BinOp Minus $1 $3 }
     | Expr '*' Expr                    { BinOp Mult $1 $3 }
     | Expr 'div' Expr                  { BinOp Div $1 $3 }
     | Expr 'mod' Expr                  { BinOp Mod $1 $3 }
     | Expr '=' Expr                    { RelOp Equal $1 $3 }
     | Expr '<>' Expr                   { RelOp Notequal $1 $3 }
     | Expr '<' Expr                    { RelOp Less $1 $3 }
     | Expr '<=' Expr                   { RelOp Leq $1 $3 }
     | Expr '>' Expr                    { RelOp Greater $1 $3 }
     | Expr '>=' Expr                   { RelOp Geq $1 $3 }
     | Expr 'and' Expr                  { LogOp And $1 $3 }
     | Expr 'or' Expr                   { LogOp Or $1 $3 }
     | 'not' Expr                       { UnOp Not $2 }
     | '-' Expr                         { UnOp Neg $2 }
     | '('Expr')'                       { $2 }
     | identifier '('ExprList')'        { Expressions $1 $3 }

    

VarAccess : identifier              { Var $1 }
          | identifier '['Expr']'   { Array $1 $3 }

ExprList : {- empty -}              { [] } 
         | Expr                     { [$1] }
         | ExprList ',' Expr        { $3 : $1 }


-- Statements
Stm : VarAccess ':=' Expr                       { Assign $1 $3 }
    | if Expr then Stm                          { If $2 $4 }
    | if Expr then Stm else Stm                 { IfElse $2 $4 $6 }
    | while Expr do Stm                         { While $2 $4 }
    | for identifier ':=' Expr to Expr do Stm   { For $2 $4 $6 $8 }
    | break                                     { Break }
    | identifier '('ExprList')'                 { ProcCall $1 $3 }
    | begin StmList end                         { Statements $2 }

StmList : Stm                                   { [$1] }
        | StmList ';' Stm                       { $3 : $1 }


-- Procedures/Functions
Proc : ProcHeader ProcBody ';'      { ($1,$2) }

ProcHeader : procedure identifier '('ParamList')' ';'   { Procedure $2 $4 }
           | function identifier '('ParamList')' ':' Type ';'    { Function $2 $4 $7 }

ProcBody : VarDecls Stm         { ($1,$2) }

ProcDecls : ProcDefSeq          { $1 }
          | {- empty -}         { [] }

ProcDefSeq : Proc               { [$1] }
           | ProcDefSeq Proc    { $2 : $1 }

ParamList : {- empty -}             { [] }
          | Param                   { [$1] }
          | ParamList ';' Param     { $3 : $1 }

Param : identifier ':' Type    { ($1,$3) }
--//       


{
-- Error message
parseError :: [Token] -> a
parseError toks = error "parse error"
}
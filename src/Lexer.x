-- Analisador lexical para a linguagem Pascal0
{
module Lexer where
import Data.Char(toLower)
import DataTypes
}

%wrapper "basic"

-- definicoes de classes
$white  =   [\ \t\n\r]
$digit  =   [0-9]
$alpha  =   [_a-zA-Z]

token :-

-- classes
-- espacos brancos
$white+                 ;

-- carateres especiais
"("                     {\_ -> LPAREN}
")"                     {\_ -> RPAREN}
"["                     {\_ -> LSQPAREN}
"]"                     {\_ -> RSQPAREN}
","                     {\_ -> COMMA}
"."                     {\_ -> DOT}
":"                     {\_ -> COLON}
";"                     {\_ -> SEMICOLON}
"+"                     {\_ -> PLUS}
"-"                     {\_ -> MINUS}
"*"                     {\_ -> MULT}
"="                     {\_ -> EQUAL}
"<>"                    {\_ -> NOTEQ}
"<"                     {\_ -> LESS}
"<="                    {\_ -> LEQ}
">"                     {\_ -> GREATER}
">="                    {\_ -> GEQ}
":="                    {\_ -> ASSIGN}
".."                    {\_ -> RANGE}

-- comentarios
"(*"([^\*] | \*[^\)] | \*$white | $white)* "*)";

-- strings
\' [^\']* \'             {\s -> STR s}

-- identificadores
$alpha($alpha|$digit)*  {\s -> tokenizer(map toLower s)}

-- numerais
$digit+                 {\s -> NUM (read s)}

{
tokenizer :: String -> Token
tokenizer l = case l of
    "and"           -> AND
    "or"            -> OR
    "not"           -> NOT
    "program"       -> PROGRAM
    "function"      -> FUNCTION
    "procedure"     -> PROCEDURE
    "const"         -> CONST
    "var"           -> VAR
    "begin"         -> BEGIN
    "end"           -> END
    "if"            -> IF
    "then"          -> THEN
    "else"          -> ELSE
    "while"         -> WHILE
    "do"            -> DO
    "for"           -> FOR
    "to"            -> TO
    "true"          -> TRUE
    "false"         -> FALSE
    "div"           -> DIV
    "mod"           -> MOD
    "integer"       -> INT
    "boolean"       -> BOOL
    "string"        -> STRING
    "array"         -> ARRAY
    "of"            -> OF
    "break"         -> BREAK
    s               -> IDENT s
}
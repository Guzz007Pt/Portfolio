{
module Parser where
import Lexer
}

%name parse
%tokentype { Token }
%error { parseError }

%token
num             { TOK_NUM $$ }
"+"             { TOK_PLUS }
"-"             { TOK_MINUS }
"*"             { TOK_MULT }
"/"             { TOK_DIV }
"("             { TOK_LPAREN }
")"             { TOK_RPAREN }
"{"             { TOK_LBRACE }
"}"             { TOK_RBRACE }
"="             { TOK_DEF }
"=="            { TOK_EQ }
"!="            { TOK_NOTEQ }
"<"             { TOK_LESS }
"<="            { TOK_LESSEQ }
">"             { TOK_GREATER }
">="            { TOK_GREATEREQ }
"!"             { TOK_NOT }
"||"            { TOK_OR }
"&&"            { TOK_AND }
"true"          { TOK_TRUE }
"false"         { TOK_FALSE }
"var"           { TOK_VAR }    
"val"           { TOK_VAL }
"if"            { TOK_IF }
"else"          { TOK_ELSE }
"while"         { TOK_WHILE }
"print"         { TOK_PRINT }
"println"       { TOK_PRINTLN }
"fun"           { TOK_FUN }   
"main"          { TOK_MAIN } 
"readln"        { TOK_READLN }
id              { TOK_ID $$ }

%nonassoc "==" "!=" "<" "<=" ">" ">=" "||" "&&"
%left "+" "-"
%left "*" "/"

%%

Begn : "fun" "main" "(" ")" Block                  { Program [$5] }

Block : "{" Block_stm "}"                           { Block $2 }
      | "{" "}"                                     { Block [] }

Block_stm : Stm Block_stm                           { $1 : $2 }
           |                                        { [] }

Stm : Block                                         { $1 }
    | If_                                           { $1 }
    | While_                                        { $1 }
    | "print" "(" Exp ")"                           { Print $3 }
    | "println" "(" Exp ")"                         { PrintLn $3 }
    | VarDecl                                       { $1 }
    | ValDecl                                       { $1 }
    | id "=" Exp                                    { Assign (Var $1) $3 }
    | ReadLine                                      { $1 }

If_ : "if" "(" Exp ")" Stm "else" Stm               { IfElse $3 $5 $7 }
    | "if" "(" Exp ")" Stm                          { If $3 $5 }

While_ : "while" "(" Exp ")" Stm                    { While $3 $5 }

Exp : Exp "+" Exp            { Add $1 $3 }
    | Exp "-" Exp            { Sub $1 $3 }
    | Exp "*" Exp            { Mul $1 $3 }
    | Exp "/" Exp            { Div $1 $3 }
    | Exp "==" Exp           { Eq $1 $3 }
    | Exp "!=" Exp           { NotEq $1 $3 }
    | Exp "<" Exp            { Less $1 $3 }
    | Exp "<=" Exp           { LessEq $1 $3 }
    | Exp ">" Exp            { Greater $1 $3 }
    | Exp ">=" Exp           { GreaterEq $1 $3 }
    | Exp "||" Exp           { Or $1 $3 }
    | Exp "&&" Exp           { And $1 $3 }
    | "!" Exp                { Not $2 }
    | Term                   { $1 }

VarDecl : "var" id "=" Exp                         { VarDecl $2 $4 }

ValDecl : "val" id "=" Exp                         { ValDecl $2 $4 }

ReadLine : "var" id "=" "readln" "(" ")"           { ReadLine $2 }  
         | "val" id "=" "readln" "(" ")"           { ReadLine $2 }

Term : num                   { Num $1 }
     | id                    { Var $1 }
     | "true"                { Bool True }
     | "false"               { Bool False }
     | "(" Exp ")"           { $2 }

{
-- Definitions of types
data Exp
    = Num Int
    | Bool Bool
    | Var String
    | Add Exp Exp
    | Sub Exp Exp 
    | Mul Exp Exp 
    | Div Exp Exp 

    | Program [Exp]
    | Block [Exp]

    | VarDecl String Exp
    | ValDecl String Exp
    | Assign Exp Exp

    | If Exp Exp
    | IfElse Exp Exp Exp
    | While Exp Exp

    | Eq Exp Exp
    | NotEq Exp Exp
    | Less Exp Exp
    | LessEq Exp Exp
    | Greater Exp Exp
    | GreaterEq Exp Exp
    | Or Exp Exp
    | And Exp Exp
    | Not Exp

    | Print Exp
    | PrintLn Exp
    | ReadLine String
    deriving Show

parseError :: [Token] -> a
parseError _ = error "Parse error"
}
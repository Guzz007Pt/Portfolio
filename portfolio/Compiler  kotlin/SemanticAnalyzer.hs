module SemanticAnalyzer where

import Parser (Exp(..))
import SymbolTable
import qualified Data.Map as Map

analyzeProgram :: Exp -> Either String SymbolTable
analyzeProgram (Program exps) = analyzeBlock exps emptySymbolTable
analyzeProgram _ = Left "Top-level is not a Program node."

analyzeBlock :: [Exp] -> SymbolTable -> Either String SymbolTable
analyzeBlock [] st = Right st
analyzeBlock (stmt:stmts) st = do
    st' <- analyzeStatement stmt st
    analyzeBlock stmts st'

analyzeStatement :: Exp -> SymbolTable -> Either String SymbolTable
analyzeStatement (VarDecl name expr) st = do
    t <- inferType expr st
    insertVar name t st

analyzeStatement (ValDecl name expr) st = do
    t <- inferType expr st
    insertVal name t st

analyzeStatement (Assign (Var name) expr) st =
    case lookupSymbol name st of
        Just info ->
            if symMutable info
            then do t <- inferType expr st
                    if t == symType info
                    then Right st
                    else Left $ "Type mismatch in assignment to " ++ name
            else Left $ "Cannot assign to immutable value " ++ name
        Nothing -> Left $ "Undeclared variable " ++ name

analyzeStatement (If cond body) st = do
    t <- inferType cond st
    if t == BoolType
       then analyzeStatement body st
       else Left "Condition in if must be bool."

analyzeStatement (IfElse cond thn els) st = do
    t <- inferType cond st
    if t == BoolType
       then do st1 <- analyzeStatement thn st
               analyzeStatement els st1
       else Left "Condition in if-else must be bool."

analyzeStatement (While cond body) st = do
    t <- inferType cond st
    if t == BoolType
       then analyzeStatement body st
       else Left "Condition in while must be bool."

analyzeStatement (Block exps) st = analyzeBlock exps st

analyzeStatement (Print expr) st = do
    _ <- inferType expr st
    Right st

analyzeStatement (PrintLn expr) st = do
    _ <- inferType expr st
    Right st

analyzeStatement (ReadLine name) st =
    if Map.member name st
    then Left $ "Variable " ++ name ++ " already declared."
    else Right (Map.insert name (SymbolInfo IntType True) st)

analyzeStatement _ st = Right st

inferType :: Exp -> SymbolTable -> Either String Type
inferType (Num _)  _ = Right IntType
inferType (Bool _) _ = Right BoolType
inferType (Var x) st =
    case lookupSymbol x st of
        Just info -> Right (symType info)
        Nothing   -> Left $ "Undeclared variable " ++ x
inferType (Add e1 e2) st = inferBinOp e1 e2 IntType st
inferType (Sub e1 e2) st = inferBinOp e1 e2 IntType st
inferType (Mul e1 e2) st = inferBinOp e1 e2 IntType st
inferType (Div e1 e2) st = inferBinOp e1 e2 IntType st
inferType (Eq e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (NotEq e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (Less e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (LessEq e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (Greater e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (GreaterEq e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (Or e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (And e1 e2) st = inferBinOp e1 e2 BoolType st
inferType (Not e) st = do
    t <- inferType e st
    if t == BoolType
       then Right BoolType
       else Left "Not operation only allowed on booleans."
inferType _ _ = Left "Cannot infer type for this expression."

inferBinOp :: Exp -> Exp -> Type -> SymbolTable -> Either String Type
inferBinOp e1 e2 resultType st = do
    t1 <- inferType e1 st
    t2 <- inferType e2 st
    if t1 == t2
       then Right resultType
       else Left "Type mismatch in binary operation."

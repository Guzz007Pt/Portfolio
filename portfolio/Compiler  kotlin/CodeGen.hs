{-# LANGUAGE FlexibleContexts #-}

module CodeGen where

import Control.Monad.State
import Parser (Exp(..))          
import SymbolTable (SymbolInfo(..), Type(..)) 


data TAC
    = TACAssign String String
    | TACBinOp String String String String
    | TACPrint String
    | TACRead String
    | TACLabel String
    | TACGoto String
    | TACIfEq String String String
    | TACIfNeq String String String
    | TACIfLess String String String
    | TACIfLessEq String String String
    | TACIfGreater String String String
    | TACIfGreaterEq String String String
    deriving (Show, Eq)


data CodeGenState = CodeGenState
    { tempCount  :: Int
    , labelCount :: Int
    , code       :: [TAC]
    }

type CodeGenM = State CodeGenState


runCodeGen :: Exp -> [TAC]
runCodeGen ast = code $ execState (genProgram ast) (CodeGenState 0 0 [])

emit :: TAC -> CodeGenM ()
emit instr = do
    st <- get
    put st { code = code st ++ [instr] }

freshTemp :: CodeGenM String
freshTemp = do
    st <- get
    put st { tempCount = tempCount st + 1 }
    return $ "t" ++ show (tempCount st - 1)

freshLabel :: CodeGenM String
freshLabel = do
    st <- get
    put st { labelCount = labelCount st + 1 }
    return $ "L" ++ show (labelCount st - 1)


genProgram :: Exp -> CodeGenM ()
genProgram (Program [Block stmts]) = mapM_ genStatement stmts
genProgram _ = return ()

genStatement :: Exp -> CodeGenM ()
genStatement (VarDecl x e) = do
    rhs <- genExp e
    emit $ TACAssign x rhs

genStatement (ValDecl x e) = do
    rhs <- genExp e
    emit $ TACAssign x rhs

genStatement (Assign (Var x) e) = do
    rhs <- genExp e
    emit $ TACAssign x rhs

genStatement (Print e) = do
    val <- genExp e
    emit $ TACPrint val

genStatement (PrintLn e) = do
    val <- genExp e
    emit $ TACPrint val

genStatement (If cond body) = do
    l1 <- freshLabel
    l2 <- freshLabel
    (lhs, rhs, op) <- genCondition cond
    case op of
        "==" -> emit $ TACIfEq lhs rhs l1
        "!=" -> emit $ TACIfNeq lhs rhs l1   
        "<"  -> emit $ TACIfLess lhs rhs l1  
        "<=" -> emit $ TACIfLessEq lhs rhs l1
        ">"  -> emit $ TACIfGreater lhs rhs l1
        ">=" -> emit $ TACIfGreaterEq lhs rhs l1
        _    -> error $ "Operator " ++ op ++ " not supported yet."

    emit $ TACGoto l2
    emit $ TACLabel l1
    genStatement body
    emit $ TACLabel l2

genStatement (IfElse cond thn els) = do
    l1 <- freshLabel
    l2 <- freshLabel
    l3 <- freshLabel
    (lhs, rhs, op) <- genCondition cond
    case op of
        "==" -> emit $ TACIfEq lhs rhs l1
        "!=" -> emit $ TACIfNeq lhs rhs l1
        "<"  -> emit $ TACIfLess lhs rhs l1
        "<=" -> emit $ TACIfLessEq lhs rhs l1
        ">"  -> emit $ TACIfGreater lhs rhs l1
        ">=" -> emit $ TACIfGreaterEq lhs rhs l1
        _    -> error $ "Operator " ++ op ++ " not supported yet."

    emit $ TACGoto l2
    emit $ TACLabel l1
    genStatement thn
    emit $ TACGoto l3
    emit $ TACLabel l2
    genStatement els
    emit $ TACLabel l3

genStatement (While cond body) = do
    lstart <- freshLabel
    lend <- freshLabel
    emit $ TACLabel lstart
    (lhs, rhs, op) <- genCondition cond
    case op of
        "==" -> do
            emit $ TACIfEq lhs rhs (lstart ++ "_body")
        "!=" -> do
            emit $ TACIfNeq lhs rhs (lstart ++ "_body")
        "<"  -> do
            emit $ TACIfLess lhs rhs (lstart ++ "_body")
        "<=" -> do
            emit $ TACIfLessEq lhs rhs (lstart ++ "_body")
        ">"  -> do
            emit $ TACIfGreater lhs rhs (lstart ++ "_body")
        ">=" -> do
            emit $ TACIfGreaterEq lhs rhs (lstart ++ "_body")
        _ -> error $ "Operator " ++ op ++ " not supported yet."

    emit $ TACGoto lend
    emit $ TACLabel (lstart ++ "_body")
    genStatement body
    emit $ TACGoto lstart
    emit $ TACLabel lend


genStatement (Block stmts) = mapM_ genStatement stmts


genStatement (ReadLine x) = do
    emit $ TACRead x

genStatement _ = return ()


genExp :: Exp -> CodeGenM String
genExp (Num n) = return (show n)
genExp (Var x) = return x
genExp (Bool True) = return "1"
genExp (Bool False) = return "0"

genExp (Add e1 e2) = genBinOp e1 e2 "+"
genExp (Sub e1 e2) = genBinOp e1 e2 "-"
genExp (Mul e1 e2) = genBinOp e1 e2 "*"
genExp (Div e1 e2) = genBinOp e1 e2 "/"

genExp (Eq e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    t <- freshTemp
    return lhs



genExp _ = do
    return "0"

genBinOp :: Exp -> Exp -> String -> CodeGenM String
genBinOp e1 e2 op = do
    lhs <- genExp e1
    rhs <- genExp e2
    t <- freshTemp
    emit $ TACBinOp t lhs op rhs
    return t


genCondition :: Exp -> CodeGenM (String, String, String)
genCondition (Eq e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    return (lhs, rhs, "==")

genCondition (NotEq e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    return (lhs, rhs, "!=")

genCondition (Less e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    return (lhs, rhs, "<")

genCondition (LessEq e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    return (lhs, rhs, "<=")

genCondition (Greater e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    return (lhs, rhs, ">")

genCondition (GreaterEq e1 e2) = do
    lhs <- genExp e1
    rhs <- genExp e2
    return (lhs, rhs, ">=")

genCondition _ = error "genCondition: Unhandled condition type."

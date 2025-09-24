module SymbolTable where

import qualified Data.Map as Map

data Type = IntType | BoolType | UnknownType
    deriving (Show, Eq)

data SymbolInfo = SymbolInfo
    { symType    :: Type
    , symMutable :: Bool
    }
    deriving (Show, Eq)

type SymbolTable = Map.Map String SymbolInfo

emptySymbolTable :: SymbolTable
emptySymbolTable = Map.empty

insertVar :: String -> Type -> SymbolTable -> Either String SymbolTable
insertVar name t st =
    if Map.member name st
       then Left $ "Variable " ++ name ++ " already declared."
       else Right (Map.insert name (SymbolInfo t True) st)

insertVal :: String -> Type -> SymbolTable -> Either String SymbolTable
insertVal name t st =
    if Map.member name st
       then Left $ "Value " ++ name ++ " already declared."
       else Right (Map.insert name (SymbolInfo t False) st)

lookupSymbol :: String -> SymbolTable -> Maybe SymbolInfo
lookupSymbol = Map.lookup
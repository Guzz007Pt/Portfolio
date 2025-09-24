module Main where

import System.IO (getContents)
import System.Environment (getArgs)
import Lexer (lexer)                
import Parser (parse, Exp(..))      
import SemanticAnalyzer (analyzeProgram)
import CodeGen (runCodeGen)        
import MIPSGen (writeMIPS)          

main :: IO ()
main = do
    input <- getContents
    let tokens = lexer input
    let ast = parse tokens
    case analyzeProgram ast of
        Left err -> do
            putStrLn $ "Semantic error: " ++ err
        Right symTable -> do
            let tacInstructions = runCodeGen ast
            writeMIPS "output.s" tacInstructions
            putStrLn "MIPS code generated in output.s"
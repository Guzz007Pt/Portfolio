module MIPSGen where

import Control.Monad.State
import System.IO

import Data.Map (Map)
import qualified Data.Map as Map
import CodeGen (TAC(..))

type MIPS = [String]

data MIPSState = MIPSState
    { varOffsets :: Map String Int 
    , nextOffset :: Int            
    }

initMIPSState :: MIPSState
initMIPSState = MIPSState Map.empty 0

allocVar :: String -> State MIPSState Int
allocVar var = do
    st <- get
    let off = nextOffset st - 4 
    put st { varOffsets = Map.insert var off (varOffsets st)
           , nextOffset = off }
    return off

getVarOffset :: String -> State MIPSState Int
getVarOffset var = do
    st <- get
    case Map.lookup var (varOffsets st) of
        Just off -> return off
        Nothing  -> allocVar var

loadVar :: String -> State MIPSState [String]
loadVar var = do
    off <- getVarOffset var
    return [ "lw $t0, " ++ show off ++ "($sp)" ]

storeVar :: String -> State MIPSState [String]
storeVar var = do
    off <- getVarOffset var
    return [ "sw $t0, " ++ show off ++ "($sp)" ]

loadImm :: Int -> [String]
loadImm n = [ "li $t0, " ++ show n ]

loadOperand :: String -> State MIPSState [String]
loadOperand op =
    if all (`elem` "0123456789") op
       then return (loadImm (read op))
       else loadVar op

sanitizeLabel :: String -> String
sanitizeLabel = map (\c -> if c == '-' then '_' else c)

genInstr :: TAC -> State MIPSState [String]
genInstr (TACAssign dst src) = do
    case reads src :: [(Int, String)] of
        [(n, "")] -> do
            st1 <- return $ loadImm n
            st2 <- storeVar dst
            return (st1 ++ st2)
        _ -> do
            st1 <- loadVar src
            st2 <- storeVar dst
            return (st1 ++ st2)

genInstr (TACBinOp dst lhs op rhs) = do
    lhsLoad <- loadOperand lhs
    let saveT1 = ["move $t1, $t0"]

    rhsLoad <- loadOperand rhs

    let opInstr = case op of
                     "+" -> ["add $t0, $t1, $t0"]
                     "-" -> ["sub $t0, $t1, $t0"]
                     "*" -> ["mul $t0, $t1, $t0"]
                     "/" -> [ "div $t1, $t0"
                            , "mflo $t0"
                            ]
                     _   -> error $ "Unknown operator " ++ op

    store <- storeVar dst
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ opInstr ++ store)

genInstr (TACPrint var) = do
    varLoad <- loadOperand var
    let moveA0 = ["move $a0, $t0"]
        printCall = [ "li $v0, 1"
                    , "syscall"
                    , "li $a0, 10"
                    , "li $v0, 11"
                    , "syscall"
                    ]
    return (varLoad ++ moveA0 ++ printCall)

genInstr (TACLabel lbl) = return [sanitizeLabel lbl ++ ":"]

genInstr (TACGoto lbl) = return ["j " ++ sanitizeLabel lbl]

genInstr (TACIfEq lhs rhs lbl) = do
    lhsLoad <- loadOperand lhs
    rhsLoad <- loadOperand rhs
    let saveT1 = ["move $t1, $t0"]
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ ["beq $t1, $t0, " ++ sanitizeLabel lbl])

genInstr (TACIfNeq lhs rhs lbl) = do
    lhsLoad <- loadOperand lhs
    rhsLoad <- loadOperand rhs
    let saveT1 = ["move $t1, $t0"]
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ ["bne $t1, $t0, " ++ sanitizeLabel lbl])

genInstr (TACIfLess lhs rhs lbl) = do
    lhsLoad <- loadOperand lhs
    rhsLoad <- loadOperand rhs
    let saveT1 = ["move $t1, $t0"]
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ ["blt $t1, $t0, " ++ sanitizeLabel lbl])

genInstr (TACIfLessEq lhs rhs lbl) = do
    lhsLoad <- loadOperand lhs
    rhsLoad <- loadOperand rhs
    let saveT1 = ["move $t1, $t0"]
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ ["ble $t1, $t0, " ++ sanitizeLabel lbl])

genInstr (TACIfGreater lhs rhs lbl) = do
    lhsLoad <- loadOperand lhs
    rhsLoad <- loadOperand rhs
    let saveT1 = ["move $t1, $t0"]
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ ["bgt $t1, $t0, " ++ sanitizeLabel lbl])

genInstr (TACIfGreaterEq lhs rhs lbl) = do
    lhsLoad <- loadOperand lhs
    rhsLoad <- loadOperand rhs
    let saveT1 = ["move $t1, $t0"]
    return (lhsLoad ++ saveT1 ++ rhsLoad ++ ["bge $t1, $t0, " ++ sanitizeLabel lbl])

generateMIPS :: [TAC] -> [String]
generateMIPS tacs = 
    let (mips, _) = runState (genAll tacs) initMIPSState
    in header ++ mips ++ footer
  where
    header = [ ".data"
             , ".text"
             , "main:" 
             ]
    footer = [ "li $v0, 10", "syscall" ] 

    genAll :: [TAC] -> State MIPSState [String]
    genAll [] = return []
    genAll (i:is) = do
        codeForI <- genInstr i
        rest <- genAll is
        return (codeForI ++ rest)

writeMIPS :: FilePath -> [TAC] -> IO ()
writeMIPS filename tacs = do
    let mipsCode = generateMIPS tacs
    writeFile filename (unlines mipsCode)

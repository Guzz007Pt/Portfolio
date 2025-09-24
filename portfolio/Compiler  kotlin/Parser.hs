{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,284) ([0,0,1024,0,0,512,0,0,512,0,0,0,32768,0,0,32768,0,0,32768,0,0,0,0,0,8192,47104,35,0,0,0,4096,0,0,1024,30464,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,1024,32768,0,0,16384,0,0,8192,0,0,4096,0,0,32768,0,0,1056,800,16,528,400,8,264,200,4,132,100,2,66,50,1,512,0,0,256,0,0,0,0,0,0,0,4096,36866,3073,2048,51201,1536,30720,7153,0,0,0,0,0,0,0,4224,3200,64,2112,1600,32,0,0,0,0,0,0,0,0,0,61816,27,0,63676,13,0,64606,6,0,32271,3,16384,16392,8198,8192,8196,4099,4096,36866,2049,2048,51201,1024,33792,25600,512,16896,12800,256,8448,6400,128,4224,3200,64,2112,1600,32,1056,800,16,528,400,8,264,200,4,0,0,0,0,0,0,128,36576,0,0,0,32768,48919,1,0,16,4572,57344,28609,0,0,1,0,30720,7152,0,16384,0,0,16384,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,240,0,0,120,0,0,60,0,0,30,0,0,15,0,32768,7,0,49152,3,0,57344,1,0,0,0,0,0,0,0,12288,0,0,6144,0,0,16384,28672,71,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Begn","Block","Block_stm","Stm","If_","While_","Exp","VarDecl","ValDecl","ReadLine","Term","num","\"+\"","\"-\"","\"*\"","\"/\"","\"(\"","\")\"","\"{\"","\"}\"","\"=\"","\"==\"","\"!=\"","\"<\"","\"<=\"","\">\"","\">=\"","\"!\"","\"||\"","\"&&\"","\"true\"","\"false\"","\"var\"","\"val\"","\"if\"","\"else\"","\"while\"","\"print\"","\"println\"","\"fun\"","\"main\"","\"readln\"","id","%eof"]
        bit_start = st Prelude.* 47
        bit_end = (st Prelude.+ 1) Prelude.* 47
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..46]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (43) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (43) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (44) = happyShift action_4
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (47) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (20) = happyShift action_5
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (21) = happyShift action_6
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (22) = happyShift action_8
action_6 (5) = happyGoto action_7
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_1

action_8 (22) = happyShift action_8
action_8 (23) = happyShift action_17
action_8 (36) = happyShift action_18
action_8 (37) = happyShift action_19
action_8 (38) = happyShift action_20
action_8 (40) = happyShift action_21
action_8 (41) = happyShift action_22
action_8 (42) = happyShift action_23
action_8 (46) = happyShift action_24
action_8 (5) = happyGoto action_9
action_8 (6) = happyGoto action_10
action_8 (7) = happyGoto action_11
action_8 (8) = happyGoto action_12
action_8 (9) = happyGoto action_13
action_8 (11) = happyGoto action_14
action_8 (12) = happyGoto action_15
action_8 (13) = happyGoto action_16
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_6

action_10 (23) = happyShift action_33
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (22) = happyShift action_8
action_11 (36) = happyShift action_18
action_11 (37) = happyShift action_19
action_11 (38) = happyShift action_20
action_11 (40) = happyShift action_21
action_11 (41) = happyShift action_22
action_11 (42) = happyShift action_23
action_11 (46) = happyShift action_24
action_11 (5) = happyGoto action_9
action_11 (6) = happyGoto action_32
action_11 (7) = happyGoto action_11
action_11 (8) = happyGoto action_12
action_11 (9) = happyGoto action_13
action_11 (11) = happyGoto action_14
action_11 (12) = happyGoto action_15
action_11 (13) = happyGoto action_16
action_11 _ = happyReduce_5

action_12 _ = happyReduce_7

action_13 _ = happyReduce_8

action_14 _ = happyReduce_11

action_15 _ = happyReduce_12

action_16 _ = happyReduce_14

action_17 _ = happyReduce_3

action_18 (46) = happyShift action_31
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (46) = happyShift action_30
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (20) = happyShift action_29
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (20) = happyShift action_28
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (20) = happyShift action_27
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (20) = happyShift action_26
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (24) = happyShift action_25
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (15) = happyShift action_38
action_25 (20) = happyShift action_39
action_25 (31) = happyShift action_40
action_25 (34) = happyShift action_41
action_25 (35) = happyShift action_42
action_25 (46) = happyShift action_43
action_25 (10) = happyGoto action_47
action_25 (14) = happyGoto action_37
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (15) = happyShift action_38
action_26 (20) = happyShift action_39
action_26 (31) = happyShift action_40
action_26 (34) = happyShift action_41
action_26 (35) = happyShift action_42
action_26 (46) = happyShift action_43
action_26 (10) = happyGoto action_46
action_26 (14) = happyGoto action_37
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (15) = happyShift action_38
action_27 (20) = happyShift action_39
action_27 (31) = happyShift action_40
action_27 (34) = happyShift action_41
action_27 (35) = happyShift action_42
action_27 (46) = happyShift action_43
action_27 (10) = happyGoto action_45
action_27 (14) = happyGoto action_37
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (15) = happyShift action_38
action_28 (20) = happyShift action_39
action_28 (31) = happyShift action_40
action_28 (34) = happyShift action_41
action_28 (35) = happyShift action_42
action_28 (46) = happyShift action_43
action_28 (10) = happyGoto action_44
action_28 (14) = happyGoto action_37
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (15) = happyShift action_38
action_29 (20) = happyShift action_39
action_29 (31) = happyShift action_40
action_29 (34) = happyShift action_41
action_29 (35) = happyShift action_42
action_29 (46) = happyShift action_43
action_29 (10) = happyGoto action_36
action_29 (14) = happyGoto action_37
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (24) = happyShift action_35
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (24) = happyShift action_34
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_4

action_33 _ = happyReduce_2

action_34 (15) = happyShift action_38
action_34 (20) = happyShift action_39
action_34 (31) = happyShift action_40
action_34 (34) = happyShift action_41
action_34 (35) = happyShift action_42
action_34 (45) = happyShift action_69
action_34 (46) = happyShift action_43
action_34 (10) = happyGoto action_68
action_34 (14) = happyGoto action_37
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (15) = happyShift action_38
action_35 (20) = happyShift action_39
action_35 (31) = happyShift action_40
action_35 (34) = happyShift action_41
action_35 (35) = happyShift action_42
action_35 (45) = happyShift action_67
action_35 (46) = happyShift action_43
action_35 (10) = happyGoto action_66
action_35 (14) = happyGoto action_37
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (16) = happyShift action_48
action_36 (17) = happyShift action_49
action_36 (18) = happyShift action_50
action_36 (19) = happyShift action_51
action_36 (21) = happyShift action_65
action_36 (25) = happyShift action_52
action_36 (26) = happyShift action_53
action_36 (27) = happyShift action_54
action_36 (28) = happyShift action_55
action_36 (29) = happyShift action_56
action_36 (30) = happyShift action_57
action_36 (32) = happyShift action_58
action_36 (33) = happyShift action_59
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_31

action_38 _ = happyReduce_36

action_39 (15) = happyShift action_38
action_39 (20) = happyShift action_39
action_39 (31) = happyShift action_40
action_39 (34) = happyShift action_41
action_39 (35) = happyShift action_42
action_39 (46) = happyShift action_43
action_39 (10) = happyGoto action_64
action_39 (14) = happyGoto action_37
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (15) = happyShift action_38
action_40 (20) = happyShift action_39
action_40 (31) = happyShift action_40
action_40 (34) = happyShift action_41
action_40 (35) = happyShift action_42
action_40 (46) = happyShift action_43
action_40 (10) = happyGoto action_63
action_40 (14) = happyGoto action_37
action_40 _ = happyFail (happyExpListPerState 40)

action_41 _ = happyReduce_38

action_42 _ = happyReduce_39

action_43 _ = happyReduce_37

action_44 (16) = happyShift action_48
action_44 (17) = happyShift action_49
action_44 (18) = happyShift action_50
action_44 (19) = happyShift action_51
action_44 (21) = happyShift action_62
action_44 (25) = happyShift action_52
action_44 (26) = happyShift action_53
action_44 (27) = happyShift action_54
action_44 (28) = happyShift action_55
action_44 (29) = happyShift action_56
action_44 (30) = happyShift action_57
action_44 (32) = happyShift action_58
action_44 (33) = happyShift action_59
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (16) = happyShift action_48
action_45 (17) = happyShift action_49
action_45 (18) = happyShift action_50
action_45 (19) = happyShift action_51
action_45 (21) = happyShift action_61
action_45 (25) = happyShift action_52
action_45 (26) = happyShift action_53
action_45 (27) = happyShift action_54
action_45 (28) = happyShift action_55
action_45 (29) = happyShift action_56
action_45 (30) = happyShift action_57
action_45 (32) = happyShift action_58
action_45 (33) = happyShift action_59
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (16) = happyShift action_48
action_46 (17) = happyShift action_49
action_46 (18) = happyShift action_50
action_46 (19) = happyShift action_51
action_46 (21) = happyShift action_60
action_46 (25) = happyShift action_52
action_46 (26) = happyShift action_53
action_46 (27) = happyShift action_54
action_46 (28) = happyShift action_55
action_46 (29) = happyShift action_56
action_46 (30) = happyShift action_57
action_46 (32) = happyShift action_58
action_46 (33) = happyShift action_59
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (16) = happyShift action_48
action_47 (17) = happyShift action_49
action_47 (18) = happyShift action_50
action_47 (19) = happyShift action_51
action_47 (25) = happyShift action_52
action_47 (26) = happyShift action_53
action_47 (27) = happyShift action_54
action_47 (28) = happyShift action_55
action_47 (29) = happyShift action_56
action_47 (30) = happyShift action_57
action_47 (32) = happyShift action_58
action_47 (33) = happyShift action_59
action_47 _ = happyReduce_13

action_48 (15) = happyShift action_38
action_48 (20) = happyShift action_39
action_48 (31) = happyShift action_40
action_48 (34) = happyShift action_41
action_48 (35) = happyShift action_42
action_48 (46) = happyShift action_43
action_48 (10) = happyGoto action_86
action_48 (14) = happyGoto action_37
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (15) = happyShift action_38
action_49 (20) = happyShift action_39
action_49 (31) = happyShift action_40
action_49 (34) = happyShift action_41
action_49 (35) = happyShift action_42
action_49 (46) = happyShift action_43
action_49 (10) = happyGoto action_85
action_49 (14) = happyGoto action_37
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (15) = happyShift action_38
action_50 (20) = happyShift action_39
action_50 (31) = happyShift action_40
action_50 (34) = happyShift action_41
action_50 (35) = happyShift action_42
action_50 (46) = happyShift action_43
action_50 (10) = happyGoto action_84
action_50 (14) = happyGoto action_37
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (15) = happyShift action_38
action_51 (20) = happyShift action_39
action_51 (31) = happyShift action_40
action_51 (34) = happyShift action_41
action_51 (35) = happyShift action_42
action_51 (46) = happyShift action_43
action_51 (10) = happyGoto action_83
action_51 (14) = happyGoto action_37
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (15) = happyShift action_38
action_52 (20) = happyShift action_39
action_52 (31) = happyShift action_40
action_52 (34) = happyShift action_41
action_52 (35) = happyShift action_42
action_52 (46) = happyShift action_43
action_52 (10) = happyGoto action_82
action_52 (14) = happyGoto action_37
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (15) = happyShift action_38
action_53 (20) = happyShift action_39
action_53 (31) = happyShift action_40
action_53 (34) = happyShift action_41
action_53 (35) = happyShift action_42
action_53 (46) = happyShift action_43
action_53 (10) = happyGoto action_81
action_53 (14) = happyGoto action_37
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (15) = happyShift action_38
action_54 (20) = happyShift action_39
action_54 (31) = happyShift action_40
action_54 (34) = happyShift action_41
action_54 (35) = happyShift action_42
action_54 (46) = happyShift action_43
action_54 (10) = happyGoto action_80
action_54 (14) = happyGoto action_37
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (15) = happyShift action_38
action_55 (20) = happyShift action_39
action_55 (31) = happyShift action_40
action_55 (34) = happyShift action_41
action_55 (35) = happyShift action_42
action_55 (46) = happyShift action_43
action_55 (10) = happyGoto action_79
action_55 (14) = happyGoto action_37
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (15) = happyShift action_38
action_56 (20) = happyShift action_39
action_56 (31) = happyShift action_40
action_56 (34) = happyShift action_41
action_56 (35) = happyShift action_42
action_56 (46) = happyShift action_43
action_56 (10) = happyGoto action_78
action_56 (14) = happyGoto action_37
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (15) = happyShift action_38
action_57 (20) = happyShift action_39
action_57 (31) = happyShift action_40
action_57 (34) = happyShift action_41
action_57 (35) = happyShift action_42
action_57 (46) = happyShift action_43
action_57 (10) = happyGoto action_77
action_57 (14) = happyGoto action_37
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (15) = happyShift action_38
action_58 (20) = happyShift action_39
action_58 (31) = happyShift action_40
action_58 (34) = happyShift action_41
action_58 (35) = happyShift action_42
action_58 (46) = happyShift action_43
action_58 (10) = happyGoto action_76
action_58 (14) = happyGoto action_37
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (15) = happyShift action_38
action_59 (20) = happyShift action_39
action_59 (31) = happyShift action_40
action_59 (34) = happyShift action_41
action_59 (35) = happyShift action_42
action_59 (46) = happyShift action_43
action_59 (10) = happyGoto action_75
action_59 (14) = happyGoto action_37
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_10

action_61 _ = happyReduce_9

action_62 (22) = happyShift action_8
action_62 (36) = happyShift action_18
action_62 (37) = happyShift action_19
action_62 (38) = happyShift action_20
action_62 (40) = happyShift action_21
action_62 (41) = happyShift action_22
action_62 (42) = happyShift action_23
action_62 (46) = happyShift action_24
action_62 (5) = happyGoto action_9
action_62 (7) = happyGoto action_74
action_62 (8) = happyGoto action_12
action_62 (9) = happyGoto action_13
action_62 (11) = happyGoto action_14
action_62 (12) = happyGoto action_15
action_62 (13) = happyGoto action_16
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (16) = happyShift action_48
action_63 (17) = happyShift action_49
action_63 (18) = happyShift action_50
action_63 (19) = happyShift action_51
action_63 (25) = happyShift action_52
action_63 (26) = happyShift action_53
action_63 (27) = happyShift action_54
action_63 (28) = happyShift action_55
action_63 (29) = happyShift action_56
action_63 (30) = happyShift action_57
action_63 (32) = happyShift action_58
action_63 (33) = happyShift action_59
action_63 _ = happyReduce_30

action_64 (16) = happyShift action_48
action_64 (17) = happyShift action_49
action_64 (18) = happyShift action_50
action_64 (19) = happyShift action_51
action_64 (21) = happyShift action_73
action_64 (25) = happyShift action_52
action_64 (26) = happyShift action_53
action_64 (27) = happyShift action_54
action_64 (28) = happyShift action_55
action_64 (29) = happyShift action_56
action_64 (30) = happyShift action_57
action_64 (32) = happyShift action_58
action_64 (33) = happyShift action_59
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (22) = happyShift action_8
action_65 (36) = happyShift action_18
action_65 (37) = happyShift action_19
action_65 (38) = happyShift action_20
action_65 (40) = happyShift action_21
action_65 (41) = happyShift action_22
action_65 (42) = happyShift action_23
action_65 (46) = happyShift action_24
action_65 (5) = happyGoto action_9
action_65 (7) = happyGoto action_72
action_65 (8) = happyGoto action_12
action_65 (9) = happyGoto action_13
action_65 (11) = happyGoto action_14
action_65 (12) = happyGoto action_15
action_65 (13) = happyGoto action_16
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (16) = happyShift action_48
action_66 (17) = happyShift action_49
action_66 (18) = happyShift action_50
action_66 (19) = happyShift action_51
action_66 (25) = happyShift action_52
action_66 (26) = happyShift action_53
action_66 (27) = happyShift action_54
action_66 (28) = happyShift action_55
action_66 (29) = happyShift action_56
action_66 (30) = happyShift action_57
action_66 (32) = happyShift action_58
action_66 (33) = happyShift action_59
action_66 _ = happyReduce_33

action_67 (20) = happyShift action_71
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (16) = happyShift action_48
action_68 (17) = happyShift action_49
action_68 (18) = happyShift action_50
action_68 (19) = happyShift action_51
action_68 (25) = happyShift action_52
action_68 (26) = happyShift action_53
action_68 (27) = happyShift action_54
action_68 (28) = happyShift action_55
action_68 (29) = happyShift action_56
action_68 (30) = happyShift action_57
action_68 (32) = happyShift action_58
action_68 (33) = happyShift action_59
action_68 _ = happyReduce_32

action_69 (20) = happyShift action_70
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (21) = happyShift action_89
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (21) = happyShift action_88
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (39) = happyShift action_87
action_72 _ = happyReduce_16

action_73 _ = happyReduce_40

action_74 _ = happyReduce_17

action_75 (16) = happyShift action_48
action_75 (17) = happyShift action_49
action_75 (18) = happyShift action_50
action_75 (19) = happyShift action_51
action_75 (25) = happyFail []
action_75 (26) = happyFail []
action_75 (27) = happyFail []
action_75 (28) = happyFail []
action_75 (29) = happyFail []
action_75 (30) = happyFail []
action_75 (32) = happyFail []
action_75 (33) = happyFail []
action_75 _ = happyReduce_29

action_76 (16) = happyShift action_48
action_76 (17) = happyShift action_49
action_76 (18) = happyShift action_50
action_76 (19) = happyShift action_51
action_76 (25) = happyFail []
action_76 (26) = happyFail []
action_76 (27) = happyFail []
action_76 (28) = happyFail []
action_76 (29) = happyFail []
action_76 (30) = happyFail []
action_76 (32) = happyFail []
action_76 (33) = happyFail []
action_76 _ = happyReduce_28

action_77 (16) = happyShift action_48
action_77 (17) = happyShift action_49
action_77 (18) = happyShift action_50
action_77 (19) = happyShift action_51
action_77 (25) = happyFail []
action_77 (26) = happyFail []
action_77 (27) = happyFail []
action_77 (28) = happyFail []
action_77 (29) = happyFail []
action_77 (30) = happyFail []
action_77 (32) = happyFail []
action_77 (33) = happyFail []
action_77 _ = happyReduce_27

action_78 (16) = happyShift action_48
action_78 (17) = happyShift action_49
action_78 (18) = happyShift action_50
action_78 (19) = happyShift action_51
action_78 (25) = happyFail []
action_78 (26) = happyFail []
action_78 (27) = happyFail []
action_78 (28) = happyFail []
action_78 (29) = happyFail []
action_78 (30) = happyFail []
action_78 (32) = happyFail []
action_78 (33) = happyFail []
action_78 _ = happyReduce_26

action_79 (16) = happyShift action_48
action_79 (17) = happyShift action_49
action_79 (18) = happyShift action_50
action_79 (19) = happyShift action_51
action_79 (25) = happyFail []
action_79 (26) = happyFail []
action_79 (27) = happyFail []
action_79 (28) = happyFail []
action_79 (29) = happyFail []
action_79 (30) = happyFail []
action_79 (32) = happyFail []
action_79 (33) = happyFail []
action_79 _ = happyReduce_25

action_80 (16) = happyShift action_48
action_80 (17) = happyShift action_49
action_80 (18) = happyShift action_50
action_80 (19) = happyShift action_51
action_80 (25) = happyFail []
action_80 (26) = happyFail []
action_80 (27) = happyFail []
action_80 (28) = happyFail []
action_80 (29) = happyFail []
action_80 (30) = happyFail []
action_80 (32) = happyFail []
action_80 (33) = happyFail []
action_80 _ = happyReduce_24

action_81 (16) = happyShift action_48
action_81 (17) = happyShift action_49
action_81 (18) = happyShift action_50
action_81 (19) = happyShift action_51
action_81 (25) = happyFail []
action_81 (26) = happyFail []
action_81 (27) = happyFail []
action_81 (28) = happyFail []
action_81 (29) = happyFail []
action_81 (30) = happyFail []
action_81 (32) = happyFail []
action_81 (33) = happyFail []
action_81 _ = happyReduce_23

action_82 (16) = happyShift action_48
action_82 (17) = happyShift action_49
action_82 (18) = happyShift action_50
action_82 (19) = happyShift action_51
action_82 (25) = happyFail []
action_82 (26) = happyFail []
action_82 (27) = happyFail []
action_82 (28) = happyFail []
action_82 (29) = happyFail []
action_82 (30) = happyFail []
action_82 (32) = happyFail []
action_82 (33) = happyFail []
action_82 _ = happyReduce_22

action_83 _ = happyReduce_21

action_84 _ = happyReduce_20

action_85 (18) = happyShift action_50
action_85 (19) = happyShift action_51
action_85 _ = happyReduce_19

action_86 (18) = happyShift action_50
action_86 (19) = happyShift action_51
action_86 _ = happyReduce_18

action_87 (22) = happyShift action_8
action_87 (36) = happyShift action_18
action_87 (37) = happyShift action_19
action_87 (38) = happyShift action_20
action_87 (40) = happyShift action_21
action_87 (41) = happyShift action_22
action_87 (42) = happyShift action_23
action_87 (46) = happyShift action_24
action_87 (5) = happyGoto action_9
action_87 (7) = happyGoto action_90
action_87 (8) = happyGoto action_12
action_87 (9) = happyGoto action_13
action_87 (11) = happyGoto action_14
action_87 (12) = happyGoto action_15
action_87 (13) = happyGoto action_16
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_35

action_89 _ = happyReduce_34

action_90 _ = happyReduce_15

happyReduce_1 = happyReduce 5 4 happyReduction_1
happyReduction_1 ((HappyAbsSyn5  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Program [happy_var_5]
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_3  5 happyReduction_2
happyReduction_2 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Block happy_var_2
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 _
	_
	 =  HappyAbsSyn5
		 (Block []
	)

happyReduce_4 = happySpecReduce_2  6 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_0  6 happyReduction_5
happyReduction_5  =  HappyAbsSyn6
		 ([]
	)

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  7 happyReduction_7
happyReduction_7 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happyReduce 4 7 happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Print happy_var_3
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 4 7 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (PrintLn happy_var_3
	) `HappyStk` happyRest

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  7 happyReduction_12
happyReduction_12 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 (HappyAbsSyn10  happy_var_3)
	_
	(HappyTerminal (TOK_ID happy_var_1))
	 =  HappyAbsSyn7
		 (Assign (Var happy_var_1) happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  7 happyReduction_14
happyReduction_14 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happyReduce 7 8 happyReduction_15
happyReduction_15 ((HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (IfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 5 8 happyReduction_16
happyReduction_16 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (If happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 5 9 happyReduction_17
happyReduction_17 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_3  10 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Add happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  10 happyReduction_19
happyReduction_19 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  10 happyReduction_20
happyReduction_20 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  10 happyReduction_21
happyReduction_21 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Div happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  10 happyReduction_22
happyReduction_22 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Eq happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  10 happyReduction_23
happyReduction_23 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (NotEq happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  10 happyReduction_24
happyReduction_24 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Less happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  10 happyReduction_25
happyReduction_25 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (LessEq happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  10 happyReduction_26
happyReduction_26 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Greater happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  10 happyReduction_27
happyReduction_27 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (GreaterEq happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  10 happyReduction_28
happyReduction_28 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Or happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  10 happyReduction_29
happyReduction_29 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (And happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  10 happyReduction_30
happyReduction_30 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Not happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  10 happyReduction_31
happyReduction_31 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happyReduce 4 11 happyReduction_32
happyReduction_32 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TOK_ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (VarDecl happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 4 12 happyReduction_33
happyReduction_33 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TOK_ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ValDecl happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 6 13 happyReduction_34
happyReduction_34 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TOK_ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (ReadLine happy_var_2
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 6 13 happyReduction_35
happyReduction_35 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TOK_ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (ReadLine happy_var_2
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_1  14 happyReduction_36
happyReduction_36 (HappyTerminal (TOK_NUM happy_var_1))
	 =  HappyAbsSyn14
		 (Num happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  14 happyReduction_37
happyReduction_37 (HappyTerminal (TOK_ID happy_var_1))
	 =  HappyAbsSyn14
		 (Var happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  14 happyReduction_38
happyReduction_38 _
	 =  HappyAbsSyn14
		 (Bool True
	)

happyReduce_39 = happySpecReduce_1  14 happyReduction_39
happyReduction_39 _
	 =  HappyAbsSyn14
		 (Bool False
	)

happyReduce_40 = happySpecReduce_3  14 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 47 47 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TOK_NUM happy_dollar_dollar -> cont 15;
	TOK_PLUS -> cont 16;
	TOK_MINUS -> cont 17;
	TOK_MULT -> cont 18;
	TOK_DIV -> cont 19;
	TOK_LPAREN -> cont 20;
	TOK_RPAREN -> cont 21;
	TOK_LBRACE -> cont 22;
	TOK_RBRACE -> cont 23;
	TOK_DEF -> cont 24;
	TOK_EQ -> cont 25;
	TOK_NOTEQ -> cont 26;
	TOK_LESS -> cont 27;
	TOK_LESSEQ -> cont 28;
	TOK_GREATER -> cont 29;
	TOK_GREATEREQ -> cont 30;
	TOK_NOT -> cont 31;
	TOK_OR -> cont 32;
	TOK_AND -> cont 33;
	TOK_TRUE -> cont 34;
	TOK_FALSE -> cont 35;
	TOK_VAR -> cont 36;
	TOK_VAL -> cont 37;
	TOK_IF -> cont 38;
	TOK_ELSE -> cont 39;
	TOK_WHILE -> cont 40;
	TOK_PRINT -> cont 41;
	TOK_PRINTLN -> cont 42;
	TOK_FUN -> cont 43;
	TOK_MAIN -> cont 44;
	TOK_READLN -> cont 45;
	TOK_ID happy_dollar_dollar -> cont 46;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 47 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

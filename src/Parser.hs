{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import DataTypes
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.11

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27
	= HappyTerminal (Token)
	| HappyErrorToken Int
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
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,343) ([0,2048,0,0,0,0,256,0,0,0,0,256,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,128,0,0,384,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,256,0,0,0,0,32,0,0,0,32768,1,0,0,0,0,0,2,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,32,0,0,0,0,0,0,0,10240,6149,0,0,0,0,512,0,0,0,5280,96,0,0,0,0,8192,0,0,0,0,2,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,40960,24596,0,0,0,0,30744,128,8,0,0,3843,16,1,0,0,32,0,0,0,0,0,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,1,0,0,0,8192,0,0,0,0,16384,16,0,0,0,0,0,0,0,0,8192,0,0,0,0,2080,0,0,0,3840,0,0,0,0,0,0,0,0,0,3843,16,1,0,24576,480,8194,0,0,0,0,2048,0,0,16,64512,127,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,320,0,0,0,0,0,0,0,0,0,0,0,0,0,15372,64,4,0,32768,1921,32776,0,0,12288,240,4097,0,0,8,61440,511,0,0,0,0,0,0,2048,0,32,0,0,0,3843,16,1,0,0,0,0,0,0,0,57344,1023,0,0,0,0,0,0,10240,6149,0,0,0,42240,768,0,0,0,49152,960,16388,0,0,6144,32888,2048,0,0,768,4111,256,0,0,57440,513,32,0,0,15372,64,4,0,32768,1921,32776,0,0,12288,240,4097,0,0,1536,8222,512,0,0,49344,1027,64,0,0,30744,128,8,0,0,3843,16,1,0,24576,480,8194,0,0,3072,16444,1024,0,0,0,0,0,0,0,0,3584,4,0,0,8192,65520,1,0,49152,960,16388,0,0,660,12,0,0,0,768,4111,256,0,0,0,65288,31,0,0,0,65504,3,0,0,18432,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,2048,0,0,0,32768,0,0,0,0,960,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1920,0,0,0,0,3072,0,0,0,0,0,0,0,0,0,0,0,0,0,1536,8222,512,0,0,0,0,0,0,0,4,65472,7,0,0,0,0,0,0,0,4608,0,0,0,0,0,0,0,0,0,28672,32,0,0,0,0,0,0,0,0,33264,1,0,0,0,12350,0,0,0,49152,1543,0,0,0,63488,192,0,0,0,7936,24,0,0,0,992,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14336,16,0,0,0,1792,2,0,0,0,0,0,0,0,0,0,0,0,330,6,0,0,0,0,0,0,0,0,61488,256,16,0,0,0,65520,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,384,0,0,0,512,32768,4095,0,0,0,0,0,0,40960,24596,0,0,0,0,0,2,0,0,0,64,0,0,0,0,0,0,0,0,61440,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Prog","ProgHeader","ProgBody","ConstDecls","VarDecls","ConstDefSeq","VarDefSeq","ConstDef","VarDef","Type","BasicType","Const","Expr","VarAccess","ExprList","Stm","StmList","Proc","ProcHeader","ProcBody","ProcDecls","ProcDefSeq","ParamList","Param","program","function","procedure","const","var","begin","end","if","then","else","while","do","for","to","true","false","integer","boolean","string","array","of","break","identifier","numeral","str","'('","')'","'['","']'","','","'.'","':'","';'","'+'","'-'","'*'","'div'","'mod'","'='","'<>'","'<'","'<='","'>'","'>='","'and'","'or'","'not'","':='","'..'","%eof"]
        bit_start = st * 77
        bit_end = (st + 1) * 77
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..76]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (28) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_2
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (28) = happyShift action_3
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (31) = happyShift action_8
action_2 (6) = happyGoto action_6
action_2 (7) = happyGoto action_7
action_2 _ = happyReduce_5

action_3 (50) = happyShift action_5
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (77) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (60) = happyShift action_19
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (58) = happyShift action_18
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (29) = happyShift action_16
action_7 (30) = happyShift action_17
action_7 (21) = happyGoto action_12
action_7 (22) = happyGoto action_13
action_7 (24) = happyGoto action_14
action_7 (25) = happyGoto action_15
action_7 _ = happyReduce_63

action_8 (50) = happyShift action_11
action_8 (9) = happyGoto action_9
action_8 (11) = happyGoto action_10
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_4

action_10 (50) = happyShift action_11
action_10 (9) = happyGoto action_28
action_10 (11) = happyGoto action_10
action_10 _ = happyReduce_8

action_11 (66) = happyShift action_27
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_64

action_13 (32) = happyShift action_24
action_13 (8) = happyGoto action_25
action_13 (23) = happyGoto action_26
action_13 _ = happyReduce_7

action_14 (32) = happyShift action_24
action_14 (8) = happyGoto action_23
action_14 _ = happyReduce_7

action_15 (29) = happyShift action_16
action_15 (30) = happyShift action_17
action_15 (21) = happyGoto action_22
action_15 (22) = happyGoto action_13
action_15 _ = happyReduce_62

action_16 (50) = happyShift action_21
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (50) = happyShift action_20
action_17 _ = happyFail (happyExpListPerState 17)

action_18 _ = happyReduce_1

action_19 _ = happyReduce_2

action_20 (53) = happyShift action_44
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (53) = happyShift action_43
action_21 _ = happyFail (happyExpListPerState 21)

action_22 _ = happyReduce_65

action_23 (33) = happyShift action_33
action_23 (35) = happyShift action_34
action_23 (38) = happyShift action_35
action_23 (40) = happyShift action_36
action_23 (49) = happyShift action_37
action_23 (50) = happyShift action_38
action_23 (17) = happyGoto action_31
action_23 (19) = happyGoto action_42
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (50) = happyShift action_41
action_24 (10) = happyGoto action_39
action_24 (12) = happyGoto action_40
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (33) = happyShift action_33
action_25 (35) = happyShift action_34
action_25 (38) = happyShift action_35
action_25 (40) = happyShift action_36
action_25 (49) = happyShift action_37
action_25 (50) = happyShift action_38
action_25 (17) = happyGoto action_31
action_25 (19) = happyGoto action_32
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (60) = happyShift action_30
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (51) = happyShift action_29
action_27 _ = happyFail (happyExpListPerState 27)

action_28 _ = happyReduce_9

action_29 (60) = happyShift action_68
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_58

action_31 (75) = happyShift action_67
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_61

action_33 (33) = happyShift action_33
action_33 (35) = happyShift action_34
action_33 (38) = happyShift action_35
action_33 (40) = happyShift action_36
action_33 (49) = happyShift action_37
action_33 (50) = happyShift action_38
action_33 (17) = happyGoto action_31
action_33 (19) = happyGoto action_65
action_33 (20) = happyGoto action_66
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (42) = happyShift action_56
action_34 (43) = happyShift action_57
action_34 (50) = happyShift action_58
action_34 (51) = happyShift action_59
action_34 (52) = happyShift action_60
action_34 (53) = happyShift action_61
action_34 (62) = happyShift action_62
action_34 (74) = happyShift action_63
action_34 (16) = happyGoto action_64
action_34 (17) = happyGoto action_55
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (42) = happyShift action_56
action_35 (43) = happyShift action_57
action_35 (50) = happyShift action_58
action_35 (51) = happyShift action_59
action_35 (52) = happyShift action_60
action_35 (53) = happyShift action_61
action_35 (62) = happyShift action_62
action_35 (74) = happyShift action_63
action_35 (16) = happyGoto action_54
action_35 (17) = happyGoto action_55
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (50) = happyShift action_53
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_53

action_38 (53) = happyShift action_51
action_38 (55) = happyShift action_52
action_38 _ = happyReduce_43

action_39 _ = happyReduce_6

action_40 (50) = happyShift action_41
action_40 (10) = happyGoto action_50
action_40 (12) = happyGoto action_40
action_40 _ = happyReduce_10

action_41 (59) = happyShift action_49
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_3

action_43 (50) = happyShift action_47
action_43 (26) = happyGoto action_48
action_43 (27) = happyGoto action_46
action_43 _ = happyReduce_66

action_44 (50) = happyShift action_47
action_44 (26) = happyGoto action_45
action_44 (27) = happyGoto action_46
action_44 _ = happyReduce_66

action_45 (54) = happyShift action_104
action_45 (60) = happyShift action_102
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_67

action_47 (59) = happyShift action_103
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (54) = happyShift action_101
action_48 (60) = happyShift action_102
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (44) = happyShift action_97
action_49 (45) = happyShift action_98
action_49 (46) = happyShift action_99
action_49 (47) = happyShift action_100
action_49 (13) = happyGoto action_95
action_49 (14) = happyGoto action_96
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_11

action_51 (42) = happyShift action_56
action_51 (43) = happyShift action_57
action_51 (50) = happyShift action_58
action_51 (51) = happyShift action_59
action_51 (52) = happyShift action_60
action_51 (53) = happyShift action_61
action_51 (62) = happyShift action_62
action_51 (74) = happyShift action_63
action_51 (16) = happyGoto action_93
action_51 (17) = happyGoto action_55
action_51 (18) = happyGoto action_94
action_51 _ = happyReduce_45

action_52 (42) = happyShift action_56
action_52 (43) = happyShift action_57
action_52 (50) = happyShift action_58
action_52 (51) = happyShift action_59
action_52 (52) = happyShift action_60
action_52 (53) = happyShift action_61
action_52 (62) = happyShift action_62
action_52 (74) = happyShift action_63
action_52 (16) = happyGoto action_92
action_52 (17) = happyGoto action_55
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (75) = happyShift action_91
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (39) = happyShift action_90
action_54 (61) = happyShift action_73
action_54 (62) = happyShift action_74
action_54 (63) = happyShift action_75
action_54 (64) = happyShift action_76
action_54 (65) = happyShift action_77
action_54 (66) = happyShift action_78
action_54 (67) = happyShift action_79
action_54 (68) = happyShift action_80
action_54 (69) = happyShift action_81
action_54 (70) = happyShift action_82
action_54 (71) = happyShift action_83
action_54 (72) = happyShift action_84
action_54 (73) = happyShift action_85
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_25

action_56 _ = happyReduce_23

action_57 _ = happyReduce_24

action_58 (53) = happyShift action_89
action_58 (55) = happyShift action_52
action_58 _ = happyReduce_43

action_59 _ = happyReduce_21

action_60 _ = happyReduce_22

action_61 (42) = happyShift action_56
action_61 (43) = happyShift action_57
action_61 (50) = happyShift action_58
action_61 (51) = happyShift action_59
action_61 (52) = happyShift action_60
action_61 (53) = happyShift action_61
action_61 (62) = happyShift action_62
action_61 (74) = happyShift action_63
action_61 (16) = happyGoto action_88
action_61 (17) = happyGoto action_55
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (42) = happyShift action_56
action_62 (43) = happyShift action_57
action_62 (50) = happyShift action_58
action_62 (51) = happyShift action_59
action_62 (52) = happyShift action_60
action_62 (53) = happyShift action_61
action_62 (62) = happyShift action_62
action_62 (74) = happyShift action_63
action_62 (16) = happyGoto action_87
action_62 (17) = happyGoto action_55
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (42) = happyShift action_56
action_63 (43) = happyShift action_57
action_63 (50) = happyShift action_58
action_63 (51) = happyShift action_59
action_63 (52) = happyShift action_60
action_63 (53) = happyShift action_61
action_63 (62) = happyShift action_62
action_63 (74) = happyShift action_63
action_63 (16) = happyGoto action_86
action_63 (17) = happyGoto action_55
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (36) = happyShift action_72
action_64 (61) = happyShift action_73
action_64 (62) = happyShift action_74
action_64 (63) = happyShift action_75
action_64 (64) = happyShift action_76
action_64 (65) = happyShift action_77
action_64 (66) = happyShift action_78
action_64 (67) = happyShift action_79
action_64 (68) = happyShift action_80
action_64 (69) = happyShift action_81
action_64 (70) = happyShift action_82
action_64 (71) = happyShift action_83
action_64 (72) = happyShift action_84
action_64 (73) = happyShift action_85
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_56

action_66 (34) = happyShift action_70
action_66 (60) = happyShift action_71
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (42) = happyShift action_56
action_67 (43) = happyShift action_57
action_67 (50) = happyShift action_58
action_67 (51) = happyShift action_59
action_67 (52) = happyShift action_60
action_67 (53) = happyShift action_61
action_67 (62) = happyShift action_62
action_67 (74) = happyShift action_63
action_67 (16) = happyGoto action_69
action_67 (17) = happyGoto action_55
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_12

action_69 (61) = happyShift action_73
action_69 (62) = happyShift action_74
action_69 (63) = happyShift action_75
action_69 (64) = happyShift action_76
action_69 (65) = happyShift action_77
action_69 (66) = happyShift action_78
action_69 (67) = happyShift action_79
action_69 (68) = happyShift action_80
action_69 (69) = happyShift action_81
action_69 (70) = happyShift action_82
action_69 (71) = happyShift action_83
action_69 (72) = happyShift action_84
action_69 (73) = happyShift action_85
action_69 _ = happyReduce_48

action_70 _ = happyReduce_55

action_71 (33) = happyShift action_33
action_71 (35) = happyShift action_34
action_71 (38) = happyShift action_35
action_71 (40) = happyShift action_36
action_71 (49) = happyShift action_37
action_71 (50) = happyShift action_38
action_71 (17) = happyGoto action_31
action_71 (19) = happyGoto action_132
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (33) = happyShift action_33
action_72 (35) = happyShift action_34
action_72 (38) = happyShift action_35
action_72 (40) = happyShift action_36
action_72 (49) = happyShift action_37
action_72 (50) = happyShift action_38
action_72 (17) = happyGoto action_31
action_72 (19) = happyGoto action_131
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (42) = happyShift action_56
action_73 (43) = happyShift action_57
action_73 (50) = happyShift action_58
action_73 (51) = happyShift action_59
action_73 (52) = happyShift action_60
action_73 (53) = happyShift action_61
action_73 (62) = happyShift action_62
action_73 (74) = happyShift action_63
action_73 (16) = happyGoto action_130
action_73 (17) = happyGoto action_55
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (42) = happyShift action_56
action_74 (43) = happyShift action_57
action_74 (50) = happyShift action_58
action_74 (51) = happyShift action_59
action_74 (52) = happyShift action_60
action_74 (53) = happyShift action_61
action_74 (62) = happyShift action_62
action_74 (74) = happyShift action_63
action_74 (16) = happyGoto action_129
action_74 (17) = happyGoto action_55
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (42) = happyShift action_56
action_75 (43) = happyShift action_57
action_75 (50) = happyShift action_58
action_75 (51) = happyShift action_59
action_75 (52) = happyShift action_60
action_75 (53) = happyShift action_61
action_75 (62) = happyShift action_62
action_75 (74) = happyShift action_63
action_75 (16) = happyGoto action_128
action_75 (17) = happyGoto action_55
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (42) = happyShift action_56
action_76 (43) = happyShift action_57
action_76 (50) = happyShift action_58
action_76 (51) = happyShift action_59
action_76 (52) = happyShift action_60
action_76 (53) = happyShift action_61
action_76 (62) = happyShift action_62
action_76 (74) = happyShift action_63
action_76 (16) = happyGoto action_127
action_76 (17) = happyGoto action_55
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (42) = happyShift action_56
action_77 (43) = happyShift action_57
action_77 (50) = happyShift action_58
action_77 (51) = happyShift action_59
action_77 (52) = happyShift action_60
action_77 (53) = happyShift action_61
action_77 (62) = happyShift action_62
action_77 (74) = happyShift action_63
action_77 (16) = happyGoto action_126
action_77 (17) = happyGoto action_55
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (42) = happyShift action_56
action_78 (43) = happyShift action_57
action_78 (50) = happyShift action_58
action_78 (51) = happyShift action_59
action_78 (52) = happyShift action_60
action_78 (53) = happyShift action_61
action_78 (62) = happyShift action_62
action_78 (74) = happyShift action_63
action_78 (16) = happyGoto action_125
action_78 (17) = happyGoto action_55
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (42) = happyShift action_56
action_79 (43) = happyShift action_57
action_79 (50) = happyShift action_58
action_79 (51) = happyShift action_59
action_79 (52) = happyShift action_60
action_79 (53) = happyShift action_61
action_79 (62) = happyShift action_62
action_79 (74) = happyShift action_63
action_79 (16) = happyGoto action_124
action_79 (17) = happyGoto action_55
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (42) = happyShift action_56
action_80 (43) = happyShift action_57
action_80 (50) = happyShift action_58
action_80 (51) = happyShift action_59
action_80 (52) = happyShift action_60
action_80 (53) = happyShift action_61
action_80 (62) = happyShift action_62
action_80 (74) = happyShift action_63
action_80 (16) = happyGoto action_123
action_80 (17) = happyGoto action_55
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (42) = happyShift action_56
action_81 (43) = happyShift action_57
action_81 (50) = happyShift action_58
action_81 (51) = happyShift action_59
action_81 (52) = happyShift action_60
action_81 (53) = happyShift action_61
action_81 (62) = happyShift action_62
action_81 (74) = happyShift action_63
action_81 (16) = happyGoto action_122
action_81 (17) = happyGoto action_55
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (42) = happyShift action_56
action_82 (43) = happyShift action_57
action_82 (50) = happyShift action_58
action_82 (51) = happyShift action_59
action_82 (52) = happyShift action_60
action_82 (53) = happyShift action_61
action_82 (62) = happyShift action_62
action_82 (74) = happyShift action_63
action_82 (16) = happyGoto action_121
action_82 (17) = happyGoto action_55
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (42) = happyShift action_56
action_83 (43) = happyShift action_57
action_83 (50) = happyShift action_58
action_83 (51) = happyShift action_59
action_83 (52) = happyShift action_60
action_83 (53) = happyShift action_61
action_83 (62) = happyShift action_62
action_83 (74) = happyShift action_63
action_83 (16) = happyGoto action_120
action_83 (17) = happyGoto action_55
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (42) = happyShift action_56
action_84 (43) = happyShift action_57
action_84 (50) = happyShift action_58
action_84 (51) = happyShift action_59
action_84 (52) = happyShift action_60
action_84 (53) = happyShift action_61
action_84 (62) = happyShift action_62
action_84 (74) = happyShift action_63
action_84 (16) = happyGoto action_119
action_84 (17) = happyGoto action_55
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (42) = happyShift action_56
action_85 (43) = happyShift action_57
action_85 (50) = happyShift action_58
action_85 (51) = happyShift action_59
action_85 (52) = happyShift action_60
action_85 (53) = happyShift action_61
action_85 (62) = happyShift action_62
action_85 (74) = happyShift action_63
action_85 (16) = happyGoto action_118
action_85 (17) = happyGoto action_55
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_39

action_87 (63) = happyShift action_75
action_87 (64) = happyShift action_76
action_87 (65) = happyShift action_77
action_87 (72) = happyShift action_84
action_87 _ = happyReduce_40

action_88 (54) = happyShift action_117
action_88 (61) = happyShift action_73
action_88 (62) = happyShift action_74
action_88 (63) = happyShift action_75
action_88 (64) = happyShift action_76
action_88 (65) = happyShift action_77
action_88 (66) = happyShift action_78
action_88 (67) = happyShift action_79
action_88 (68) = happyShift action_80
action_88 (69) = happyShift action_81
action_88 (70) = happyShift action_82
action_88 (71) = happyShift action_83
action_88 (72) = happyShift action_84
action_88 (73) = happyShift action_85
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (42) = happyShift action_56
action_89 (43) = happyShift action_57
action_89 (50) = happyShift action_58
action_89 (51) = happyShift action_59
action_89 (52) = happyShift action_60
action_89 (53) = happyShift action_61
action_89 (62) = happyShift action_62
action_89 (74) = happyShift action_63
action_89 (16) = happyGoto action_93
action_89 (17) = happyGoto action_55
action_89 (18) = happyGoto action_116
action_89 _ = happyReduce_45

action_90 (33) = happyShift action_33
action_90 (35) = happyShift action_34
action_90 (38) = happyShift action_35
action_90 (40) = happyShift action_36
action_90 (49) = happyShift action_37
action_90 (50) = happyShift action_38
action_90 (17) = happyGoto action_31
action_90 (19) = happyGoto action_115
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (42) = happyShift action_56
action_91 (43) = happyShift action_57
action_91 (50) = happyShift action_58
action_91 (51) = happyShift action_59
action_91 (52) = happyShift action_60
action_91 (53) = happyShift action_61
action_91 (62) = happyShift action_62
action_91 (74) = happyShift action_63
action_91 (16) = happyGoto action_114
action_91 (17) = happyGoto action_55
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (56) = happyShift action_113
action_92 (61) = happyShift action_73
action_92 (62) = happyShift action_74
action_92 (63) = happyShift action_75
action_92 (64) = happyShift action_76
action_92 (65) = happyShift action_77
action_92 (66) = happyShift action_78
action_92 (67) = happyShift action_79
action_92 (68) = happyShift action_80
action_92 (69) = happyShift action_81
action_92 (70) = happyShift action_82
action_92 (71) = happyShift action_83
action_92 (72) = happyShift action_84
action_92 (73) = happyShift action_85
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (61) = happyShift action_73
action_93 (62) = happyShift action_74
action_93 (63) = happyShift action_75
action_93 (64) = happyShift action_76
action_93 (65) = happyShift action_77
action_93 (66) = happyShift action_78
action_93 (67) = happyShift action_79
action_93 (68) = happyShift action_80
action_93 (69) = happyShift action_81
action_93 (70) = happyShift action_82
action_93 (71) = happyShift action_83
action_93 (72) = happyShift action_84
action_93 (73) = happyShift action_85
action_93 _ = happyReduce_46

action_94 (54) = happyShift action_111
action_94 (57) = happyShift action_112
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (60) = happyShift action_110
action_95 _ = happyFail (happyExpListPerState 95)

action_96 _ = happyReduce_14

action_97 _ = happyReduce_16

action_98 _ = happyReduce_17

action_99 _ = happyReduce_18

action_100 (55) = happyShift action_109
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (59) = happyShift action_108
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (50) = happyShift action_47
action_102 (27) = happyGoto action_107
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (44) = happyShift action_97
action_103 (45) = happyShift action_98
action_103 (46) = happyShift action_99
action_103 (47) = happyShift action_100
action_103 (13) = happyGoto action_106
action_103 (14) = happyGoto action_96
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (60) = happyShift action_105
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_59

action_106 _ = happyReduce_69

action_107 _ = happyReduce_68

action_108 (44) = happyShift action_97
action_108 (45) = happyShift action_98
action_108 (46) = happyShift action_99
action_108 (47) = happyShift action_100
action_108 (13) = happyGoto action_140
action_108 (14) = happyGoto action_96
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (50) = happyShift action_138
action_109 (51) = happyShift action_139
action_109 (15) = happyGoto action_137
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_13

action_111 _ = happyReduce_54

action_112 (42) = happyShift action_56
action_112 (43) = happyShift action_57
action_112 (50) = happyShift action_58
action_112 (51) = happyShift action_59
action_112 (52) = happyShift action_60
action_112 (53) = happyShift action_61
action_112 (62) = happyShift action_62
action_112 (74) = happyShift action_63
action_112 (16) = happyGoto action_136
action_112 (17) = happyGoto action_55
action_112 _ = happyFail (happyExpListPerState 112)

action_113 _ = happyReduce_44

action_114 (41) = happyShift action_135
action_114 (61) = happyShift action_73
action_114 (62) = happyShift action_74
action_114 (63) = happyShift action_75
action_114 (64) = happyShift action_76
action_114 (65) = happyShift action_77
action_114 (66) = happyShift action_78
action_114 (67) = happyShift action_79
action_114 (68) = happyShift action_80
action_114 (69) = happyShift action_81
action_114 (70) = happyShift action_82
action_114 (71) = happyShift action_83
action_114 (72) = happyShift action_84
action_114 (73) = happyShift action_85
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_51

action_116 (54) = happyShift action_134
action_116 (57) = happyShift action_112
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_41

action_118 (63) = happyShift action_75
action_118 (64) = happyShift action_76
action_118 (65) = happyShift action_77
action_118 (72) = happyShift action_84
action_118 _ = happyReduce_38

action_119 _ = happyReduce_37

action_120 (61) = happyShift action_73
action_120 (62) = happyShift action_74
action_120 (63) = happyShift action_75
action_120 (64) = happyShift action_76
action_120 (65) = happyShift action_77
action_120 (66) = happyFail []
action_120 (67) = happyFail []
action_120 (68) = happyFail []
action_120 (69) = happyFail []
action_120 (70) = happyFail []
action_120 (71) = happyFail []
action_120 (72) = happyShift action_84
action_120 (73) = happyShift action_85
action_120 _ = happyReduce_36

action_121 (61) = happyShift action_73
action_121 (62) = happyShift action_74
action_121 (63) = happyShift action_75
action_121 (64) = happyShift action_76
action_121 (65) = happyShift action_77
action_121 (66) = happyFail []
action_121 (67) = happyFail []
action_121 (68) = happyFail []
action_121 (69) = happyFail []
action_121 (70) = happyFail []
action_121 (71) = happyFail []
action_121 (72) = happyShift action_84
action_121 (73) = happyShift action_85
action_121 _ = happyReduce_35

action_122 (61) = happyShift action_73
action_122 (62) = happyShift action_74
action_122 (63) = happyShift action_75
action_122 (64) = happyShift action_76
action_122 (65) = happyShift action_77
action_122 (66) = happyFail []
action_122 (67) = happyFail []
action_122 (68) = happyFail []
action_122 (69) = happyFail []
action_122 (70) = happyFail []
action_122 (71) = happyFail []
action_122 (72) = happyShift action_84
action_122 (73) = happyShift action_85
action_122 _ = happyReduce_34

action_123 (61) = happyShift action_73
action_123 (62) = happyShift action_74
action_123 (63) = happyShift action_75
action_123 (64) = happyShift action_76
action_123 (65) = happyShift action_77
action_123 (66) = happyFail []
action_123 (67) = happyFail []
action_123 (68) = happyFail []
action_123 (69) = happyFail []
action_123 (70) = happyFail []
action_123 (71) = happyFail []
action_123 (72) = happyShift action_84
action_123 (73) = happyShift action_85
action_123 _ = happyReduce_33

action_124 (61) = happyShift action_73
action_124 (62) = happyShift action_74
action_124 (63) = happyShift action_75
action_124 (64) = happyShift action_76
action_124 (65) = happyShift action_77
action_124 (66) = happyFail []
action_124 (67) = happyFail []
action_124 (68) = happyFail []
action_124 (69) = happyFail []
action_124 (70) = happyFail []
action_124 (71) = happyFail []
action_124 (72) = happyShift action_84
action_124 (73) = happyShift action_85
action_124 _ = happyReduce_32

action_125 (61) = happyShift action_73
action_125 (62) = happyShift action_74
action_125 (63) = happyShift action_75
action_125 (64) = happyShift action_76
action_125 (65) = happyShift action_77
action_125 (66) = happyFail []
action_125 (67) = happyFail []
action_125 (68) = happyFail []
action_125 (69) = happyFail []
action_125 (70) = happyFail []
action_125 (71) = happyFail []
action_125 (72) = happyShift action_84
action_125 (73) = happyShift action_85
action_125 _ = happyReduce_31

action_126 _ = happyReduce_30

action_127 _ = happyReduce_29

action_128 _ = happyReduce_28

action_129 (63) = happyShift action_75
action_129 (64) = happyShift action_76
action_129 (65) = happyShift action_77
action_129 (72) = happyShift action_84
action_129 _ = happyReduce_27

action_130 (63) = happyShift action_75
action_130 (64) = happyShift action_76
action_130 (65) = happyShift action_77
action_130 (72) = happyShift action_84
action_130 _ = happyReduce_26

action_131 (37) = happyShift action_133
action_131 _ = happyReduce_49

action_132 _ = happyReduce_57

action_133 (33) = happyShift action_33
action_133 (35) = happyShift action_34
action_133 (38) = happyShift action_35
action_133 (40) = happyShift action_36
action_133 (49) = happyShift action_37
action_133 (50) = happyShift action_38
action_133 (17) = happyGoto action_31
action_133 (19) = happyGoto action_144
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_42

action_135 (42) = happyShift action_56
action_135 (43) = happyShift action_57
action_135 (50) = happyShift action_58
action_135 (51) = happyShift action_59
action_135 (52) = happyShift action_60
action_135 (53) = happyShift action_61
action_135 (62) = happyShift action_62
action_135 (74) = happyShift action_63
action_135 (16) = happyGoto action_143
action_135 (17) = happyGoto action_55
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (61) = happyShift action_73
action_136 (62) = happyShift action_74
action_136 (63) = happyShift action_75
action_136 (64) = happyShift action_76
action_136 (65) = happyShift action_77
action_136 (66) = happyShift action_78
action_136 (67) = happyShift action_79
action_136 (68) = happyShift action_80
action_136 (69) = happyShift action_81
action_136 (70) = happyShift action_82
action_136 (71) = happyShift action_83
action_136 (72) = happyShift action_84
action_136 (73) = happyShift action_85
action_136 _ = happyReduce_47

action_137 (76) = happyShift action_142
action_137 _ = happyFail (happyExpListPerState 137)

action_138 _ = happyReduce_19

action_139 _ = happyReduce_20

action_140 (60) = happyShift action_141
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_60

action_142 (50) = happyShift action_138
action_142 (51) = happyShift action_139
action_142 (15) = happyGoto action_146
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (39) = happyShift action_145
action_143 (61) = happyShift action_73
action_143 (62) = happyShift action_74
action_143 (63) = happyShift action_75
action_143 (64) = happyShift action_76
action_143 (65) = happyShift action_77
action_143 (66) = happyShift action_78
action_143 (67) = happyShift action_79
action_143 (68) = happyShift action_80
action_143 (69) = happyShift action_81
action_143 (70) = happyShift action_82
action_143 (71) = happyShift action_83
action_143 (72) = happyShift action_84
action_143 (73) = happyShift action_85
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_50

action_145 (33) = happyShift action_33
action_145 (35) = happyShift action_34
action_145 (38) = happyShift action_35
action_145 (40) = happyShift action_36
action_145 (49) = happyShift action_37
action_145 (50) = happyShift action_38
action_145 (17) = happyGoto action_31
action_145 (19) = happyGoto action_148
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (56) = happyShift action_147
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (48) = happyShift action_149
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_52

action_149 (44) = happyShift action_97
action_149 (45) = happyShift action_98
action_149 (46) = happyShift action_99
action_149 (47) = happyShift action_100
action_149 (13) = happyGoto action_150
action_149 (14) = happyGoto action_96
action_149 _ = happyFail (happyExpListPerState 149)

action_150 _ = happyReduce_15

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Prog happy_var_1 happy_var_2
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  5 happyReduction_2
happyReduction_2 _
	(HappyTerminal (IDENT happy_var_2))
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 4 6 happyReduction_3
happyReduction_3 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyAbsSyn24  happy_var_2) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Body happy_var_1 happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_2  7 happyReduction_4
happyReduction_4 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_0  7 happyReduction_5
happyReduction_5  =  HappyAbsSyn7
		 ([]
	)

happyReduce_6 = happySpecReduce_2  8 happyReduction_6
happyReduction_6 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_0  8 happyReduction_7
happyReduction_7  =  HappyAbsSyn8
		 ([]
	)

happyReduce_8 = happySpecReduce_1  9 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  9 happyReduction_9
happyReduction_9 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  10 happyReduction_10
happyReduction_10 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  10 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happyReduce 4 11 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyTerminal (NUM happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_1,happy_var_3)
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 12 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 ((happy_var_1,happy_var_3)
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_1  13 happyReduction_14
happyReduction_14 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (TyBasic happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happyReduce 8 13 happyReduction_15
happyReduction_15 ((HappyAbsSyn13  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (TyArray happy_var_8 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_1  14 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn14
		 (TyInt
	)

happyReduce_17 = happySpecReduce_1  14 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn14
		 (TyBool
	)

happyReduce_18 = happySpecReduce_1  14 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn14
		 (TyStr
	)

happyReduce_19 = happySpecReduce_1  15 happyReduction_19
happyReduction_19 (HappyTerminal (IDENT happy_var_1))
	 =  HappyAbsSyn15
		 (Var happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  15 happyReduction_20
happyReduction_20 (HappyTerminal (NUM happy_var_1))
	 =  HappyAbsSyn15
		 (Num happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  16 happyReduction_21
happyReduction_21 (HappyTerminal (NUM happy_var_1))
	 =  HappyAbsSyn16
		 (Num happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  16 happyReduction_22
happyReduction_22 (HappyTerminal (STR happy_var_1))
	 =  HappyAbsSyn16
		 (Str happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  16 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn16
		 (TRue
	)

happyReduce_24 = happySpecReduce_1  16 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn16
		 (FAlse
	)

happyReduce_25 = happySpecReduce_1  16 happyReduction_25
happyReduction_25 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  16 happyReduction_26
happyReduction_26 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (BinOp Plus happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  16 happyReduction_27
happyReduction_27 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (BinOp Minus happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  16 happyReduction_28
happyReduction_28 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (BinOp Mult happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  16 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (BinOp Div happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  16 happyReduction_30
happyReduction_30 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (BinOp Mod happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  16 happyReduction_31
happyReduction_31 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (RelOp Equal happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  16 happyReduction_32
happyReduction_32 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (RelOp Notequal happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  16 happyReduction_33
happyReduction_33 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (RelOp Less happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  16 happyReduction_34
happyReduction_34 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (RelOp Leq happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  16 happyReduction_35
happyReduction_35 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (RelOp Greater happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  16 happyReduction_36
happyReduction_36 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (RelOp Geq happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  16 happyReduction_37
happyReduction_37 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (LogOp And happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  16 happyReduction_38
happyReduction_38 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (LogOp Or happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  16 happyReduction_39
happyReduction_39 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (UnOp Not happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  16 happyReduction_40
happyReduction_40 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (UnOp Neg happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  16 happyReduction_41
happyReduction_41 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 4 16 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn18  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Expressions happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_1  17 happyReduction_43
happyReduction_43 (HappyTerminal (IDENT happy_var_1))
	 =  HappyAbsSyn17
		 (Var happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 17 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (Array happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_0  18 happyReduction_45
happyReduction_45  =  HappyAbsSyn18
		 ([]
	)

happyReduce_46 = happySpecReduce_1  18 happyReduction_46
happyReduction_46 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn18
		 ([happy_var_1]
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  18 happyReduction_47
happyReduction_47 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_3 : happy_var_1
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  19 happyReduction_48
happyReduction_48 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 (Assign happy_var_1 happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happyReduce 4 19 happyReduction_49
happyReduction_49 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (If happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_50 = happyReduce 6 19 happyReduction_50
happyReduction_50 ((HappyAbsSyn19  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (IfElse happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_51 = happyReduce 4 19 happyReduction_51
happyReduction_51 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (While happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happyReduce 8 19 happyReduction_52
happyReduction_52 ((HappyAbsSyn19  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (For happy_var_2 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_53 = happySpecReduce_1  19 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn19
		 (Break
	)

happyReduce_54 = happyReduce 4 19 happyReduction_54
happyReduction_54 (_ `HappyStk`
	(HappyAbsSyn18  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (ProcCall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_55 = happySpecReduce_3  19 happyReduction_55
happyReduction_55 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (Statements happy_var_2
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  20 happyReduction_56
happyReduction_56 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 ([happy_var_1]
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  20 happyReduction_57
happyReduction_57 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_3 : happy_var_1
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  21 happyReduction_58
happyReduction_58 _
	(HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 ((happy_var_1,happy_var_2)
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happyReduce 6 22 happyReduction_59
happyReduction_59 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Procedure happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_60 = happyReduce 8 22 happyReduction_60
happyReduction_60 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENT happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Function happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_61 = happySpecReduce_2  23 happyReduction_61
happyReduction_61 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn23
		 ((happy_var_1,happy_var_2)
	)
happyReduction_61 _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  24 happyReduction_62
happyReduction_62 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  24 happyReduction_63
happyReduction_63  =  HappyAbsSyn24
		 ([]
	)

happyReduce_64 = happySpecReduce_1  25 happyReduction_64
happyReduction_64 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn25
		 ([happy_var_1]
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_2  25 happyReduction_65
happyReduction_65 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_2 : happy_var_1
	)
happyReduction_65 _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_0  26 happyReduction_66
happyReduction_66  =  HappyAbsSyn26
		 ([]
	)

happyReduce_67 = happySpecReduce_1  26 happyReduction_67
happyReduction_67 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn26
		 ([happy_var_1]
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  26 happyReduction_68
happyReduction_68 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_3 : happy_var_1
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  27 happyReduction_69
happyReduction_69 (HappyAbsSyn13  happy_var_3)
	_
	(HappyTerminal (IDENT happy_var_1))
	 =  HappyAbsSyn27
		 ((happy_var_1,happy_var_3)
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 77 77 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PROGRAM -> cont 28;
	FUNCTION -> cont 29;
	PROCEDURE -> cont 30;
	CONST -> cont 31;
	VAR -> cont 32;
	BEGIN -> cont 33;
	END -> cont 34;
	IF -> cont 35;
	THEN -> cont 36;
	ELSE -> cont 37;
	WHILE -> cont 38;
	DO -> cont 39;
	FOR -> cont 40;
	TO -> cont 41;
	TRUE -> cont 42;
	FALSE -> cont 43;
	INT -> cont 44;
	BOOL -> cont 45;
	STRING -> cont 46;
	ARRAY -> cont 47;
	OF -> cont 48;
	BREAK -> cont 49;
	IDENT happy_dollar_dollar -> cont 50;
	NUM happy_dollar_dollar -> cont 51;
	STR happy_dollar_dollar -> cont 52;
	LPAREN -> cont 53;
	RPAREN -> cont 54;
	LSQPAREN -> cont 55;
	RSQPAREN -> cont 56;
	COMMA -> cont 57;
	DOT -> cont 58;
	COLON -> cont 59;
	SEMICOLON -> cont 60;
	PLUS -> cont 61;
	MINUS -> cont 62;
	MULT -> cont 63;
	DIV -> cont 64;
	MOD -> cont 65;
	EQUAL -> cont 66;
	NOTEQ -> cont 67;
	LESS -> cont 68;
	LEQ -> cont 69;
	GREATER -> cont 70;
	GEQ -> cont 71;
	AND -> cont 72;
	OR -> cont 73;
	NOT -> cont 74;
	ASSIGN -> cont 75;
	RANGE -> cont 76;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 77 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


-- Error message
parseError :: [Token] -> a
parseError toks = error "parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc8336_0/ghc_2.h" #-}
































































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
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
     = case happyDrop (k - ((1) :: Int)) sts of
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





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
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

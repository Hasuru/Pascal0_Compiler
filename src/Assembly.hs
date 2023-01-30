-- Tradução para código assembly

module Assembly where 
import DataTypes 
import Generator

-- Gerar código assembly para as funções de I/O

IOFunctions :: String -> [String]
IOFunctions "readint" = generatorToAssembly (LABEL "readint") ++ ["\tli $v0, 5", "\tsyscall", "\tjr $ra"]
IOFunctions "writeint" = generatorToAssembly (LABEL "writeint") ++ ["\tli $v0, 1", "\tlw $a0, 0($sp)", "\tsyscall", "\tjr $ra"]
IOFunctions "writestr" = generatorToAssembly (LABEL "readstr") ++ ["\tli $v0, 4", "\tsyscall", "\tjr $ra"]


generatorToAssembly :: Instr -> [String]
generatorToAssembly (MOVE dest src) = ["\tmove $" ++ dest ++ ", $" ++ src]
generatorToAssembly (MOVEI dest src) = ["\tli $" ++ dest ++ ", " ++ show src]
generatorToAssembly (OP op dest prim sec) = case op of 
    Plus -> ["add $" ++ dest ++ ", $" ++ prim ++ ", $" ++ sec]
    Minus -> ["sub $" ++ dest ++ ", $" ++ prim ++ ", $" ++ sec]
    Mult -> ["mul $" ++ dest ++ ", $" ++ prim ++ ", $" ++ sec]
    Div -> ["div $" ++ prim ++ ", $" ++ sec, "mflo $" ++ dest]
    Mod -> ["div $" ++ prim ++ ", $" ++ sec, "mfhi" ++ dest]
generatorToAssembly (OPI op dest temp int) = case op of 
    Plus -> ["addi $" ++ dest ++ ", $" ++ temp ++ ", $" ++ show int]
    Minus -> ["subi $" ++ dest ++ ", $" ++ temp ++ ", $" ++ show int]
    Mult -> ["muli $" ++ dest ++ ", $" ++ temp ++ ", $" ++ show int]
    Div -> ["div $" ++ temp ++ ", $" ++ show int, "mflo $" ++ dest]
    Mod -> ["div $" ++ temp ++ ", $" ++ show int, "mfhi" ++ dest]
generatorToAssembly (LABEL label) = [label++":"]
generatorToAssembly (JUMP label) = ["j "++label]
generatorToAssembly (COND temp1 op temp2 ltrue lfalse)
    = case op of
        Equal       -> ["\tbeq $" ++ temp1 ++ ", $" ++ temp2 ++ ", " ++ ltrue, "j " ++ lfalse]
        Notequal    -> ["\tbne $" ++ temp1 ++ ", $" ++ temp2 ++ ", " ++ ltrue, "j " ++ lfalse]
        Less        -> ["\tblt $" ++ temp1 ++ ", $" ++ temp2 ++ ", " ++ ltrue, "j " ++ lfalse]
        Greater     -> ["\tbgt $" ++ temp1 ++ ", $" ++ temp2 ++ ", " ++ ltrue, "j " ++ lfalse]
        Leq      -> ["\tble $" ++ temp1 ++ ", $" ++ temp2 ++ ", " ++ ltrue, "j " ++ lfalse]
        Geq   -> ["\tbge $" ++ temp1 ++ ", $" ++ temp2 ++ ", " ++ ltrue, "j " ++ lfalse]
--generatorToAssembly (CALL temp1 label1 temps) = 
generatorToAssembly (RETURN temp) = ["move $v0, $" ++ temp, "move $sp, $fp", "lw $ra, -8($sp)", "lw $fp, -4($sp)",  "jr $ra"]
--generatorToAssembly (FUNC func args instrs) = generatorToAssembly (LABEL func) ++ ["sw $fp, -4($sp)", "sw $ra, -8($sp)", "move $fp, $sp", "addiu $sp, $sp, -n"] ++ functionToAssembly instrs 

-- Gerar código assembly para o corpo de uma função
parseToAssembly :: [Instr] -> [String]
parseToAssembly [] = []
parseToAssembly (x:xs) = func1 ++ func2 
             where func1 = generatorToAssembly x
                   func2 = parseToAssembly xs
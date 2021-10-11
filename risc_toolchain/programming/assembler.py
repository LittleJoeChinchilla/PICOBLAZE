import os

PROGRAM_START       = 0x00
RESET_VECTOR        = 0x00
INTERRUPT_VECTOR    = 0x64
EXCEPTION_VECTOR    = 0xC8



ftemp = open("temp", "w+")

class Syntax:
    version     = "8bit"
    line        = ""
    line_nr     = 0
    warnings    = 0
    error       = 0
    
    def SyntaxCheck(self):
        if self.errors > 0:
            return False
        else:
            return True

syntax = Syntax()

class Register:
    name            = "r0"
    number          = 0
    type            = "R"
    initialized     = False
    update_timer    = 0

registers = []

class Alias:
    type    = "ALIAS"
    arg_num_min = 2
    arg_num_max = 2
    name    = ""
    reg     = 0

aliases = []

class Label:
    type    = "LABEL"
    arg_num_min = 0
    arg_num_max = 0
    name    = ""
    addr     = 0

labels = []

class ProgramCounter:
    value   = PROGRAM_START
    
    def Reset(self):
        self.value = PROGRAM_START
    
    def TickForward(self):
        self.value += 1
        for register in registers:
            if register.update_timer > 0:
                register.update_timer -= 1
                
pc = ProgramCounter()

#    INSTRUCTION TYPES:
class N_type:
    type        = "N"
    arg_num_min = 0
    arg_num_max = 0
    name        = ""
    args        = []

    binary      = ""

    def __init__(self, name):
        self.name = name
        self.args        = []

    def process_arguments(self, words):
        pass

    def assemble(self):
        binary = format(0, '08x')
        return binary

    def deassemble(self):
        print("NOP")

class R_type:
    type        = "R"
    arg_num_min = 3
    arg_num_max = 3
    name        = ""
    args        = []

    funct7  = format(0, '07b')
    rs2     = format(0, '05b')
    rs1     = format(0, '05b')
    funct3  = format(0, '03b')
    rd      = format(0, '05b')
    opcode  = format(0, '07b')

    binary  = ""

    def __init__(self, name):
        self.type        = "R"
        self.arg_num_min = 3
        self.arg_num_max = 3
        self.name = name
        self.args        = []
    
        self.funct7  = format(0, '07b')
        self.rs2     = format(0, '05b')
        self.rs1     = format(0, '05b')
        self.funct3  = format(0, '03b')
        self.rd      = format(0, '05b')
        self.opcode  = format(0, '07b')
    
        self.binary  = ""

    def process_arguments(self, words):
        for n in range(len(words)-1):
            word = words[1 + n]
            word = word.replace(",", "")
            word = word.replace("[", "")
            word = word.replace("]", "")
            
            self.args.append(process_alias(word))

    def assemble(self):
        
        self.rs2 = format(read_register(self.args[2]), '05b')
        
        self.rs1 = format(read_register(self.args[1]), '05b')
        
        self.rd = format(write_register(self.args[0]), '05b')
        
        binary = format(int(self.funct7 + self.rs2 + self.rs1 + self.funct3 + self.rd + self.opcode, 2), '08x')
        return binary

    def deassemble(self):
        self.funct7 = self.binary[0:7]
        self.rs2    = self.binary[7:12]
        self.rs1    = self.binary[12:17]
        self.funct3 = self.binary[17:20]
        self.rd     = self.binary[20:25]
        self.opcode = self.binary[25:32]

class I_type:
    type        = "I"
    arg_num_min = 3
    arg_num_max = 3
    name        = ""
    args        = []

    imm     = format(0, '012b')
    rs1     = format(0, '05b')
    funct3  = format(0, '03b')
    rd      = format(0, '05b')
    opcode  = format(1, '07b')

    binary  = ""

    def __init__(self, name):
        self.type        = "I"
        self.arg_num_min = 3
        self.arg_num_max = 3
        self.name        = name
        self.args        = []
    
        self.imm     = format(0, '012b')
        self.rs1     = format(0, '05b')
        self.funct3  = format(0, '03b')
        self.rd      = format(0, '05b')
        self.opcode  = format(1, '07b')
    
        self.binary  = ""

    def process_arguments(self, words):
     
        for n in range(len(words)-1):
            word = words[1 + n]
            word = word.replace(",", "")
            word = word.replace("[", "")
            word = word.replace("]", "")
            
            if self.name == "JALR":
                if n == 0:
                    self.args.append(process_alias(word))
                if n == 1:
                    self.args.append(process_alias(word))
                if n == 2:
                    self.args.append(process_label(word)) 
            else:
                if n == 2:
                    if syntax.version == "8bit":
                        if int(word, 0) > 255:
                            syntax.errors += 1
                            print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                            print("Value "+word+" bigger than 255.")
                            print("\n")
                        elif int(word, 0) < -128:
                            syntax.errors += 1
                            print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                            print("Value "+word+" smaller than -128.")
                            print("\n")
                        else:
                            word = word.replace("R", "")
                            self.args.append(int(word,0))
                    elif syntax.version == "32bit":
                        if int(word, 0) > 4095:
                            syntax.errors += 1
                            print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                            print("Value "+word+" bigger than 4095.")
                            print("\n")
                        elif int(word, 0) < -2056:
                            syntax.errors += 1
                            print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                            print("Value "+word+" smaller than -2056.")
                            print("\n")
                        else:
                            word = word.replace("R", "")
                            self.args.append(int(word,0))
                else:
                    self.args.append(process_alias(word))

    def assemble(self):
        
        self.rs1 = format(read_register(self.args[1]), '05b')
        
        self.rd = format(write_register(self.args[0]), '05b')      

        if (self.name == "SLLI" or self.name == "SRLI" or self.name == "SLAI" or self.name == "SRAI"):
            if self.args[2] > 31:
                syntax.errors += 1
                print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                print("Value "+word+" bigger than 31.")
                print("\n")
            else:
                if self.name == "SLLI":
                    self.imm = format(0, '07b') + format(self.args[2], '05b')
                elif self.name == "SRLI":
                    self.imm = format(1, '07b') + format(self.args[2], '05b')
                elif self.name == "SLAI":
                    self.imm = format(2, '07b') + format(self.args[2], '05b')
                elif self.name == "SRAI":
                    self.imm = format(3, '07b') + format(self.args[2], '05b')
        else:
            if self.name == "JALR":
                self.imm = format((((1 << 12) - 1) & (self.args[1] - self.args[0])), '012b')
            else:
                self.imm = format((((1 << 12) - 1) & self.args[2]), '012b')
        
        return format(int(self.imm + self.rs1 + self.funct3 + self.rd + self.opcode, 2), '08x')

    def deassemble(self):
        self.imm    = self.binary[0:12]
        self.rs1    = self.binary[12:17]
        self.funct3 = self.binary[17:20]
        self.rd     = self.binary[20:25]
        self.opcode = self.binary[25:32]

class S_type:
    type        = "S"
    arg_num_min = 2
    arg_num_max = 4
    name        = ""
    args        = []

    imm     = format(0, '012b')
    rs2     = format(0, '05b')
    rs1     = format(0, '05b')
    funct3  = format(1, '03b')
    opcode  = format(2, '07b')

    binary  = ""
    
    def __init__(self, name):
        self.type        = "S"
        self.arg_num_min = 2
        self.arg_num_max = 4
        self.name        = name
        self.args        = []
    
        self.imm     = format(0, '012b')
        self.rs2     = format(0, '05b')
        self.rs1     = format(0, '05b')
        self.funct3  = format(1, '03b')
        self.opcode  = format(2, '07b')
    
        self.binary  = ""
    
    def process_arguments(self, words):
        for n in range(len(words)-1):
            word = words[1 + n]
            word = word.replace(",", "")
            word = word.replace("[", "")
            word = word.replace("]", "")
    
            if n > 1:
                word = word.replace("R", "")
                self.args.append(int(word, 0))
            else:
                self.args.append(process_alias(word))

    def assemble(self):

        self.rs2 = format(read_register(self.args[0]), '05b')

        self.rs1 = format(read_register(self.args[1]), '05b')
        
        if len(self.args) > 2:
            self.imm = format(self.args[2], '012b')
            if len(self.args) > 3:
                self.funct3 = format(self.args[3], '03b')
            
        return format(int(self.imm[0:7] + self.rs2 + self.rs1 + self.funct3 + self.imm[7:12] + self.opcode, 2), '08x')

    def deassemble(self):
        self.imm        = self.binary[0:7] + self.binary[20:25]
        self.rs2        = self.binary[7:12]
        self.rs1        = self.binary[12:17]
        self.funct3     = self.binary[17:20] 
        self.opcode     = self.binary[25:32]

class L_type:
    type        = "L"
    arg_num_min = 2
    arg_num_max = 4
    name        = ""
    args        = []

    imm     = format(0, '012b')
    rs1     = format(0, '05b')
    funct3  = format(1, '03b')
    rd      = format(0, '05b')
    opcode  = format(3, '07b')

    binary  = ""

    def __init__(self, name):
        self.type        = "L"
        self.arg_num_min = 2
        self.arg_num_max = 4
        self.name        = name
        self.args        = []
    
        self.imm     = format(0, '012b')
        self.rs1     = format(0, '05b')
        self.funct3  = format(1, '03b')
        self.rd      = format(0, '05b')
        self.opcode  = format(3, '07b')
    
        self.binary  = ""

    def process_arguments(self, words):
        for n in range(len(words)-1):
            word = words[1 + n]
            word = word.replace(",", "")
            word = word.replace("[", "")
            word = word.replace("]", "")
    
            if n > 1:
                word = word.replace("R", "")
                self.args.append(int(word, 0))
            else:
                self.args.append(process_alias(word))

    def assemble(self):

        self.rd = format(write_register(self.args[0]), '05b')

        self.rs1 = format(read_register(self.args[1]), '05b')
        
        if len(self.args) > 2:
            self.imm = format(self.args[2], '012b')
            if len(self.args) > 3:
                self.funct3 = format(self.args[3], '03b')
        
        return format(int(self.imm + self.rs1 + self.funct3 + self.rd + self.opcode, 2), '08x')

    def deassemble(self):
        self.imm    = self.binary[0:12]
        self.rs1    = self.binary[12:17]
        self.funct3 = self.binary[17:20]
        self.rd     = self.binary[20:25]
        self.opcode = self.binary[25:32]

class B_type:
    type        = "B"
    arg_num_min = 3
    arg_num_max = 3
    name        = ""
    args        = []

    imm     = format(0, '012b')
    rs2     = format(0, '05b')
    rs1     = format(0, '05b')
    funct3  = format(0, '03b')
    opcode  = format(4, '07b')

    binary  = ""

    def __init__(self, name):
        self.type        = "B"
        self.arg_num_min = 3
        self.arg_num_max = 3
        self.name        = name
        self.args        = []
    
        self.imm     = format(0, '012b')
        self.rs2     = format(0, '05b')
        self.rs1     = format(0, '05b')
        self.funct3  = format(0, '03b')
        self.opcode  = format(4, '07b')
    
        self.binary  = ""

    def process_arguments(self, words):
        for n in range(len(words)-1):
            word = words[1 + n]
            word = word.replace(",", "")
            word = word.replace("[", "")
            word = word.replace("]", "")

            if n == 2:
                self.args.append(process_label(word)) 
            else:
                self.args.append(process_alias(word))

    def assemble(self):
        
        self.rs1 = format(read_register(self.args[0]), '05b')

        self.rs2 = format(read_register(self.args[1]), '05b')

        offset = self.args[2] - pc.value
        print('B offset')
        print(offset)
        print('')
        self.imm = format((((1 << 12) - 1) & (offset//2)), '012b')
        
        return format(int(self.imm[0] + self.imm[2:8] + self.rs2 + self.rs1 + self.funct3 + self.imm[8:12] + self.imm[1] + self.opcode, 2), '08x')

    def deassemble(self):
        self.imm        = self.binary[0] + self.binary[24] + self.binary[1:7] + self.binary[20:24]
        self.rs2        = self.binary[7:12]
        self.rs1        = self.binary[12:17]
        self.funct3     = self.binary[17:20]
        self.opcode     = self.binary[25:32]

class J_type:
    type        = "J"
    arg_num_min = 2
    arg_num_max = 2
    name        = ""
    args        = []

    imm     = format(0, '020b')
    rd      = format(0, '05b')
    opcode  = format(5, '07b')

    binary  = ""

    def __init__(self, name):
        self.type        = "J"
        self.arg_num_min = 2
        self.arg_num_max = 2
        self.name        = name
        self.args        = []
    
        self.imm     = format(0, '020b')
        self.rd      = format(0, '05b')
        self.opcode  = format(5, '07b')
    
        self.binary  = ""

    def process_arguments(self, words):
        for n in range(len(words)-1):
            word = words[1 + n]
            word = word.replace(",", "")
            word = word.replace("[", "")
            word = word.replace("]", "")

            if self.name == "JAL":
                if n == 0:
                    self.args.append(process_alias(word))
                if n == 1:                            
                    self.args.append(process_label(word))              
    
    def assemble(self):
        self.rd = format(write_register(self.args[0]), '05b')
        
        offset = self.args[1] - pc.value
        print('J offset')
        print(offset)
        print('')
        self.imm = format((((1 << 20) - 1) & (offset//2)), '020b')    
            
        return format(int(self.imm[0] + self.imm[10:20] + self.imm[10] + self.imm[1:9] + self.rd + self.opcode, 2), '08x')    

    def deassemble(self):
        self.imm        = self.binary[0] + self.binary[12:20] + self.binary[11] + self.binary[1:11]
        self.rd         = self.binary[20:25]
        self.opcode     = self.binary[25:32]
      
      
      
      
           
def process_label(word):
    is_label = False 
    for label in labels:
        if label.name == word:
            addr = label.addr
            is_label = True                    
    if (iteration == "processing"):
        if not is_label:
            syntax.errors += 1
            print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
            print("Label "+word+" doesn't exist.")
            print("\n")
        else:                                      
            return addr
    else:
        return 0
                   
def process_alias(word):
    is_alias = False
    for alias in aliases:
        if alias.name == word:
            reg = alias.reg
            is_alias = True
            break
    if is_alias == False:
        reg = process_register(word)
    return reg

def process_register(word):
    is_register = False
    for register in registers:
        if register.name == word:
            reg = register
            is_register = True
            break
    if is_register == False:
        syntax.errors += 1
        print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
        print("Undefined register: "+word)
        print("\n")
    else:
        return reg



def write_register(register):
    reg_number = register.number
    if registers[reg_number].type == "R":
        syntax.errors += 1
        print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
        print("Register "+registers[reg_number].name+" read only.")
        print("\n")
    else:
        registers[reg_number].update_timer = 9
        registers[reg_number].initialized = True
        return reg_number

def read_register(register):
    reg_number = register.number
    if registers[reg_number].initialized == False:
        syntax.warnings += 1
        print("Warning in line "+str(syntax.line_nr+1)+": "+syntax.line)
        print("Register "+registers[reg_number].name+" not initialized.")
        print("\n")
    while registers[reg_number].update_timer > 0:
        insert_nop("reg")
    return reg_number
   
    
            
def insert_nop(mode):
    if iteration == "labels":
        for label in labels:
            if label.addr > pc.value:
                label.addr += 1
    if iteration == "processing":
        if mode == "label":
            ftemp.write("\n")
        ftemp.write(N_type("NOP").assemble())
        ftemp.write(",")
        if mode == "reg":
            ftemp.write("\n")
    pc.TickForward()



def initialize_registers():
    for n in range(31):
        new_register = Register()
        new_register.name = "R"+str(n)
        new_register.number = n    
        if n == 0:
            new_register.type = "R"
            new_register.initialized = True
        else:
            new_register.type = "RW"
            new_register.initialized = False
        registers.append(new_register)

def initialize_standard_labels():
    label = Label()
    label.name = "RESET_VECTOR"
    label.addr = RESET_VECTOR
    labels.append(label)
    
    label = Label()
    label.name = "EXCEPTION_VECTOR"
    label.addr = EXCEPTION_VECTOR
    labels.append(label)
    
    label = Label()
    label.name = "INTERRUPT_VECTOR"
    label.addr = INTERRUPT_VECTOR
    labels.append(label)
    
    label = Label()
    label.name = "PROGRAM_START"
    label.addr = PROGRAM_START
    labels.append(label)




def get_type(instr_name):
    if instr_name == "ALIAS":
        instruction = Alias()
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
    elif instr_name == "NOP":
        instruction = N_type(instr_name)
# -----------------------------------------------------------------------------        
    elif instr_name == "ADD":
        instruction = R_type(instr_name)
        instruction.funct7 = format(0, '07b')
        instruction.funct3 = format(0, '03b')
    elif instr_name == "SUB":
        instruction = R_type(instr_name)
        instruction.funct7 = format(0, '07b')
        instruction.funct3 = format(1, '03b')
    elif instr_name == "MUL":
        instruction = R_type(instr_name)
        instruction.funct7 = format(0, '07b')
        instruction.funct3 = format(2, '03b')
    elif instr_name == "DIV":
        instruction = R_type(instr_name)
        instruction.funct7 = format(0, '07b')
        instruction.funct3 = format(3, '03b')
# -----------------------------------------------------------------------------
    elif instr_name == "AND":
        instruction = R_type(instr_name)
        instruction.funct7 = format(1, '07b')
        instruction.funct3 = format(0, '03b')
    elif instr_name == "OR":
        instruction = R_type(instr_name)
        instruction.funct7 = format(1, '07b')
        instruction.funct3 = format(1, '03b')
    elif instr_name == "XOR":
        instruction = R_type(instr_name)
        instruction.funct7 = format(1, '07b')
        instruction.funct3 = format(2, '03b')
# -----------------------------------------------------------------------------
    elif instr_name == "SLA":
        instruction = R_type(instr_name)
        instruction.funct7 = format(2, '07b')
        instruction.funct3 = format(0, '03b')
    elif instr_name == "SRA":
        instruction = R_type(instr_name)
        instruction.funct7 = format(2, '07b')
        instruction.funct3 = format(1, '03b')
# -----------------------------------------------------------------------------
    elif instr_name == "SLL":
        instruction = R_type(instr_name)
        instruction.funct7 = format(3, '07b')
        instruction.funct3 = format(0, '03b')
    elif instr_name == "SRL":
        instruction = R_type(instr_name)
        instruction.funct7 = format(3, '07b')
        instruction.funct3 = format(1, '03b')
# -----------------------------------------------------------------------------
    elif instr_name == "SLT":
        instruction = R_type(instr_name)
        instruction.funct7 = format(4, '07b')
        instruction.funct3 = format(0, '03b')
    elif instr_name == "SLTU":
        instruction = R_type(instr_name)
        instruction.funct7 = format(4, '07b')
        instruction.funct3 = format(1, '03b')
    elif instr_name == "SGT":
        instruction = R_type(instr_name)
        instruction.funct7 = format(4, '07b')
        instruction.funct3 = format(2, '03b')
    elif instr_name == "SGTU":
        instruction = R_type(instr_name)
        instruction.funct7 = format(4, '07b')
        instruction.funct3 = format(3, '03b')
    elif instr_name == "SEQ":
        instruction = R_type(instr_name)
        instruction.funct7 = format(4, '07b')
        instruction.funct3 = format(4, '03b')
    elif instr_name == "SNE":
        instruction = R_type(instr_name)
        instruction.funct7 = format(4, '07b')
        instruction.funct3 = format(5, '03b')
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
    elif instr_name == "ADDI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(0, '03b')
    elif instr_name == "SLTI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(1, '03b')
    elif instr_name == "SLTIU":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(2, '03b')
    elif instr_name == "SLLI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(3, '03b')
        instruction.imm     = format(0, '07b') + format(0, '05b')
    elif instr_name == "SRLI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(3, '03b')
        instruction.imm     = format(1, '07b') + format(0, '0b')
    elif instr_name == "SLAI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(3, '03b')
        instruction.imm     = format(2, '07b') + format(0, '05b')
    elif instr_name == "SRAI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(3, '03b')
        instruction.imm     = format(3, '07b') + format(0, '05b')
    elif instr_name == "ANDI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(4, '03b')
    elif instr_name == "ORI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(5, '03b')
    elif instr_name == "XORI":
        instruction         = I_type(instr_name)
        instruction.funct3  = format(6, '03b')    
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
    elif instr_name == "STR":
        instruction         = S_type(instr_name)            
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------               
    elif instr_name == "LDR":
        instruction         = L_type(instr_name)   
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
    elif instr_name == "BEQ":
        instruction         = B_type(instr_name)
        instruction.funct3  = format(0, '03b')
    elif instr_name == "BNE":
        instruction         = B_type(instr_name)
        instruction.funct3  = format(1, '03b')
    elif instr_name == "BLT":
        instruction         = B_type(instr_name)
        instruction.funct3  = format(2, '03b')
    elif instr_name == "BLTU":
        instruction         = B_type(instr_name)
        instruction.funct3  = format(3, '03b')
    elif instr_name == "BGE":
        instruction         = B_type(instr_name)
        instruction.funct3  = format(4, '03b')
    elif instr_name == "BGEU":
        instruction         = B_type(instr_name)
        instruction.funct3  = format(5, '03b')
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
    elif instr_name == "JAL":
        instruction         = J_type(instr_name)
    elif instr_name == "JALR":
        instruction         = I_type(instr_name)
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
    elif instr_name.endswith(":"):
        instruction         = Label()

    
    else:
        instruction = "ERROR"

    if instruction != "ERROR":
        instruction.name = instr_name

    return instruction





def assembler(input_path, output_path, version = "8bit", tcl_path = None):

    global ftemp
    fin = open(input_path,"r")
    ftemp = open("temp", "w+")
    
    syntax.version = version
    syntax.errors = 0
    syntax.warnings = 0

    initialize_registers()
    initialize_standard_labels()

    if fin.mode == 'r':

        ftemp.write("memory_initialization_radix=16;")
        ftemp.write("\n")
        ftemp.write("memory_initialization_vector=")

        lines = fin.readlines()

        iterations = ["labels", "processing"]
        
        global iteration
        
        for iteration in iterations:
            if iteration == "processing":
                for label in labels:
                    print(label.name)
                    print(label.addr)
            pc.Reset()
            line_nr = 0
            for line in lines:
                if line[0] != '#':
                    syntax.line = line
                    syntax.line_nr = line_nr
                    words = line.split()
                    if len(words) > 0:
                        instruction = get_type(words[0])
                        if instruction == "ERROR":
                            syntax.errors += 1
                            print("Error in line "+str(syntax.line_nr+1)+": "+str(line))
                            print("Undefined instruction: "+word)
                            print("\n")
                        else:
                            if (len(words) - 1) > instruction.arg_num_max:
                                syntax.errors += 1
                                print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                                print("Too many arguments for instruction: "+instruction.name)
                                print("\n")
                                print("Expected: "+str(instruction.arg_num))
                                print("\n")
                                print("Given: "+str(len(words) - 1))
                                print("\n")
                            elif (len(words) - 1) < instruction.arg_num_min:
                                syntax.errors += 1
                                print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                                print("Not enough arguments for instruction: "+instruction.name)
                                print("\n")
                                print("Expected: "+str(instruction.arg_num_min))
                                print("\n")
                                print("Given: "+str(len(words) - 1))
                                print("\n")
                            else:
                                if instruction.type == "ALIAS":
                                    word = words[1]
                                    word = word.replace(",", "")
                                    word = word.replace("[", "")
                                    word = word.replace("]", "")
                                    is_alias = False
                                    for alias in aliases:
                                        if alias.name == word:
                                            reg = alias.reg
                                            is_alias = True
                                            break
                                    if not is_alias:
                                        is_register = False
                                        for register in registers:
                                            if register.name == word:
                                                reg = register
                                                is_register = True
                                                break
                                        if not is_register:
                                            syntax.errors += 1
                                            print("Error in line "+str(syntax.line_nr+1)+": "+syntax.line)
                                            print("Undefined register: "+word)
                                            print("\n")
                                    instruction.reg = reg
                                    word = words[2]
                                    word = word.replace(",", "")
                                    word = word.replace("[", "")
                                    word = word.replace("]", "")
                                    instruction.name = word
                                    aliases.append(instruction)
                                elif instruction.type == "LABEL":
                                    word = words[0]
                                    word = word.replace(":", "")
                                    is_label = False
                                    for label in labels:
                                        if label.name == word:
                                            addr = label.addr
                                            is_label = True
                                            insert_nop("label")
                                            break
                                    if not is_label:
                                        addr = pc.value
                                        instruction.addr = addr
                                        instruction.name = word
                                        labels.append(instruction)
                                else:
                                    instruction.process_arguments(words)
                                    if iteration == "processing":
                                        if syntax.errors == 0:
                                            ftemp.write("\n")
                                            ftemp.write(instruction.assemble())
                                            if line_nr == len(lines) - 1:
                                                ftemp.write(";")        
                                            else:
                                                ftemp.write(",")
                                    else:
                                        instruction.assemble()
                                if instruction.type != "ALIAS" and instruction.type != "LABEL":
                                    pc.TickForward()
                line_nr += 1
    fin.close() 
    ftemp.close()

    if syntax.SyntaxCheck():
        ftemp = open("temp", "r")
        fout = open(output_path, "w+")
        if tcl_path != None:
            f_tcl = open(tcl_path, "w")
        n = 0
        idx = 0
        for line in ftemp.readlines():
            fout.write(line)
            if idx > 1:
                if tcl_path != None:
                    instr = line.strip()
                    instr = instr.replace(',','')
                    instr = instr.replace(';','')
                    f_tcl.write("create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address " + str(format(PROGRAM_START+n, '08x')) + " -data " + instr + " -type write -force" + "\n");
                    f_tcl.write("run_hw_axi wr_txn\n")
                n+=1
            idx+=1
        fout.close()
        ftemp.close()
        print("Assemblation finished with "+str(syntax.errors)+" errors and "+str(syntax.warnings)+" warnings.")
    else:
        print("Assemblation aborted with "+str(syntax.errors)+" errors and "+str(syntax.warnings)+" warnings.")

    os.remove("temp")
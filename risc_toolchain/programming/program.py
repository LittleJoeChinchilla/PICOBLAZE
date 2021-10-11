import os
from assembler import assembler 

HW_SERVER = "127.0.0.1:3121"
ASM_FILE  = "../program.asm"

# Get vivado rootdir
stream = os.popen('echo %VIVADO_ROOTDIR%')
vivado_rootdir = stream.read().strip()
print("Readed Vivado root directory: " + vivado_rootdir)

# Get current dir
stream = os.popen('cd')
current_dir = stream.read().strip()
print("Readed current directory: " + current_dir)

# Assembly input file & get programming tcl commands
assembler(ASM_FILE, '_coe', version = "8bit", tcl_path = current_dir + '/asm_program.tcl')

# Write TCL file
fid = open("program.tcl", "w")
fid.write("# Connect to Zybo" + '\n')
fid.write("open_hw" + '\n')
fid.write("connect_hw_server" + '\n')
fid.write("open_hw_target" + '\n')
fid.write("# Get debug cores" + '\n')
fid.write("current_hw_device [lindex [get_hw_devices] 1]" + "\n")
fid.write("refresh_hw_device [lindex [get_hw_devices] 1]" + "\n")
# Assert reset risc core
fid.write("create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00010000 -data FFFFFFFF -type write -force" + '\n')
fid.write("run_hw_axi wr_txn" + '\n')
# Append TCL program commands to TCL file
ftcl = open("asm_program.tcl", "r")
for line in ftcl.readlines():
    fid.write(line)
# Deassert reset risc core
fid.write("create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00010000 -data 00000000 -type write -force" + '\n')
fid.write("run_hw_axi wr_txn" + '\n')
fid.write("exit" + '\n')
fid.close()

# Run Vivado
os.system(vivado_rootdir + '/settings64.bat && vivado -mode tcl -source ' + current_dir + '/program.tcl')

# Clean up
os.system('del vivado*')
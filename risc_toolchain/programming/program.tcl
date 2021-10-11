# Connect to Zybo
open_hw
connect_hw_server
open_hw_target
# Get debug cores
current_hw_device [lindex [get_hw_devices] 1]
refresh_hw_device [lindex [get_hw_devices] 1]
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00010000 -data FFFFFFFF -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000000 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000001 -data 00000181 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000002 -data 00000581 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000003 -data 00000081 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000004 -data 00000101 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000005 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000006 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000007 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000008 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000009 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000000a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000000b -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000000c -data 00008d04 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000000d -data 00108081 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000000e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000000f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000010 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000011 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000012 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000013 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000014 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000015 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000016 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000017 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000018 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000019 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000001a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000001b -data febfff05 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000001c -data 00f14101 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000001d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000001e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000001f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000020 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000021 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000022 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000023 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000024 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000025 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000026 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000027 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000028 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000029 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000002a -data 00253d04 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000002b -data 00110101 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000002c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000002d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000002e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000002f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000030 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000031 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000032 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000033 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000034 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000035 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000036 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000037 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000038 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000039 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000003a -data fdffff05 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000003b -data 00100581 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000003c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000003d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000003e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000003f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000040 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000041 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000042 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000043 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000044 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000045 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000046 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000047 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000048 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000049 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000004a -data fcffff05 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000004b -data 00000581 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000004c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000004d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000004e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000004f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000050 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000051 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000052 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000053 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000054 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000055 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000056 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000057 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000058 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000059 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000005a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000005b -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000005c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000005d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000005e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000005f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000060 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000061 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000062 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000063 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000064 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000065 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000066 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000067 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000068 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000069 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000006a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000006b -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000006c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000006d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000006e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000006f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000070 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000071 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000072 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000073 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000074 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000075 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000076 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000077 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000078 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000079 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000007a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000007b -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000007c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000007d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000007e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000007f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000080 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000081 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000082 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000083 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000084 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000085 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000086 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000087 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000088 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000089 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000008a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000008b -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000008c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000008d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000008e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000008f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000090 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000091 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000092 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000093 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000094 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000095 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000096 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000097 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000098 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00000099 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000009a -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000009b -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000009c -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000009d -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000009e -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 0000009f -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a0 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a1 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a2 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a3 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a4 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a5 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a6 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a7 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a8 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000a9 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000aa -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000ab -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000ac -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000ad -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000ae -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000af -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000b0 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000b1 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 000000b2 -data 00000000 -type write -force
run_hw_axi wr_txn
create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address 00010000 -data 00000000 -type write -force
run_hw_axi wr_txn
exit

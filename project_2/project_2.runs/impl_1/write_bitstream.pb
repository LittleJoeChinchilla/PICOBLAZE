
g
Command: %s
1870*	planAhead22
open_checkpoint top_routed.dcp2default:defaultZ12-2866h px? 
^

Starting %s Task
103*constraints2#
open_checkpoint2default:defaultZ18-103h px? 
?

%s
*constraints2r
^Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.019 . Memory (MB): peak = 210.281 ; gain = 0.0002default:defaulth px? 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
4462default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2016.12default:defaultZ1-479h px? 
V
Loading part %s157*device2#
xc7z020clg400-12default:defaultZ21-403h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
?
?Could not create '%s' constraint because net '%s' is not directly connected to top level port. '%s' is ignored by %s but preserved for implementation tool.
528*constraints2 
IBUF_LOW_PWR2default:default2'
processor/sys_clk2default:default2 
IBUF_LOW_PWR2default:default2
Vivado2default:default2s
]D:/PROJEKT/PICOBLAZE/RISC/RISC.runs/impl_1/.Xil/Vivado-21468-DESKTOP-2340M74/dcp_2/risc_0.edf2default:default2
3613662default:default8@Z18-550h px? 
y
QGenerator change detected checking ShapeConfig Enum. shapeDB will be regenarated.830*constraintsZ18-4397h px? 
?
Parsing XDC File [%s]
179*designutils2~
hD:/PROJEKT/PICOBLAZE/project_2/project_2.runs/impl_1/.Xil/Vivado-11528-DESKTOP-2340M74/dcp/top_early.xdc2default:default8Z20-179h px? 
?
%Done setting XDC timing constraints.
35*timing2}
gd:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/ip/risc_0/src/risc_clock_external/risc_clock_external.xdc2default:default2
572default:default8@Z38-35h px? 
?
Deriving generated clocks
2*timing2}
gd:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/ip/risc_0/src/risc_clock_external/risc_clock_external.xdc2default:default2
572default:default8@Z38-2h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
get_clocks: 2default:default2
00:00:102default:default2
00:00:102default:default2
1047.6092default:default2
487.5392default:defaultZ17-268h px? 
?
Finished Parsing XDC File [%s]
178*designutils2~
hD:/PROJEKT/PICOBLAZE/project_2/project_2.runs/impl_1/.Xil/Vivado-11528-DESKTOP-2340M74/dcp/top_early.xdc2default:default8Z20-178h px? 
?
Parsing XDC File [%s]
179*designutils2x
bD:/PROJEKT/PICOBLAZE/project_2/project_2.runs/impl_1/.Xil/Vivado-11528-DESKTOP-2340M74/dcp/top.xdc2default:default8Z20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2x
bD:/PROJEKT/PICOBLAZE/project_2/project_2.runs/impl_1/.Xil/Vivado-11528-DESKTOP-2340M74/dcp/top.xdc2default:default8Z20-178h px? 
?
Reading XDEF placement.
206*designutilsZ20-206h px? 
D
Reading placer database...
1602*designutilsZ20-1892h px? 
=
Reading XDEF routing.
207*designutilsZ20-207h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2$
Read XDEF File: 2default:default2
00:00:002default:default2 
00:00:00.7242default:default2
1059.9532default:default2
1.6172default:defaultZ17-268h px? 
?
7Restored from archive | CPU: %s secs | Memory: %s MB |
1612*designutils2
0.0000002default:default2
0.0000002default:defaultZ20-1924h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common20
Finished XDEF File Restore: 2default:default2
00:00:002default:default2 
00:00:00.7252default:default2
1059.9532default:default2
1.6172default:defaultZ17-268h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
!Unisim Transformation Summary:
%s111*project2?
?  A total of 302 instances were transformed.
  CFGLUT5 => CFGLUT5 (SRLC32E, SRL16E): 248 instances
  RAM32M => RAM32M (RAMD32, RAMD32, RAMD32, RAMD32, RAMD32, RAMD32, RAMS32, RAMS32): 6 instances
  RAM64M => RAM64M (RAMD64E, RAMD64E, RAMD64E, RAMD64E): 40 instances
  RAM64X1D => RAM64X1D (RAMD64E, RAMD64E): 8 instances
2default:defaultZ1-111h px? 
?
'Checkpoint was created with %s build %s378*project2+
Vivado v2016.1 (64-bit)2default:default2
15382592default:defaultZ1-604h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2%
open_checkpoint: 2default:default2
00:00:212default:default2
00:00:222default:default2
1059.9532default:default2
849.6722default:defaultZ17-268h px? 
w
Command: %s
53*	vivadotcl2F
2write_bitstream -force -no_partial_bitfile top.bit2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349h px? 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
Rule violation (%s) %s - %s
20*drc2
CHECK-32default:default2-
Report rule limit reached2default:default2P
<REQP-1839 rule limit reached: 20 violations have been found.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
CHECK-32default:default2-
Report rule limit reached2default:default2P
<REQP-1840 rule limit reached: 20 violations have been found.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
CSCL-12default:default2/
Clocked by a non-clock net.2default:default2?
?Net processor/inst/risc_core_inst/risc_inst/risc_clk is a non-clock net, connected to the clock port on HW Debug core processor/inst/risc_core_inst/risc_inst/risc_validation_core_inst.  Please verify this is correct.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIP-12default:default2$
Input pipelining2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[29:0] is not pipelined. Pipelining DSP48 input will improve performance.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIP-12default:default2$
Input pipelining2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/B[17:0] is not pipelined. Pipelining DSP48 input will improve performance.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[0] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[10] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[11] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[12] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[13] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[14] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[15] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[16] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[17] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[18] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[19] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[1] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[20] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[21] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[22] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[23] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[24] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[25] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[26] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[27] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[28] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[29] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[2] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[3] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[4] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[5] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[6] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[7] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[8] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPIR-12default:default2-
Asynchronous driver check2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive input pin processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/A[9] is connected to registers with an asynchronous reset. This is preventing the possibility of merging these registers in to the DSP Block since the DSP block registers only possess synchronous reset capability.  It is suggested to recode or change these registers to remove the reset or use a synchronous reset to get the best optimization for performance, power and area.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPOP-12default:default2*
PREG Output pipelining2default:default2?
?DSP processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive output processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive/P[47:0] is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
DPREG-42default:default2/
DSP48E1_PregDynOpmodeZmuxP:2default:default2?
?The DSP48E1 cell processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive with the given dynamic OPMODE[6:0] connections may lead to an unregistered asynchronous feedback path without the PREG attribute enabled. Please refer to the user guide and if one of the internal P feedback opmodes is possible for this design the PREG attribute must be set to 1, currently set to 02default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRARDADDR[6] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[3][0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRARDADDR[7] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[3][1]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRARDADDR[8] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[3][2]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[2]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRARDADDR[9] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[3][3]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[3]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRBWRADDR[6] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRBWRADDR[7] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[1]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRBWRADDR[8] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[2]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[2]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ADDRBWRADDR[9] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[3]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[3]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ENARDEN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ENARDEN_cooolgate_en_sig_5) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/gpregsm1.curr_fwft_state_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ENARDEN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ENARDEN_cooolgate_en_sig_5) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/gpregsm1.curr_fwft_state_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ENARDEN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram_ENARDEN_cooolgate_en_sig_5) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gras.rsts/ram_empty_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/ENBWREN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[0] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[1] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[2] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[3] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[4] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[5] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[6] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18392default:default2.
RAMB36 async control check2default:default2?
?The RAMB36E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram/WEBWE[7] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[10] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][5]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[5]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[11] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][6]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[6]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[12] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][7]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[7]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[5] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[6] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][1]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[7] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][2]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[2]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[8] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][3]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[3]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRARDADDR[9] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/gc0.count_d1_reg[7][4]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/rpntr/gc0.count_d1_reg[4]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[10] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[5]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[5]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[11] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[6]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[6]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[12] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[7]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[7]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[5] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[6] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[1]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[7] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[2]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[2]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[8] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[3]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[3]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ADDRBWRADDR[9] (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/Q[4]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gic0.gc0.count_d2_reg[4]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ENARDEN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/gpregsm1.curr_fwft_state_reg[0]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ENARDEN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/gpregsm1.curr_fwft_state_reg[1]) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ENARDEN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/E[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gras.rsts/ram_empty_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
	REQP-18402default:default2.
RAMB18 async control check2default:default2?
?The RAMB18E1 processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram has an input control pin processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram/ENBWREN (net: processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/rx_fifo_wr_en_reg[0]) which is driven by a register (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_fb_i_reg) that has an active asychronous set or reset. This may cause corruption of the memory contents and/or read values when the set/reset is asserted and is not analyzed by the default static timing analysis. It is suggested to eliminate the use of a set/reset to registers driving this RAMB pin or else use a synchronous reset in which the assertion of the reset is timed by default.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
ZPS7-12default:default2&
PS7 block required2default:default2s
_The PS7 cell must be used in this Zynq design in order to enable correct default configuration.2default:defaultZ23-20h px? 
?
Rule violation (%s) %s - %s
20*drc2
AVAL-42default:default2U
Aenum_USE_DPORT_FALSE_enum_DREG_ADREG_0_connects_CED_CEAD_RSTD_GND2default:default2?
?processor/inst/risc_core_inst/risc_inst/risc_alu_inst/risc_alu_dsp_inst/U0/i_synth/i_synth_option.i_synth_model/opt_7series.i_uniwrap/i_primitive: DSP48E1 is not using the D port (USE_DPORT = FALSE). For improved power characteristics, set DREG and ADREG to '1', tie CED, CEAD, and RSTD to logic '0'.2default:defaultZ23-20h px? 
?	
Rule violation (%s) %s - %s
20*drc2
REQP-1652default:default2

writefirst2default:default2?
?Synchronous clocking is detected for BRAM (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rx_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram) in SDP mode with WRITE_FIRST write-mode. This is the preferred mode for best power characteristics, however it may exhibit address collisions if the same address appears on both read and write ports resulting in unknown or corrupted read data. It is suggested to confirm via simulation that an address collision never occurs and if so it is suggested to try and avoid this situation. If address collisions cannot be avoided, the write-mode may be set to READ_FIRST which guarantees that the read data is the prior contents of the memory at the cost of additional power in the design. See the FPGA Memory Resources User Guide for additional information.2default:defaultZ23-20h px? 
?	
Rule violation (%s) %s - %s
20*drc2
REQP-1812default:default2

writefirst2default:default2?
?Synchronous clocking is detected for BRAM (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/rd_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram) in SDP mode with WRITE_FIRST write-mode. This is the preferred mode for best power characteristics, however it may exhibit address collisions if the same address appears on both read and write ports resulting in unknown or corrupted read data. It is suggested to confirm via simulation that an address collision never occurs and if so it is suggested to try and avoid this situation. If address collisions cannot be avoided, the write-mode may be set to READ_FIRST which guarantees that the read data is the prior contents of the memory at the cost of additional power in the design. See the FPGA Memory Resources User Guide for additional information.2default:defaultZ23-20h px? 
?	
Rule violation (%s) %s - %s
20*drc2
REQP-1812default:default2

writefirst2default:default2?
?Synchronous clocking is detected for BRAM (processor/inst/risc_core_inst/risc_inst/JTAG_GEN_ENABLED.risc_jtag_inst/risc_jtag_axi4_lite_wrapper_inst/risc_jtag_axi4_lite_inst/inst/jtag_axi_engine_u/wr_cmd_fifo_i/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gbm.gbmg.gbmga.ngecc.bmg/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[0].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36_NO_ECC.ram) in SDP mode with WRITE_FIRST write-mode. This is the preferred mode for best power characteristics, however it may exhibit address collisions if the same address appears on both read and write ports resulting in unknown or corrupted read data. It is suggested to confirm via simulation that an address collision never occurs and if so it is suggested to try and avoid this situation. If address collisions cannot be avoided, the write-mode may be set to READ_FIRST which guarantees that the read data is the prior contents of the memory at the cost of additional power in the design. See the FPGA Memory Resources User Guide for additional information.2default:defaultZ23-20h px? 
u
DRC finished with %s
1905*	planAhead27
#0 Errors, 78 Warnings, 4 Advisories2default:defaultZ12-3199h px? 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px? 
?
Loading data files...
1271*designutilsZ12-1165h px? 
>
Loading site data...
1273*designutilsZ12-1167h px? 
?
Loading route data...
1272*designutilsZ12-1166h px? 
?
Processing options...
1362*designutilsZ12-1514h px? 
<
Creating bitmap...
1249*designutilsZ12-1141h px? 
7
Creating bitstream...
7*	bitstreamZ40-7h px? 
Z
Writing bitstream %s...
11*	bitstream2
	./top.bit2default:defaultZ40-11h px? 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
212default:default2
792default:default2
02default:default2
02default:defaultZ4-41h px? 
a
%s completed successfully
29*	vivadotcl2#
write_bitstream2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2%
write_bitstream: 2default:default2
00:00:202default:default2
00:00:192default:default2
1385.4452default:default2
325.4922default:defaultZ17-268h px? 
`
Unable to parse hwdef file %s162*	vivadotcl2
	top.hwdef2default:defaultZ4-395h px? 


End Record
@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.1\\bin
call %xv_path%/xelab  -wto e6223402eb444511b9b1addd6f9e849b -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot kcpsm6_behav xil_defaultlib.kcpsm6 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

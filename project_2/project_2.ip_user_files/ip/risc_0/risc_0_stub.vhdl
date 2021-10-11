-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
-- Date        : Thu Oct 22 19:21:53 2020
-- Host        : DESKTOP-2340M74 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/ip/risc_0/risc_0_stub.vhdl
-- Design      : risc_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity risc_0 is
  Port ( 
    sys_clk : in STD_LOGIC;
    sys_reset : in STD_LOGIC;
    native_i : in STD_LOGIC_VECTOR ( 7 downto 0 );
    native_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    native_t : out STD_LOGIC_VECTOR ( 7 downto 0 );
    validation_reset : out STD_LOGIC
  );

end risc_0;

architecture stub of risc_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "sys_clk,sys_reset,native_i[7:0],native_o[7:0],native_t[7:0],validation_reset";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "risc_v0_1,Vivado 2016.1";
begin
end;

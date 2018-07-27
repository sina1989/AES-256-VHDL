--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Wed Apr  4 09:36:35 2018
--Host        : OmerFaruk-PC running 64-bit major release  (build 9200)
--Command     : generate_target rcon_LUT_wrapper.bd
--Design      : rcon_LUT_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity rcon_LUT_wrapper is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    BRAM_PORTA_0_en : in STD_LOGIC
  );
end rcon_LUT_wrapper;

architecture STRUCTURE of rcon_LUT_wrapper is
  component rcon_LUT is
  port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    BRAM_PORTA_0_en : in STD_LOGIC
  );
  end component rcon_LUT;
begin
rcon_LUT_i: component rcon_LUT
     port map (
      BRAM_PORTA_0_addr(7 downto 0) => BRAM_PORTA_0_addr(7 downto 0),
      BRAM_PORTA_0_clk => BRAM_PORTA_0_clk,
      BRAM_PORTA_0_dout(7 downto 0) => BRAM_PORTA_0_dout(7 downto 0),
      BRAM_PORTA_0_en => BRAM_PORTA_0_en
    );
end STRUCTURE;

--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Tue Apr 24 22:24:48 2018
--Host        : OmerFaruk-PC running 64-bit major release  (build 9200)
--Command     : generate_target gf_mul_3_LUT_wrapper.bd
--Design      : gf_mul_3_LUT_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gf_mul_3_LUT_wrapper is
  port (
    gf_mul_3_port_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gf_mul_3_port_clk : in STD_LOGIC;
    gf_mul_3_port_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gf_mul_3_port_en : in STD_LOGIC
  );
end gf_mul_3_LUT_wrapper;

architecture STRUCTURE of gf_mul_3_LUT_wrapper is
  component gf_mul_3_LUT is
  port (
    gf_mul_3_port_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gf_mul_3_port_clk : in STD_LOGIC;
    gf_mul_3_port_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gf_mul_3_port_en : in STD_LOGIC
  );
  end component gf_mul_3_LUT;
begin
gf_mul_3_LUT_i: component gf_mul_3_LUT
     port map (
      gf_mul_3_port_addr(7 downto 0) => gf_mul_3_port_addr(7 downto 0),
      gf_mul_3_port_clk => gf_mul_3_port_clk,
      gf_mul_3_port_dout(7 downto 0) => gf_mul_3_port_dout(7 downto 0),
      gf_mul_3_port_en => gf_mul_3_port_en
    );
end STRUCTURE;

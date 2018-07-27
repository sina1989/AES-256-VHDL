--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Tue Apr 24 23:09:16 2018
--Host        : OmerFaruk-PC running 64-bit major release  (build 9200)
--Command     : generate_target gf_mul_2_LUT.bd
--Design      : gf_mul_2_LUT
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity gf_mul_2_LUT is
  port (
    gf_mul_2_port_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gf_mul_2_port_clk : in STD_LOGIC;
    gf_mul_2_port_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gf_mul_2_port_en : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of gf_mul_2_LUT : entity is "gf_mul_2_LUT,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=gf_mul_2_LUT,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of gf_mul_2_LUT : entity is "gf_mul_2_LUT.hwdef";
end gf_mul_2_LUT;

architecture STRUCTURE of gf_mul_2_LUT is
  component gf_mul_2_LUT_blk_mem_gen_0_0 is
  port (
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 7 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component gf_mul_2_LUT_blk_mem_gen_0_0;
  signal BRAM_PORTA_0_1_ADDR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_1_CLK : STD_LOGIC;
  signal BRAM_PORTA_0_1_DOUT : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_1_EN : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of gf_mul_2_port_clk : signal is "xilinx.com:interface:bram:1.0 gf_mul_2_port CLK";
  attribute X_INTERFACE_INFO of gf_mul_2_port_en : signal is "xilinx.com:interface:bram:1.0 gf_mul_2_port EN";
  attribute X_INTERFACE_INFO of gf_mul_2_port_addr : signal is "xilinx.com:interface:bram:1.0 gf_mul_2_port ADDR";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of gf_mul_2_port_addr : signal is "XIL_INTERFACENAME gf_mul_2_port, MASTER_TYPE OTHER, MEM_ECC NONE, MEM_SIZE 8192, MEM_WIDTH 32, READ_WRITE_MODE READ_WRITE";
  attribute X_INTERFACE_INFO of gf_mul_2_port_dout : signal is "xilinx.com:interface:bram:1.0 gf_mul_2_port DOUT";
begin
  BRAM_PORTA_0_1_ADDR(7 downto 0) <= gf_mul_2_port_addr(7 downto 0);
  BRAM_PORTA_0_1_CLK <= gf_mul_2_port_clk;
  BRAM_PORTA_0_1_EN <= gf_mul_2_port_en;
  gf_mul_2_port_dout(7 downto 0) <= BRAM_PORTA_0_1_DOUT(7 downto 0);
blk_mem_gen_0: component gf_mul_2_LUT_blk_mem_gen_0_0
     port map (
      addra(7 downto 0) => BRAM_PORTA_0_1_ADDR(7 downto 0),
      clka => BRAM_PORTA_0_1_CLK,
      douta(7 downto 0) => BRAM_PORTA_0_1_DOUT(7 downto 0),
      ena => BRAM_PORTA_0_1_EN
    );
end STRUCTURE;

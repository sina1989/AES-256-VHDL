----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2018 01:09:54
-- Design Name: 
-- Module Name: SBOX_LUT_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity design_1_wrapper_tb is
end;

architecture bench of design_1_wrapper_tb is

  component design_1_wrapper
    port (
      BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_clk : in STD_LOGIC;
      BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
      BRAM_PORTA_0_en : in STD_LOGIC
    );
  end component;

  signal BRAM_PORTA_0_addr: STD_LOGIC_VECTOR ( 7 downto 0 ) := X"00";
  signal BRAM_PORTA_0_clk: STD_LOGIC := '0';
  signal BRAM_PORTA_0_dout: STD_LOGIC_VECTOR ( 7 downto 0 );
  signal BRAM_PORTA_0_en: STD_LOGIC := '1';

begin

  uut: design_1_wrapper port map ( BRAM_PORTA_0_addr => BRAM_PORTA_0_addr,
                                   BRAM_PORTA_0_clk  => BRAM_PORTA_0_clk,
                                   BRAM_PORTA_0_dout => BRAM_PORTA_0_dout,
                                   BRAM_PORTA_0_en   => BRAM_PORTA_0_en );

  
    stimulus: process(BRAM_PORTA_0_clk)
    begin    
        if rising_edge(BRAM_PORTA_0_clk) then
            BRAM_PORTA_0_addr <=std_logic_vector(to_unsigned(to_integer(unsigned( BRAM_PORTA_0_addr )) + 1,8));  
        end if;
    end process;
    clocking: process
    begin
        while true loop
            BRAM_PORTA_0_clk <= '0', '1' after 25 ns;
            wait for 50 ns;
        end loop;
    --wait;
    end process;

end;
  
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.aes_pkg.all;

entity key_expansion_tb is
end;

architecture bench of key_expansion_tb is

    component key_expansion
        port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable : in STD_LOGIC;
                i_cipher_256 : in aes_256_key_type;
                o_expanded_key : out expanded_key_type;
                o_ready: out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal i_cipher_256: aes_256_key_type := (
        X"00",
        X"01",
        X"02",
        X"03",
        X"04",
        X"05",
        X"06",
        X"07",
        X"08",
        X"09",
        X"0A",
        X"0B",
        X"0C",
        X"0D",
        X"0E",
        X"0F",
        X"00",
        X"01",
        X"02",
        X"03",
        X"04",
        X"05",
        X"06",
        X"07",
        X"08",
        X"09",
        X"0A",
        X"0B",
        X"0C",
        X"0D",
        X"0E",
        X"0F"        
    );
  signal o_expanded_key: expanded_key_type;
  signal o_ready: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal i_enable: STD_LOGIC;

  constant clock_period: time := 50 ns;
  signal stop_the_clock: boolean;

begin

  uut: key_expansion port map ( clk            => clk,
                                reset          => reset,
                                i_enable       => i_enable,
                                i_cipher_256   => i_cipher_256,
                                o_expanded_key => o_expanded_key,
                                o_ready        => o_ready );  

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  

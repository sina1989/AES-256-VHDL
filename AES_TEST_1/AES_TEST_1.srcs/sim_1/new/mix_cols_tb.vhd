
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

library work;
use work.aes_pkg.all;

entity mix_cols_tb is
end;

architecture bench of mix_cols_tb is

  component mix_cols
      Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             i_enable : in STD_LOGIC;
             i_state_arr : in state_arr_type;
             o_state_arr : out state_arr_type;
             o_ready : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal i_state_arr: state_arr_type:= (
      X"0F",
      X"0E",
      X"0D",
      X"0C",
      X"0B",
      X"0A",
      X"09",
      X"08",
      X"07",
      X"06",
      X"05",
      X"04",
      X"03",
      X"02",
      X"01",
      X"00"
  );
  signal o_state_arr: state_arr_type;
  signal o_ready: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal i_enable: STD_LOGIC;

  constant clock_period: time := 50 ns;
  signal stop_the_clock: boolean;

begin

  uut: mix_cols port map ( clk         => clk,
                           i_enable    => i_enable,
                           reset       => reset,
                           i_state_arr => i_state_arr,
                           o_state_arr => o_state_arr,
                           o_ready     => o_ready );

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  
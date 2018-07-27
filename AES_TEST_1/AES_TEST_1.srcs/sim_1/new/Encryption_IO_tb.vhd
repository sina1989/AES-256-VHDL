library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Encryption_IO_tb is
--  Port ( );
end Encryption_IO_tb;

architecture Behavioral of Encryption_IO_tb is
	component Encryption_IO_Wrapper
    Port ( 	clk : in STD_LOGIC;
    		sw60 : in STD_LOGIC_VECTOR (6 downto 0);
			btn : in STD_LOGIC;
			led70 : out STD_LOGIC_VECTOR (7 downto 0)
		 );
	 end component;
	 
	signal clk: STD_LOGIC := '0';
	signal reset: STD_LOGIC:= '0';    
	constant clock_period: time := 50 ns;
	signal stop_the_clock: boolean;
	
	signal sws: STD_LOGIC_VECTOR (6 downto 0):= (others=>'0');
	signal go: STD_LOGIC;
	signal leds : STD_LOGIC_VECTOR (7 downto 0);
	     
	 
begin
	
	uut: Encryption_IO_Wrapper
		port map(
			clk => clk, 	
			sw60 => sws, 
			btn => go, 
			led70 => leds
		);
    clocking: process
		begin
		    while not stop_the_clock loop
		        clk <= '0', '1' after clock_period / 2;
		        wait for clock_period;
		    end loop;
		    wait;
		end process;

end Behavioral;

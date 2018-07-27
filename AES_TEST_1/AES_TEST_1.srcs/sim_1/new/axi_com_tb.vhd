library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity axi_com_tb is
--  Port ( );
end axi_com_tb;

architecture Behavioral of axi_com_tb is
--	component Encryption_AXI_Com
--		Port (  clk: in STD_LOGIC; 	
--	    		reset : in STD_LOGIC;
--	    		in_reg : in STD_LOGIC_VECTOR (31 downto 0);
--	           	state_reg : in STD_LOGIC_VECTOR (31 downto 0);
--	           	out_reg : out STD_LOGIC_VECTOR (31 downto 0);
--	           	ready_reg : out STD_LOGIC_VECTOR (31 downto 0));
--	end component;
--    signal clk: STD_LOGIC := '0';
--    signal reset: STD_LOGIC:= '0';    
--    constant clock_period: time := 50 ns;
--    signal stop_the_clock: boolean;
    
--    signal in_regg : STD_LOGIC_VECTOR (31 downto 0):=X"A5A5A5A5";
--	signal state_regg : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0');
--	signal out_regg : STD_LOGIC_VECTOR (31 downto 0);
--	signal ready_regg : STD_LOGIC_VECTOR (31 downto 0);
    

begin
--	uut: Encryption_AXI_Com
--		port map(
--			clk => clk, 	
--			reset => reset, 
--			in_reg => in_regg, 
--			state_reg => state_regg, 
--			out_reg => out_regg, 
--			ready_reg => ready_regg
--		);
--    clocking: process
--		begin
--		    while not stop_the_clock loop
--		        clk <= '0', '1' after clock_period / 2;
--		        wait for clock_period;
--		    end loop;
--		    wait;
--		end process;
end Behavioral;

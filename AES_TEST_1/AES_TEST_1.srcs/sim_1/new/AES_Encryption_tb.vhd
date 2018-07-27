library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;


library work;
use work.aes_pkg.all;


entity AES_Encryption_tb is
end AES_Encryption_tb;


architecture Behavioral of AES_Encryption_tb is	

    component AES_Encryption
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable : in STD_LOGIC;
                i_data_top : in STD_LOGIC_VECTOR(127 downto 0);
                i_cipher_top : in STD_LOGIC_VECTOR(255 downto 0);
                o_ready: out STD_LOGIC;
                o_data_top : out STD_LOGIC_VECTOR(127 downto 0)
		);
    end component;

    signal clk: STD_LOGIC := '0';
	--	M  	E  	R  	H  	A  	B  	A  	L  	A  	R  	   	D  	U  	N  	Y  	A
    --	4D 	65 	72 	68 	61 	62 	61 	6C 	61 	72 	20 	64 	75 	6E 	79 	61
    signal i_data: STD_LOGIC_VECTOR(127 downto 0):= (
    	X"4D6572686162616C61722064756E7961" 
    );
    --000102030405060708090A0B0C0D0E0F000102030405060708090A0B0C0D0E0F
    signal i_cipher: STD_LOGIC_VECTOR(255 downto 0):= (
        X"000102030405060708090A0B0C0D0E0F000102030405060708090A0B0C0D0E0F"
        );
    signal encrypted: STD_LOGIC_VECTOR(127 downto 0);
    signal o_ready: STD_LOGIC;
    signal reset: STD_LOGIC;
    signal i_enable: STD_LOGIC;
    
    constant clock_period: time := 50 ns;
    signal stop_the_clock: boolean;
begin

    uut: AES_Encryption 
    port map(        
            clk => clk,
            reset  => reset,
            i_enable =>i_enable,
            i_data_top  => i_data,
            i_cipher_top  => i_cipher,
            o_ready => o_ready,
            o_data_top => encrypted
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




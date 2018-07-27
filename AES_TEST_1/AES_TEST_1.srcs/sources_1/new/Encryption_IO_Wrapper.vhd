library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.aes_pkg.all;


entity Encryption_IO_Wrapper is
    Port ( 	clk : in STD_LOGIC;
    		sw60 : in STD_LOGIC_VECTOR (6 downto 0);
			btn : in STD_LOGIC;
			led70 : out STD_LOGIC_VECTOR (7 downto 0)
		 );
end Encryption_IO_Wrapper;

architecture Behavioral of Encryption_IO_Wrapper is
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
	
		
	signal i_enable_enc 	: STD_LOGIC;
	signal i_data_enc 		: STD_LOGIC_VECTOR(127 downto 0);
	signal i_cipher_enc 	: STD_LOGIC_VECTOR(255 downto 0);
	signal o_ready_enc		: STD_LOGIC;
	signal o_data_enc 		: STD_LOGIC_VECTOR(127 downto 0);
	signal curr_show_byte	: integer := 0;
	signal clk_counter		: integer := 0;
	signal initial			: STD_LOGIC;
	signal divided_clk		: STD_LOGIC := '0';
	
	--MSG1 is -> "Merhablar dunya"
	signal msg1				:  STD_LOGIC_VECTOR(127 downto 0):= (
	    	X"4D6572686162616C61722064756E7961" 
	);
	--MSG2 is -> "AAAAAAAAAAAAAAAA"
	signal msg2				:  STD_LOGIC_VECTOR(127 downto 0):= (
			X"41414141414141414141414141414141"
	);
	--MSG3 is -> "gtubilmuhbitirme"	
	signal msg3				:  STD_LOGIC_VECTOR(127 downto 0):= (
			X"67747562696c6d756862697469726d65"
	);
	--KEY1 is -> "000102030405060708090A0B0C0D0E0F000102030405060708090A0B0C0D0E0F"
	signal key1				: STD_LOGIC_VECTOR(255 downto 0) := (
		X"000102030405060708090A0B0C0D0E0F000102030405060708090A0B0C0D0E0F"
	);	
	--KEY2 is -> "0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F"
	signal key2				: STD_LOGIC_VECTOR(255 downto 0):= (
		X"0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F"
	);
	--KEY3 is -> "000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A"
	signal key3				: STD_LOGIC_VECTOR(255 downto 0):= (
		X"000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A"
	);
	
begin
	encryptor:AES_Encryption
	port map(
        clk         => divided_clk,
        reset       => '0',
        i_enable 	=> i_enable_enc,
		i_data_top 		=> i_data_enc,
		i_cipher_top 	=> i_cipher_enc,
		o_ready		=> o_ready_enc,
		o_data_top		=> o_data_enc
    ); 
    
    init: process(clk) begin
    	if(initial /= '1') then
    		initial <= '1';
    		--MSG1 is -> "Merhablar dunya"
			msg1 <= X"4D6572686162616C61722064756E7961" ;
			--MSG2 is -> "AAAAAAAAAAAAAAAA"
			msg2 <=  X"41414141414141414141414141414141";
			--MSG3 is -> "gtubilmuhbitirme"	
			msg3 <= X"67747562696c6d756862697469726d65";
			--KEY1 is -> "000102030405060708090A0B0C0D0E0F000102030405060708090A0B0C0D0E0F"
			key1 <= X"000102030405060708090A0B0C0D0E0F000102030405060708090A0B0C0D0E0F";	
			--KEY2 is -> "0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F"
			key2 <= X"0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F";
			--KEY3 is -> "000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A"
			key3 <= X"000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A000A";
    	end if;
    end process;
    
	main: process(sw60, btn) begin
			i_enable_enc <= btn;
			case to_integer(unsigned(sw60(1 downto 0))) is
				when 0=>
					i_data_enc <= msg1;
				when 1=>
					i_data_enc <= msg2;
				when 2=>	
					i_data_enc <= msg3;
				when others=>
			end case;
			case to_integer(unsigned(sw60(3 downto 2))) is
				when 0=>
					i_cipher_enc <= key1;
				when 1=>
					i_cipher_enc <= key2;
				when 2=>	
					i_cipher_enc <= key3;					
				when others=>
			end case;
				led70<=o_data_enc((to_integer(unsigned(sw60(6 downto 4)))+1)*8-1 downto (to_integer(unsigned(sw60(6 downto 4)))+1)*8-8);
	end process;
	
	clk_divider: process(clk) begin
		if rising_edge(clk) then
			clk_counter <= clk_counter + 1;
			if (clk_counter mod 10000) = 0 then
				clk_counter <= 0;
				divided_clk <= not divided_clk;
			end if;
		end if;
	end process;
	
end Behavioral;

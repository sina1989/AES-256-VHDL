library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.aes_pkg.all;



entity Encryption_AXI_Com is
    Port (  clk: in STD_LOGIC; 	
    		reset : in STD_LOGIC;
    		in_reg : in STD_LOGIC_VECTOR (31 downto 0);
           	state_reg : in STD_LOGIC_VECTOR (31 downto 0);
           	out_reg : out STD_LOGIC_VECTOR (31 downto 0);
           	ready_reg : out STD_LOGIC_VECTOR (31 downto 0));
end Encryption_AXI_Com;

architecture Behavioral of Encryption_AXI_Com is
--	component AES_Encryption
--		Port (  clk : in STD_LOGIC;
--	            reset : in STD_LOGIC;
--	            i_enable : in STD_LOGIC;
--	            i_data : in state_arr_type;
--	            i_cipher : in aes_256_key_type;
--	            o_ready: out STD_LOGIC;
--	            o_data : out state_arr_type
--	            );
--	end component;
	
		
--	signal i_enable_enc 	: STD_LOGIC;
--	signal i_data_enc 		: state_arr_type;
--	signal i_cipher_enc 	: aes_256_key_type;
--	signal o_ready_enc		: STD_LOGIC;
--	signal o_data_enc 		: state_arr_type;

begin
--	encryptor:AES_Encryption
--	port map(
--        clk         => clk,
--        reset       => reset,
--        i_enable 	=> i_enable_enc,
--		i_data 		=> i_data_enc,
--		i_cipher 	=> i_cipher_enc,
--		o_ready		=> o_ready_enc,
--		o_data		=> o_data_enc
--    ); 
	
--	main: process(clk) begin
--		if rising_edge(clk) then
--			case to_integer(unsigned(state_reg)) is
--				when 1 to 4=>
--					i_data_enc((to_integer(unsigned(state_reg))-1)*4 + 0) <= in_reg(7 downto 0);
--					i_data_enc((to_integer(unsigned(state_reg))-1)*4 + 1) <= in_reg(15 downto 8);
--					i_data_enc((to_integer(unsigned(state_reg))-1)*4 + 2) <= in_reg(23 downto 16);
--					i_data_enc((to_integer(unsigned(state_reg))-1)*4 + 3) <= in_reg(31 downto 24);
--				when 5 to 12=>
--					i_cipher_enc((to_integer(unsigned(state_reg))-5)*4 + 0) <= in_reg(7 downto 0);
--					i_cipher_enc((to_integer(unsigned(state_reg))-5)*4 + 1) <= in_reg(15 downto 8 );
--					i_cipher_enc((to_integer(unsigned(state_reg))-5)*4 + 2) <= in_reg(23 downto 16);
--					i_cipher_enc((to_integer(unsigned(state_reg))-5)*4 + 3) <= in_reg(31 downto 24);
--				when 13 =>
--					i_enable_enc <= '1';
--				when 14 => 
--					i_enable_enc <= '0';
--					ready_reg <= x"0000000" & "000" & o_ready_enc;
--				when 15 to 18 =>
--					out_reg(7 downto 0)   <= o_data_enc((to_integer(unsigned(state_reg))-15)*4 + 0);
--					out_reg(15 downto 8)  <= o_data_enc((to_integer(unsigned(state_reg))-15)*4 + 1);
--					out_reg(23 downto 16) <= o_data_enc((to_integer(unsigned(state_reg))-15)*4 + 2);
--					out_reg(31 downto 24) <= o_data_enc((to_integer(unsigned(state_reg))-15)*4 + 3);
--				when others => 
--					--Empty
--			end case; 
--		end if;
--	end process;
end Behavioral;

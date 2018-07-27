library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.aes_pkg.all;


entity AES_Encryption is
    Port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            i_enable : in STD_LOGIC;
            i_data_top : in STD_LOGIC_VECTOR(127 downto 0);
            i_cipher_top : in STD_LOGIC_VECTOR(255 downto 0);
            o_ready: out STD_LOGIC;
            o_data_top : out STD_LOGIC_VECTOR(127 downto 0)
            );
end AES_Encryption;

architecture Behavioral of AES_Encryption is
-------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS START
-------------------------------------------------------------------------------
    component sub_bytes
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable : in STD_LOGIC;
                i_state_arr : in state_arr_type;
                o_state_arr : out state_arr_type;
                o_ready : out STD_LOGIC := '0');
    end component;
    component shift_rows
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable : in STD_LOGIC;
                i_state_arr : in state_arr_type;
                o_state_arr : out state_arr_type;
                o_ready : out STD_LOGIC);
    end component;
    component mix_cols
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable : in STD_LOGIC;
                i_state_arr : in state_arr_type;
                o_state_arr : out state_arr_type;
                o_ready : out STD_LOGIC);
    end component;
    component add_round_key
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable: in STD_LOGIC;
                i_state_arr : in state_arr_type;
                i_round_key : in  state_arr_type;
                o_state_arr : out state_arr_type;
                o_ready : out STD_LOGIC);
    end component;
    component key_expansion
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                i_enable : in STD_LOGIC;
                i_cipher_256 : in aes_256_key_type;
                o_expanded_key : out expanded_key_type;
                o_ready: out STD_LOGIC);
    end component;
-------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS END
-------------------------------------------------------------------------------
    signal sub_bytes_en       : STD_LOGIC := '0';
    signal shift_rows_en      : STD_LOGIC := '0';
    signal mix_cols_en        : STD_LOGIC := '0';
    signal add_round_key_en   : STD_LOGIC := '0';
    signal key_expansion_en   : STD_LOGIC := '0';
    
    signal sub_bytes_i_array            : state_arr_type;
    signal shift_rows_i_array           : state_arr_type;
    signal mix_cols_i_array             : state_arr_type;
    signal add_round_key_i_array        : state_arr_type;
    signal add_round_key_i_round_key    : state_arr_type;    
    signal key_expansion_i_cipher_256   : aes_256_key_type;
    
    signal sub_bytes_o_array            : state_arr_type;
    signal shift_rows_o_array           : state_arr_type;
    signal mix_cols_o_array             : state_arr_type;
    signal add_round_key_o_array        : state_arr_type;
    signal expanded_keys                : expanded_key_type;   
    
    signal sub_bytes_ready      : STD_LOGIC := '0';
    signal shift_rows_ready     : STD_LOGIC := '0';
    signal mix_cols_ready       : STD_LOGIC := '0';
    signal add_round_key_ready  : STD_LOGIC := '0';
    signal key_expansion_ready	: STD_LOGIC := '0';
        
    signal encrypted_msg_arr	: state_arr_type;
    signal expanded_key       	: expanded_key_type;    
    signal STATE              	: integer := 99;
    signal counter            	: integer := 0;
    
    signal i_data				: state_arr_type;
    signal i_cipher				: aes_256_key_type;
    signal o_data				: state_arr_type;
    
    
--    function to_state_arr_type (slv : in std_logic_vector(127 downto 0)) 
--    	return state_arr_type is
--        variable result : state_arr_type;
--    begin
--        for i in 0 to 15 loop
--            result(i) := slv(8*i+7 downto i);
--        end loop;
--        return result;
--    end function;
    
--	function to_aes_256_key_type (slv : in std_logic_vector(127 downto 0)) 
--    	return aes_256_key_type is
--        variable result : aes_256_key_type;
--    begin
--        for i in 0 to 31 loop
--            result(i) := slv(8*i+7 downto i);
--        end loop;
--        return result;
--    end function;
    
--	function from_state_arr_type (slv : in state_arr_type) 
--    	return std_logic_vector is
--        variable result : std_logic_vector(127 downto 0);
--    begin
--        for i in 0 to 15 loop
--            result(8*i+7 downto i) := slv(i);
--        end loop;
--        return result;
--    end function;
    
    
begin
-------------------------------------------------------------------------------
-- PORT MAPPING START
-------------------------------------------------------------------------------
    sub_bytes_module: sub_bytes 
    port map(
        clk         => clk,
        reset       => reset,
        i_enable    => sub_bytes_en,
        i_state_arr => sub_bytes_i_array,
        o_state_arr => sub_bytes_o_array,
        o_ready     => sub_bytes_ready 
    );
    shift_rows_module: shift_rows
    port map( 
        clk         => clk,
        reset       => reset,
        i_enable    => shift_rows_en,
        i_state_arr => shift_rows_i_array,
        o_state_arr => shift_rows_o_array,
        o_ready     => shift_rows_ready
    );
    mix_cols_module: mix_cols
    port map( 
        clk         => clk,
        reset       => reset,
        i_enable    => mix_cols_en,
        i_state_arr => mix_cols_i_array,
        o_state_arr => mix_cols_o_array,
        o_ready     => mix_cols_ready
    );
    add_round_key_module: add_round_key
    port map( 
        clk         => clk,
        reset       => reset,
        i_enable    => add_round_key_en,
        i_state_arr => add_round_key_i_array,
        i_round_key => add_round_key_i_round_key,
        o_state_arr => add_round_key_o_array,
        o_ready     => add_round_key_ready
    );
    key_expansion_module: key_expansion
    port map( 
        clk             => clk,
        reset           => reset,
        i_enable        => key_expansion_en,
        i_cipher_256    => i_cipher,
        o_expanded_key  => expanded_keys,
        o_ready         => key_expansion_ready
    );
-------------------------------------------------------------------------------
-- PORT MAPPING END
-------------------------------------------------------------------------------    
    main: process(clk) begin
        if rising_edge(clk) then
            if reset = '1' then
                STATE <= 99;
                counter <= 0;
            else
                case STATE is
                	when 99 => 
                		counter <= 0;
                		                		
						i_data(15)   <= i_data_top(7 downto 0)    ;  
						i_data(14)   <= i_data_top(15 downto 8)   ;  
						i_data(13)   <= i_data_top(23 downto 16)  ;  
						i_data(12)   <= i_data_top(31 downto 24)  ;  
						i_data(11)   <= i_data_top(39 downto 32)  ;  
						i_data(10)   <= i_data_top(47 downto 40)  ;  
						i_data(9)   <= i_data_top(55 downto 48)  ;  
						i_data(8)   <= i_data_top(63 downto 56)  ;  

						i_data(7)   <= i_data_top(71 downto 64)  ;  
						i_data(6)   <= i_data_top(79 downto 72)  ;  
						i_data(5)  <= i_data_top(87 downto 80)  ;  
						i_data(4)  <= i_data_top(95 downto 88)  ;  
						i_data(3)  <= i_data_top(103 downto 96) ;  
						i_data(2)  <= i_data_top(111 downto 104);  
						i_data(1)  <= i_data_top(119 downto 112);  
						i_data(0) 	<= i_data_top(127 downto 120); 						
						
 						i_cipher(31)  <= i_cipher_top(7 downto 0)    ;
						i_cipher(30)  <= i_cipher_top(15 downto 8)   ;
						i_cipher(29)  <= i_cipher_top(23 downto 16)  ;
						i_cipher(28)  <= i_cipher_top(31 downto 24)  ;
						i_cipher(27)  <= i_cipher_top(39 downto 32)  ;
						i_cipher(26)  <= i_cipher_top(47 downto 40)  ;
						i_cipher(25)   <= i_cipher_top(55 downto 48)  ;
						i_cipher(24)   <= i_cipher_top(63 downto 56)  ;
						                          
						i_cipher(23)   <= i_cipher_top(71 downto 64)  ;
						i_cipher(22)   <= i_cipher_top(79 downto 72)  ;
						i_cipher(21)   <= i_cipher_top(87 downto 80)  ;
						i_cipher(20)   <= i_cipher_top(95 downto 88)  ;
						i_cipher(19)   <= i_cipher_top(103 downto 96) ;
						i_cipher(18)   <= i_cipher_top(111 downto 104);
						i_cipher(17)   <= i_cipher_top(119 downto 112);
						i_cipher(16)   <= i_cipher_top(127 downto 120);	  
						
						i_cipher(15)   	<= i_cipher_top(135 downto 128);
						i_cipher(14)    	<= i_cipher_top(143 downto 136);
						i_cipher(13)    	<= i_cipher_top(151 downto 144);
						i_cipher(12)    	<= i_cipher_top(159 downto 152);
						i_cipher(11)    	<= i_cipher_top(167 downto 160);
						i_cipher(10)    	<= i_cipher_top(175 downto 168);
						i_cipher(9)     	<= i_cipher_top(183 downto 176);
						i_cipher(8)     	<= i_cipher_top(191 downto 184);
						                                
						i_cipher(7)     	<= i_cipher_top(199 downto 192);
						i_cipher(6)     	<= i_cipher_top(207 downto 200);
						i_cipher(5)    	<= i_cipher_top(215 downto 208);
						i_cipher(4)    	<= i_cipher_top(223 downto 216);
						i_cipher(3)    	<= i_cipher_top(231 downto 224);
						i_cipher(2)    	<= i_cipher_top(239 downto 232);
						i_cipher(1)    	<= i_cipher_top(247 downto 240);
						i_cipher(0)    	<= i_cipher_top(255 downto 248); 
 							   
 							   
                 		if i_enable = '1' then
                			o_ready <= '0';
                			STATE <= 0;
						end if;
                    when 0 => -- KEY EXPANSION						
							if key_expansion_ready /= '1' then
								key_expansion_en <= '1';
							else
								for ii in 0 to 15 loop
									encrypted_msg_arr(ii) <= i_data(ii);
								end loop;  -- ii
								key_expansion_en <= '0';
								STATE <= 1;                       
							end if; 
                    when 1 => -- ADD FIRST ROUND KEY                      
                        if add_round_key_ready  /= '1' then
                            for ii in 0 to 15 loop
                                add_round_key_i_array(ii) <= encrypted_msg_arr(ii);
                            end loop;  -- ii                            
                            for ii in 0 to 15 loop
                                add_round_key_i_round_key(ii) <= expanded_keys(ii + (16*counter));
                            end loop;  -- ii     
                            add_round_key_en <= '1';               
                        else
                            add_round_key_en <= '0';   
                            for ii in 0 to 15 loop
                                encrypted_msg_arr(ii) <= add_round_key_o_array(ii);
                            end loop;  -- ii
                            --**************** ENCRYPTION DONE !!! *****************--
                            if counter = 14 then									--
                                for ii in 0 to 15 loop								--
                                    o_data(ii) <= add_round_key_o_array(ii);		--
                                end loop;  -- ii									--
								o_data_top<= 
									o_data(15) &
									o_data(14) &
									o_data(13) &
									o_data(12) &
									o_data(11) &
									o_data(10) &
									o_data(9) &
									o_data(8) &
									o_data(7) &
									o_data(6) &
									o_data(5) &
									o_data(4) &
									o_data(3) &
									o_data(2) &
									o_data(1) &
									o_data(0);		
--								o_data_top(15 downto 8) <= o_data(1);		
--								o_data_top(23 downto 16) <= o_data(2);		
--								o_data_top(31 downto 24) <= o_data(3);		
--								o_data_top(39 downto 32) <= o_data(4);		
--								o_data_top(47 downto 40) <= o_data(5);		
--								o_data_top(55 downto 48) <= o_data(6);		
--								o_data_top(63 downto 56) <= o_data(7);		

--								o_data_top(71 downto 64) <= o_data(8);		
--								o_data_top(79 downto 72) <= o_data(9);		
--								o_data_top(87 downto 80) <= o_data(10);		
--								o_data_top(95 downto 88) <= o_data(11);		
--								o_data_top(103 downto 96) <= o_data(12);		
--								o_data_top(111 downto 104) <= o_data(13);		
--								o_data_top(119 downto 112) <= o_data(14);		
--								o_data_top(127 downto 120) <= o_data(15);		
                                o_ready <= '1';										--
                                STATE <= 99; 										--
                            --**************** ENCRYPTION DONE !!! *****************--
                            else 
                                STATE <= 2;                     
                            end if;
                        end if;
                    when 2 => -- SUB BYTES
                        if sub_bytes_ready  /= '1' then
                            sub_bytes_en <= '1';
                            for ii in 0 to 15 loop
                                sub_bytes_i_array(ii) <= encrypted_msg_arr(ii);
                            end loop;  -- ii
                        else
                            for ii in 0 to 15 loop
                                encrypted_msg_arr(ii) <= sub_bytes_o_array(ii);
                            end loop;  -- ii                            
                            sub_bytes_en <= '0';
                            STATE <= 3;       
                        end if;                        
                    when 3 => -- SHIFT ROWS
                        if shift_rows_ready /= '1' then
                            shift_rows_en <= '1';
                            for ii in 0 to 15 loop
                                shift_rows_i_array(ii) <= encrypted_msg_arr(ii);
                            end loop;  -- ii                            
                        else
                            for ii in 0 to 15 loop
                                encrypted_msg_arr(ii) <= shift_rows_o_array(ii);
                            end loop;  -- ii                          
                            shift_rows_en <= '0';
                            if counter = 13 then
                                counter <= counter + 1;
                                STATE <= 1;  
                            else 
                                STATE <= 4; 
                            end if;   
                        end if;  
                    when 4 => -- MIX COLUMNS
                        if mix_cols_ready  /= '1' then
                            mix_cols_en <= '1';
                            for ii in 0 to 15 loop
                                mix_cols_i_array(ii) <= encrypted_msg_arr(ii);
                            end loop;  -- ii                                 
                        else
                            for ii in 0 to 15 loop
                                encrypted_msg_arr(ii) <= mix_cols_o_array(ii);
                            end loop;  -- ii                              
                            mix_cols_en <= '0';
                            counter <= counter + 1;                                           
                            STATE <= 1;    
                        end if;
                    when others=>
                        -- EMPTY
                end case;                
            end if;            
        end if;
    end process;
end Behavioral;

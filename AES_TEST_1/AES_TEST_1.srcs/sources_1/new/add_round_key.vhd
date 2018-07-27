library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

library work;
use work.aes_pkg.all;


entity add_round_key is
    Port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            i_enable: in STD_LOGIC;
            i_state_arr : in state_arr_type;
            i_round_key : in  state_arr_type;
            o_state_arr : out state_arr_type;
            o_ready : out STD_LOGIC);
end add_round_key;

architecture Behavioral of add_round_key is
    signal counter : STD_LOGIC_VECTOR(4 downto 0) := "00000";
begin
    main_loop:process(clk)
    begin  
        if rising_edge(clk) then
            if reset = '1' then
                counter <= "00000";
                o_ready <= '0';
            else    
                case to_integer(unsigned(counter)) is
                    when 0 =>
                        if i_enable = '1' then
                            o_state_arr(0)  <=  i_state_arr(0)  xor i_round_key(0);
                            o_state_arr(1)  <=  i_state_arr(1)  xor i_round_key(1) ;
                            o_state_arr(2)  <=  i_state_arr(2)  xor i_round_key(2) ;
                            o_state_arr(3)  <=  i_state_arr(3)  xor i_round_key(3) ;
                            o_state_arr(4)  <=  i_state_arr(4)  xor i_round_key(4) ;
                            o_state_arr(5)  <=  i_state_arr(5)  xor i_round_key(5) ;
                            o_state_arr(6)  <=  i_state_arr(6)  xor i_round_key(6) ;
                            o_state_arr(7)  <=  i_state_arr(7)  xor i_round_key(7) ;
                            o_state_arr(8)  <=  i_state_arr(8)  xor i_round_key(8) ;
                            o_state_arr(9)  <=  i_state_arr(9)  xor i_round_key(9) ;
                            o_state_arr(10) <=  i_state_arr(10) xor i_round_key(10);
                            o_state_arr(11) <=  i_state_arr(11) xor i_round_key(11);
                            o_state_arr(12) <=  i_state_arr(12) xor i_round_key(12);
                            o_state_arr(13) <=  i_state_arr(13) xor i_round_key(13);
                            o_state_arr(14) <=  i_state_arr(14) xor i_round_key(14);
                            o_state_arr(15) <=  i_state_arr(15) xor i_round_key(15);
                            o_ready         <=  '1';
                            
                            counter <=  std_logic_vector(unsigned(counter)+1);
                        end if;
                    when 1 =>
                        counter <= "00000";
                        o_ready <= '0';
                    when others => 
                        o_ready         <= '0';
                end case;  
            end if;
        end if;        
    end process;


end Behavioral;

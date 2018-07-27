library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

library work;
use work.aes_pkg.all;


entity sub_bytes is
    Port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            i_enable : in STD_LOGIC;
            i_state_arr : in state_arr_type;
            o_state_arr : out state_arr_type;
            o_ready : out STD_LOGIC := '0');
end sub_bytes;

architecture Behavioral of sub_bytes is
-----------------------------
    component design_1_wrapper
    port ( -- SBOX LUT BROM
        BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
        BRAM_PORTA_0_clk : in STD_LOGIC;
        BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
        BRAM_PORTA_0_en : in STD_LOGIC
    );
    end component;
-----------------------------

    signal SBOX_IN : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal SBOX_OUT: STD_LOGIC_VECTOR ( 7 downto 0 );
    signal SBOX_EN: STD_LOGIC := '1'; 
    signal counter : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    
---------------------------
begin
    
    sbox_LUT:design_1_wrapper 
    port map(
        BRAM_PORTA_0_addr => SBOX_IN,
        BRAM_PORTA_0_clk => clk,
        BRAM_PORTA_0_dout => SBOX_OUT,
        BRAM_PORTA_0_en => SBOX_EN
    );
    
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
                            SBOX_IN <= i_state_arr(to_integer(unsigned(counter)));
                            counter <= std_logic_vector(unsigned(counter)+1);
                        end if;
                    when 1 to 2 =>
                        SBOX_IN <= i_state_arr(to_integer(unsigned(counter)));
                        counter <= std_logic_vector(unsigned(counter)+1);
                    when 3 to 18 =>
                        o_state_arr(to_integer(unsigned(counter))-3) <= SBOX_OUT;
                        if to_integer(unsigned(counter)) < 16 then
                            SBOX_IN <= i_state_arr(to_integer(unsigned(counter)));
                        end if;
                        if to_integer(unsigned(counter)) = 18 then -- If counter is equal to 18
                            o_ready <= '1';
                        end if;
                        counter <= std_logic_vector(unsigned(counter)+1);
                    when 19 =>
                        counter  <= "00000";    
                        o_ready <= '0';
                    when others =>
                        o_ready <= '0';
                end case;            
            end if;
        end if;        
    end process;

end Behavioral;

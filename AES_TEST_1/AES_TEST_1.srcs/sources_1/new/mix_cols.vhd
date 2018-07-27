library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

library work;
use work.aes_pkg.all;


entity mix_cols is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           i_enable : in STD_LOGIC;
           i_state_arr : in state_arr_type;
           o_state_arr : out state_arr_type;
           o_ready : out STD_LOGIC);
end mix_cols;

architecture Behavioral of mix_cols is
    component gf_mul_2_LUT_wrapper
    port (
        gf_mul_2_port_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
        gf_mul_2_port_clk : in STD_LOGIC;
        gf_mul_2_port_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
        gf_mul_2_port_en : in STD_LOGIC
    );
    end component;
    
    component gf_mul_3_LUT_wrapper
    port (
        gf_mul_3_port_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
        gf_mul_3_port_clk : in STD_LOGIC;
        gf_mul_3_port_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
        gf_mul_3_port_en : in STD_LOGIC
    );
    end component;  
    
    signal gf_mul_2_port_addr   :   STD_LOGIC_VECTOR ( 7 downto 0 );
    signal gf_mul_2_port_dout   :   STD_LOGIC_VECTOR ( 7 downto 0 );
    signal gf_mul_2_port_en     :   STD_LOGIC:='1';            
    signal gf_mul_3_port_addr   :   STD_LOGIC_VECTOR ( 7 downto 0 );
    signal gf_mul_3_port_dout   :   STD_LOGIC_VECTOR ( 7 downto 0 );
    signal gf_mul_3_port_en     :   STD_LOGIC:='1';
    
    signal gf_mul_2_res         :   state_arr_type;
    signal gf_mul_3_res         :   state_arr_type;
    signal counter              :   STD_LOGIC_VECTOR(4 downto 0) := "00000";
    
begin
    gf_mul_2_LUT_component: component gf_mul_2_LUT_wrapper
     port map (
      gf_mul_2_port_addr(7 downto 0)    => gf_mul_2_port_addr(7 downto 0),
      gf_mul_2_port_clk                 => clk,
      gf_mul_2_port_dout(7 downto 0)    => gf_mul_2_port_dout(7 downto 0),
      gf_mul_2_port_en                  => gf_mul_2_port_en
    );
    gf_mul_3_LUT_component: component gf_mul_3_LUT_wrapper
     port map (
      gf_mul_3_port_addr(7 downto 0)    => gf_mul_3_port_addr(7 downto 0),
      gf_mul_3_port_clk                 => clk,
      gf_mul_3_port_dout(7 downto 0)    => gf_mul_3_port_dout(7 downto 0),
      gf_mul_3_port_en                  => gf_mul_3_port_en
    );
        
    main_loop:process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                counter <= "00000";
                o_ready <= '0';
            else
                case to_integer(unsigned(counter)) is
                    when 0 to 2 =>
                        if i_enable = '1' then                        
                            gf_mul_2_port_addr <= i_state_arr(to_integer(unsigned(counter)));   
                            gf_mul_3_port_addr <= i_state_arr(to_integer(unsigned(counter)));                                                   
                            counter <= std_logic_vector(unsigned(counter)+1);
                        end if;
                    when 3 to 18 =>
                        gf_mul_2_res(to_integer(unsigned(counter))-3) <= gf_mul_2_port_dout;
                        gf_mul_3_res(to_integer(unsigned(counter))-3) <= gf_mul_3_port_dout;
                        
                        if to_integer(unsigned(counter)) < 16 then
                            gf_mul_2_port_addr <= i_state_arr(to_integer(unsigned(counter)));   
                            gf_mul_3_port_addr <= i_state_arr(to_integer(unsigned(counter)));        
                        end if;
                        counter <= std_logic_vector(unsigned(counter)+1);
                    when 19 =>                                        
                        o_state_arr(0)  <= gf_mul_2_res(0) xor gf_mul_3_res(1) xor i_state_arr(2) xor  i_state_arr(3);
                        o_state_arr(1)  <= i_state_arr(0) xor gf_mul_2_res(1) xor gf_mul_3_res(2) xor  i_state_arr(3);
                        o_state_arr(2)  <= i_state_arr(0) xor i_state_arr(1) xor gf_mul_2_res(2) xor  gf_mul_3_res(3);
                        o_state_arr(3)  <= gf_mul_3_res(0) xor i_state_arr(1) xor i_state_arr(2) xor  gf_mul_2_res(3);
    
                        o_state_arr(4)  <= gf_mul_2_res(4) xor gf_mul_3_res(5) xor i_state_arr(6) xor  i_state_arr(7);
                        o_state_arr(5)  <= i_state_arr(4) xor gf_mul_2_res(5) xor gf_mul_3_res(6) xor  i_state_arr(7);
                        o_state_arr(6)  <= i_state_arr(4) xor i_state_arr(5) xor gf_mul_2_res(6) xor  gf_mul_3_res(7);
                        o_state_arr(7)  <= gf_mul_3_res(4) xor i_state_arr(5) xor i_state_arr(6) xor  gf_mul_2_res(7);
    
                        o_state_arr(8)  <= gf_mul_2_res(8) xor gf_mul_3_res(9) xor i_state_arr(10) xor  i_state_arr(11);
                        o_state_arr(9)  <= i_state_arr(8) xor gf_mul_2_res(9) xor gf_mul_3_res(10) xor  i_state_arr(11);
                        o_state_arr(10) <= i_state_arr(8) xor i_state_arr(9) xor gf_mul_2_res(10) xor  gf_mul_3_res(11);
                        o_state_arr(11) <= gf_mul_3_res(8) xor i_state_arr(9) xor i_state_arr(10) xor  gf_mul_2_res(11);
    
                        o_state_arr(12) <= gf_mul_2_res(12) xor gf_mul_3_res(13) xor i_state_arr(14) xor  i_state_arr(15);
                        o_state_arr(13) <= i_state_arr(12) xor gf_mul_2_res(13) xor gf_mul_3_res(14) xor  i_state_arr(15);
                        o_state_arr(14) <= i_state_arr(12) xor i_state_arr(13) xor gf_mul_2_res(14) xor  gf_mul_3_res(15);
                        o_state_arr(15) <= gf_mul_3_res(12) xor i_state_arr(13) xor i_state_arr(14) xor  gf_mul_2_res(15); 
                        o_ready <= '1';
                        counter <= std_logic_vector(unsigned(counter)+1);
                    when 20 => 
                        counter <= "00000";
                        o_ready <= '0';
                    when others =>
                        o_ready <= '0';
                        -- Empty
                end case; 
            end if;
        end if;        
    end process;

end Behavioral;

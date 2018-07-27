library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

library work;
use work.aes_pkg.all;


entity key_expansion is
    port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            i_enable : in STD_LOGIC;
            i_cipher_256 : in aes_256_key_type;
            o_expanded_key : out expanded_key_type;
            o_ready: out STD_LOGIC);
end key_expansion;

architecture rtl of key_expansion is
    
-----------------------------
    component design_1_wrapper
    port ( -- SBOX LUT BROM
        BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
        BRAM_PORTA_0_clk : in STD_LOGIC;
        BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
        BRAM_PORTA_0_en : in STD_LOGIC
    );
    end component;
    
    component rcon_LUT_wrapper
    port ( -- SBOX LUT BROM
        BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 7 downto 0 );
        BRAM_PORTA_0_clk : in STD_LOGIC;
        BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
        BRAM_PORTA_0_en : in STD_LOGIC
    );
    end component;
----------------------------

    signal SBOX_IN : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal SBOX_OUT: STD_LOGIC_VECTOR ( 7 downto 0 );
    signal SBOX_EN: STD_LOGIC := '1';
    signal RCON_IN : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal RCON_OUT: STD_LOGIC_VECTOR ( 7 downto 0 );
    signal RCON_EN: STD_LOGIC := '1';    
    signal STATE: integer := 0;
    signal counter: integer := 0;
    signal copy_counter: integer := 0;
    signal bytes_generated: integer := 32;                      
    signal expanded_key_buf: expanded_key_type;
    signal rcon_iteration: STD_LOGIC_VECTOR ( 7 downto 0 ) := x"01"; 
    signal temp_vals : temp_vals_type;    
---------------------------
    begin
    
        sbox_LUT:design_1_wrapper 
        port map(
            BRAM_PORTA_0_addr => SBOX_IN,
            BRAM_PORTA_0_clk => clk,
            BRAM_PORTA_0_dout => SBOX_OUT,
            BRAM_PORTA_0_en => SBOX_EN
        );
        
        rcon_LUT:rcon_LUT_wrapper 
        port map(
            BRAM_PORTA_0_addr => RCON_IN,
            BRAM_PORTA_0_clk => clk,
            BRAM_PORTA_0_dout => RCON_OUT,
            BRAM_PORTA_0_en => RCON_EN
        );
        
        main_loop:process(clk)       
        begin        
            if rising_edge(clk) then
                if reset = '1' then
                    counter <= 0;
                    copy_counter <= 0;
                    bytes_generated <= 32;
                    rcon_iteration <= x"01";
                    STATE <= 0;                    
                else
                    case STATE is
                        when 0  =>
                            if i_enable = '1' and counter = 0 then
                                expanded_key_buf(counter) <= i_cipher_256(counter);
                                counter <= counter + 1;
                            end if;
                            if counter < 32  and counter > 0 then
                                expanded_key_buf(counter) <= i_cipher_256(counter);
                                counter <= counter + 1;
                            elsif counter = 32 then
                                STATE <= 1;                         
                            end if;
                        when 1  =>
                            counter <= 0;
                            STATE <= 2;
                        when 2  =>
                            if counter < 4 then
                                temp_vals(counter) <= expanded_key_buf(counter + bytes_generated - 4);
                                counter <= counter + 1;
                            else
                                STATE <= 3;
                            end if;
                        when 3  =>
                            counter <= 0;
                            if bytes_generated mod 32 = 0 then
                                STATE <= 5;
                            elsif bytes_generated mod 16 = 0 then
                                STATE<= 4;
                            else
                                STATE<= 8;
                            end if;
                        when 4  =>
                            case counter is
                                when 0 to 3 =>
                                    SBOX_IN  <= temp_vals(counter);
                                    counter <= counter + 1;
                                    if counter = 3 then
                                        temp_vals(counter - 3) <= SBOX_OUT;
                                    end if;
                                when 4 to 6 =>
                                    temp_vals(counter - 3) <= SBOX_OUT;
                                    counter <= counter + 1;                                
                                when others =>
                                    STATE <= 8;
                            end case; --  case counter is
                        when 5  =>
                            temp_vals <= temp_vals(1 to temp_vals'high) & temp_vals(0);
                            STATE <= 6;
                        when 6  =>
                            case counter is
                            when 0 to 3 =>
                                SBOX_IN  <= temp_vals(counter);
                                counter <= counter + 1;
                                if counter = 3 then
                                    temp_vals(counter - 3) <= SBOX_OUT;
                                end if;
                            when 4 to 6 =>
                                temp_vals(counter - 3) <= SBOX_OUT;
                                counter <= counter + 1;                                
                            when others =>
                                counter <= 0;                                
                                STATE <= 7;
                            end case; --  case counter is
                        when 7  =>
                            case counter is
                            when 0 to 2=>
                                RCON_IN  <=  rcon_iteration;
                                counter <= counter + 1;
                            when 3 =>
                                temp_vals(0) <= temp_vals(0) xor RCON_OUT;
                                rcon_iteration <= std_logic_vector(unsigned(rcon_iteration) + 1);
                                counter <= counter + 1;
                            when others =>
                                STATE <= 8;
                            end case; --  case counter is                        
                        when 8  =>
                            counter <= 0;
                            STATE <= 9;                        
                        when 9  =>
                            if counter < 4 then
                                expanded_key_buf(bytes_generated) <= expanded_key_buf(bytes_generated - 32) xor temp_vals(counter);
                                counter <= counter + 1;   
                                bytes_generated <= bytes_generated + 1;
                            elsif bytes_generated < 240 then
                                STATE <= 1;
                            else
                                if copy_counter < 225 then
                                    o_expanded_key(copy_counter) <= expanded_key_buf(copy_counter);
                                    o_expanded_key(copy_counter+1) <= expanded_key_buf(copy_counter+1);
                                    o_expanded_key(copy_counter+2) <= expanded_key_buf(copy_counter+2);
                                    o_expanded_key(copy_counter+3) <= expanded_key_buf(copy_counter+3);                                
                                    o_expanded_key(copy_counter+4) <= expanded_key_buf(copy_counter+4);
                                    o_expanded_key(copy_counter+5) <= expanded_key_buf(copy_counter+5);
                                    o_expanded_key(copy_counter+6) <= expanded_key_buf(copy_counter+6);
                                    o_expanded_key(copy_counter+7) <= expanded_key_buf(copy_counter+7);                                
                                    o_expanded_key(copy_counter+8) <= expanded_key_buf(copy_counter+8);
                                    o_expanded_key(copy_counter+9) <= expanded_key_buf(copy_counter+9);
                                    o_expanded_key(copy_counter+10) <= expanded_key_buf(copy_counter+10);
                                    o_expanded_key(copy_counter+11) <= expanded_key_buf(copy_counter+11);                                
                                    o_expanded_key(copy_counter+12) <= expanded_key_buf(copy_counter+12);
                                    o_expanded_key(copy_counter+13) <= expanded_key_buf(copy_counter+13);
                                    o_expanded_key(copy_counter+14) <= expanded_key_buf(copy_counter+14);
                                    o_expanded_key(copy_counter+15) <= expanded_key_buf(copy_counter+15);
                                    copy_counter <= copy_counter + 1;
                                else
                                    o_ready <= '1';
                                    STATE <= 10;
                                end if;    
                            end if;
                        when 10 =>
                            counter <= 0;
                            copy_counter <= 0;
                            bytes_generated <= 32;
                            o_ready <= '0';
                            rcon_iteration <= x"01";
                            STATE <= 0;      
                        when others =>
    --                    -- Empty statement to prevent latch generation
                    end case; -- case STATE is        
                end if;    
            end if; -- rising_edge(clk) then
        end process; -- main_loop:process(clk)    

end rtl;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package aes_pkg is
    type temp_vals_type is array (0 to 3) of std_logic_vector(7 downto 0);
    type state_arr_type is array (0 to 15) of std_logic_vector(7 downto 0);
    type io_data_type is array (0 to 15) of std_logic_vector(7 downto 0);
    type expanded_key_type is array (0 to 239) of std_logic_vector(7 downto 0);
    type aes_256_key_type is array (0 to 31) of std_logic_vector(7 downto 0);
end package;
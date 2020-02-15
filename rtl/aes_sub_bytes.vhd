--
-- Written by Michael Mattioli
--
-- Description: AES SubBytes operation.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_sub_bytes is
    port (  state   : in std_logic_vector(127 downto 0);
            inverse : in std_logic;
            result  : out std_logic_vector(127 downto 0));
end aes_sub_bytes;

architecture structural of aes_sub_bytes is

    signal normal_substitution : std_logic_vector(127 downto 0);
    signal inverse_substitution : std_logic_vector(127 downto 0);

begin
    
    substitution : for i in 0 to 15 generate
        normal_substitution((8*(i+1))-1 downto (8*i)) <= normal_sbox(conv_integer(state((8*(i+1))-1 downto (8*i)+4)), conv_integer(state((8*(i+1))-1-4 downto (8*i))));
        inverse_substitution((8*(i+1))-1 downto (8*i)) <= inverse_sbox(conv_integer(state((8*(i+1))-1 downto (8*i)+4)), conv_integer(state((8*(i+1))-1-4 downto (8*i))));
    end generate substitution;
    
    result <= normal_substitution when inverse = '0' else inverse_substitution;

end structural;

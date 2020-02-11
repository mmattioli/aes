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

    component aes_sbox is
        port (  input   : in std_logic_vector(7 downto 0);
                inverse : in std_logic;
                output  : out std_logic_vector(7 downto 0));
    end component;

begin

    substitution : for i in 0 to 15 generate
        sbox : aes_sbox port map (  input => state((8*(i+1))-1 downto (8*i)),
                                    inverse => inverse,
                                    output => result((8*(i+1))-1 downto (8*i)));
    end generate substitution;

end structural;

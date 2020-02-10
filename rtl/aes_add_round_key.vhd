--
-- Written by Michael Mattioli
--
-- Description: AES AddRoundKey operation.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_add_round_key is
    port (  state       : in std_logic_vector(127 downto 0);
            round_key   : in std_logic_vector(127 downto 0);
            result      : out std_logic_vector(127 downto 0));
end aes_add_round_key;

architecture structural of aes_add_round_key is

begin

    add_round_key : for i in 0 to 15 generate
        -- When i is 15: ((8*(15+1))-1 = ((8*(16))-1 = (128)-1 = 127 | (8*i) = (8*15) = 120 | 127 downto 120
        -- When i is 0: ((8*(0+1))-1 = ((8*(1))-1 = (8)-1 = 7 | (8*i) = (8*0) = 0 | 7 downto 0
        result((8*(i+1))-1 downto (8*i)) <= state((8*(i+1))-1 downto (8*i)) xor round_key((8*(i+1))-1 downto (8*i));
    end generate add_round_key;

end structural;

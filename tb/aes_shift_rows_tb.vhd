--
-- Written by Michael Mattioli
--
-- Description: AES ShiftRows testbcnch.
--

library std;
library ieee;
use std.env.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_shift_rows_tb is
end aes_shift_rows_tb;

architecture structural of aes_shift_rows_tb is

    component aes_shift_rows
        port (  state    : in std_logic_vector(127 downto 0);
                inverse  : in std_logic;
                result   : out std_logic_vector(127 downto 0));
    end component;

    signal state : std_logic_vector(127 downto 0);
    signal inverse : std_logic;
    signal result : std_logic_vector(127 downto 0);

begin

    --- Instantiate the unit under test.
    uut: aes_shift_rows port map (  state => state,
                                    inverse => inverse,
                                    result => result);

    -- Apply the stimuli.
    stimuli : process
    begin
    
        -- Normal operation.
        inverse <= '0';
        state <= x"63cab7040953d051cd60e0e7ba70e18c";
        wait for 1 ns;
        assert (result = x"6353e08c0960e104cd70b751bacad0e7");
        
        state <= x"a761ca9b97be8b45d8ad1a611fc97369";
        wait for 1 ns;
        assert (result = x"a7be1a6997ad739bd8c9ca451f618b61");
        
        state <= x"3b59cb73fcd90ee05774222dc067fb68";
        wait for 1 ns;
        assert (result = x"3bd92268fc74fb735767cbe0c0590e2d");
        
        state <= x"2dfb02343f6d12dd09337ec75b36e3f0";
        wait for 1 ns;
        assert (result = x"2d6d7ef03f33e334093602dd5bfb12c7");
        
        state <= x"36400926f9336d2d9fb59d23c42c3950";
        wait for 1 ns;
        assert (result = x"36339d50f9b539269f2c092dc4406d23");
        
        state <= x"e847f56514dadde23f77b64fe7f7d490";
        wait for 1 ns;
        assert (result = x"e8dab6901477d4653ff7f5e2e747dd4f");
        
        state <= x"b415f8016858552e4bb6124c5f998a4c";
        wait for 1 ns;
        assert (result = x"b458124c68b68a014b99f82e5f15554c");
        
        state <= x"3e175076b61c04678dfc2295f6a8bfc0";
        wait for 1 ns;
        assert (result = x"3e1c22c0b6fcbf768da85067f6170495");

        state <= x"5411f4b56bd9700e96a0902fa1bb9aa1";
        wait for 1 ns;
        assert (result = x"54d990a16ba09ab596bbf40ea111702f");
        
        state <= x"7a9f102789d5f50b2beffd9f3dca4ea7";
        wait for 1 ns;
        assert (result = x"7ad5fda789ef4e272bca100b3d9ff59f");
        
        -- Inverse operation.
        inverse <= '1';
        state <= x"7ad5fda789ef4e272bca100b3d9ff59f";
        wait for 1 ns;
        assert (result = x"7a9f102789d5f50b2beffd9f3dca4ea7");
        
        state <= x"54d990a16ba09ab596bbf40ea111702f";
        wait for 1 ns;
        assert (result = x"5411f4b56bd9700e96a0902fa1bb9aa1");
        
        state <= x"3e1c22c0b6fcbf768da85067f6170495";
        wait for 1 ns;
        assert (result = x"3e175076b61c04678dfc2295f6a8bfc0");
        
        state <= x"b458124c68b68a014b99f82e5f15554c";
        wait for 1 ns;
        assert (result = x"b415f8016858552e4bb6124c5f998a4c");
        
        state <= x"e8dab6901477d4653ff7f5e2e747dd4f";
        wait for 1 ns;
        assert (result = x"e847f56514dadde23f77b64fe7f7d490");
        
        state <= x"36339d50f9b539269f2c092dc4406d23";
        wait for 1 ns;
        assert (result = x"36400926f9336d2d9fb59d23c42c3950");
        
        state <= x"2d6d7ef03f33e334093602dd5bfb12c7";
        wait for 1 ns;
        assert (result = x"2dfb02343f6d12dd09337ec75b36e3f0");
        
        state <= x"3bd92268fc74fb735767cbe0c0590e2d";
        wait for 1 ns;
        assert (result = x"3b59cb73fcd90ee05774222dc067fb68");
        
        state <= x"a7be1a6997ad739bd8c9ca451f618b61";
        wait for 1 ns;
        assert (result = x"a761ca9b97be8b45d8ad1a611fc97369");
        
        state <= x"6353e08c0960e104cd70b751bacad0e7";
        wait for 1 ns;
        assert (result = x"63cab7040953d051cd60e0e7ba70e18c");
        
        finish(0);
        
    end process stimuli;

end structural;

--
-- Written by Michael Mattioli
--
-- Description: AES MixColumns testbench.
--

library std;
library ieee;
use std.env.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_mix_columns_tb is
end aes_mix_columns_tb;

architecture behavioral of aes_mix_columns_tb is

    component aes_mix_columns is
        port (  state   : in std_logic_vector(127 downto 0);
                inverse : in std_logic;
                result  : out std_logic_vector(127 downto 0));
    end component;

    signal state : std_logic_vector(127 downto 0);
    signal inverse : std_logic;
    signal result : std_logic_vector(127 downto 0);

begin

    --Instantiate the unit under test.
    uut: aes_mix_columns port map ( state => state,
                                    inverse => inverse,
                                    result => result);
    
    -- Apply the stimuli.
    stimuli : process
    begin
    
        -- Standard operation.
        inverse <= '0';
        
        state <= x"6353e08c0960e104cd70b751bacad0e7";
        wait for 1 ns;
        assert (result = x"5f72641557f5bc92f7be3b291db9f91a");
        
        state <= x"a7be1a6997ad739bd8c9ca451f618b61";
        wait for 1 ns;
        assert (result = x"ff87968431d86a51645151fa773ad009");
        
        state <= x"3bd92268fc74fb735767cbe0c0590e2d";
        wait for 1 ns;
        assert (result = x"4c9c1e66f771f0762c3f868e534df256");
        
        state <= x"2d6d7ef03f33e334093602dd5bfb12c7";
        wait for 1 ns;
        assert (result = x"6385b79ffc538df997be478e7547d691");
        
        state <= x"36339d50f9b539269f2c092dc4406d23";
        wait for 1 ns;
        assert (result = x"f4bcd45432e554d075f1d6c51dd03b3c");
        
        state <= x"e8dab6901477d4653ff7f5e2e747dd4f";
        wait for 1 ns;
        assert (result = x"9816ee7400f87f556b2c049c8e5ad036");
        
        state <= x"b458124c68b68a014b99f82e5f15554c";
        wait for 1 ns;
        assert (result = x"c57e1c159a9bd286f05f4be098c63439");
        
        state <= x"3e1c22c0b6fcbf768da85067f6170495";
        wait for 1 ns;
        assert (result = x"baa03de7a1f9b56ed5512cba5f414d23");
        
        state <= x"54d990a16ba09ab596bbf40ea111702f";
        wait for 1 ns;
        assert (result = x"e9f74eec023020f61bf2ccf2353c21c7");
        
        finish(0);
    
    end process stimuli;

end behavioral;

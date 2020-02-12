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
        
        -- Inverse operation.
        inverse <= '1';
        
        state <= x"bd6e7c3df2b5779e0b61216e8b10b689";
        wait for 1 ns;
        assert (result = x"4773b91ff72f354361cb018ea1e6cf2c");
        
        state <= x"fde3bad205e5d0d73547964ef1fe37f1";
        wait for 1 ns;
        assert (result = x"2d7e86a339d9393ee6570a1101904e16");
        
        state <= x"d1876c0f79c4300ab45594add66ff41f";
        wait for 1 ns;
        assert (result = x"39daee38f4f1a82aaf432410c36d45b9");
        
        state <= x"c62fe109f75eedc3cc79395d84f9cf5d";
        wait for 1 ns;
        assert (result = x"9a39bf1d05b20a3a476a0bf79fe51184");
        
        state <= x"c81677bc9b7ac93b25027992b0261996";
        wait for 1 ns;
        assert (result = x"18f78d779a93eef4f6742967c47f5ffd");
        
        state <= x"247240236966b3fa6ed2753288425b6c";
        wait for 1 ns;
        assert (result = x"85cf8bf472d124c10348f545329c0053");
        
        state <= x"fa636a2825b339c940668a3157244d17";
        wait for 1 ns;
        assert (result = x"fc1fc1f91934c98210fbfb8da340eb21");
        
        state <= x"4915598f55e5d7a0daca94fa1f0a63f7";
        wait for 1 ns;
        assert (result = x"076518f0b52ba2fb7a15c8d93be45e00");
        
        state <= x"89d810e8855ace682d1843d8cb128fe4";
        wait for 1 ns;
        assert (result = x"ef053f7c8b3d32fd4d2a64ad3c93071a");
        
        finish(0);
    
    end process stimuli;

end behavioral;

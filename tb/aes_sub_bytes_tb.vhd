--
-- Written by Michael Mattioli
--
-- Description: AES SubBytes testbench.
--

library std;
library ieee;
use std.env.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_sub_bytes_tb is
end aes_sub_bytes_tb;

architecture behavioral of aes_sub_bytes_tb is

    component aes_sub_bytes is
        port (  state   : in std_logic_vector(127 downto 0);
                inverse : in std_logic;
                result  : out std_logic_vector(127 downto 0));
    end component;

    signal state : std_logic_vector(127 downto 0);
    signal inverse : std_logic;
    signal result : std_logic_vector(127 downto 0);

begin

    --Instantiate the unit under test.
    uut: aes_sub_bytes port map (   state => state,
                                    inverse => inverse,
                                    result => result);

    -- Apply the stimuli.
    stimuli : process
    begin

        -- Standard operation.
        inverse <= '0';

        state <= x"00102030405060708090a0b0c0d0e0f0";
        wait for 5 ns;
        assert (result = x"63cab7040953d051cd60e0e7ba70e18c");

        state <= x"89d810e8855ace682d1843d8cb128fe4";
        wait for 5 ns;
        assert (result = x"a761ca9b97be8b45d8ad1a611fc97369");

        state <= x"4915598f55e5d7a0daca94fa1f0a63f7";
        wait for 5 ns;
        assert (result = x"3b59cb73fcd90ee05774222dc067fb68");

        state <= x"fa636a2825b339c940668a3157244d17";
        wait for 5 ns;
        assert (result = x"2dfb02343f6d12dd09337ec75b36e3f0");

        state <= x"247240236966b3fa6ed2753288425b6c";
        wait for 5 ns;
        assert (result = x"36400926f9336d2d9fb59d23c42c3950");

        state <= x"c81677bc9b7ac93b25027992b0261996";
        wait for 5 ns;
        assert (result = x"e847f56514dadde23f77b64fe7f7d490");

        state <= x"c62fe109f75eedc3cc79395d84f9cf5d";
        wait for 5 ns;
        assert (result = x"b415f8016858552e4bb6124c5f998a4c");

        state <= x"d1876c0f79c4300ab45594add66ff41f";
        wait for 5 ns;
        assert (result = x"3e175076b61c04678dfc2295f6a8bfc0");

        state <= x"fde3bad205e5d0d73547964ef1fe37f1";
        wait for 5 ns;
        assert (result = x"5411f4b56bd9700e96a0902fa1bb9aa1");

        state <= x"bd6e7c3df2b5779e0b61216e8b10b689";
        wait for 5 ns;
        assert (result = x"7a9f102789d5f50b2beffd9f3dca4ea7");

        -- Inverse operation.
        inverse <= '1';

        state <= x"7a9f102789d5f50b2beffd9f3dca4ea7";
        wait for 5 ns;
        assert (result = x"bd6e7c3df2b5779e0b61216e8b10b689");

        state <= x"5411f4b56bd9700e96a0902fa1bb9aa1";
        wait for 5 ns;
        assert (result = x"fde3bad205e5d0d73547964ef1fe37f1");

        state <= x"3e175076b61c04678dfc2295f6a8bfc0";
        wait for 5 ns;
        assert (result = x"d1876c0f79c4300ab45594add66ff41f");

        state <= x"b415f8016858552e4bb6124c5f998a4c";
        wait for 5 ns;
        assert (result = x"c62fe109f75eedc3cc79395d84f9cf5d");

        state <= x"e847f56514dadde23f77b64fe7f7d490";
        wait for 5 ns;
        assert (result = x"c81677bc9b7ac93b25027992b0261996");

        state <= x"36400926f9336d2d9fb59d23c42c3950";
        wait for 5 ns;
        assert (result = x"247240236966b3fa6ed2753288425b6c");

        state <= x"2dfb02343f6d12dd09337ec75b36e3f0";
        wait for 5 ns;
        assert (result = x"fa636a2825b339c940668a3157244d17");

        state <= x"3b59cb73fcd90ee05774222dc067fb68";
        wait for 5 ns;
        assert (result = x"4915598f55e5d7a0daca94fa1f0a63f7");

        state <= x"a761ca9b97be8b45d8ad1a611fc97369";
        wait for 5 ns;
        assert (result = x"89d810e8855ace682d1843d8cb128fe4");

        state <= x"63cab7040953d051cd60e0e7ba70e18c";
        wait for 5 ns;
        assert (result = x"00102030405060708090a0b0c0d0e0f0");

        finish(0);

    end process stimuli;

end behavioral;

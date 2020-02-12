--
-- Written by Michael Mattioli
--
-- Description: AES AddRoundKey testbench.
--

library std;
library ieee;
use std.env.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_add_round_key_tb is
end aes_add_round_key_tb;

architecture structural of aes_add_round_key_tb is

    component aes_add_round_key
        port (  state       : in std_logic_vector(127 downto 0);
                round_key   : in std_logic_vector(127 downto 0);
                result      : out std_logic_vector(127 downto 0));
    end component;

    signal state : std_logic_vector(127 downto 0);
    signal round_key : std_logic_vector(127 downto 0);
    signal result : std_logic_vector(127 downto 0);

begin

    -- Instantiate the unit under test.
    uut: aes_add_round_key port map (   state => state,
                                        round_key => round_key,
                                        result => result);

    -- Apply the stimuli.
    stimuli : process
    begin

        state <= x"00112233445566778899aabbccddeeff";
        round_key <= x"000102030405060708090a0b0c0d0e0f";
        wait for 1 ns;
        assert (result = x"00102030405060708090a0b0c0d0e0f0");

        state <= x"5f72641557f5bc92f7be3b291db9f91a";
        round_key <= x"d6aa74fdd2af72fadaa678f1d6ab76fe";
        wait for 1 ns;
        assert (result = x"89d810e8855ace682d1843d8cb128fe4");

        state <= x"ff87968431d86a51645151fa773ad009";
        round_key <= x"b692cf0b643dbdf1be9bc5006830b3fe";
        wait for 1 ns;
        assert (result = x"4915598f55e5d7a0daca94fa1f0a63f7");

        state <= x"4c9c1e66f771f0762c3f868e534df256";
        round_key <= x"b6ff744ed2c2c9bf6c590cbf0469bf41";
        wait for 1 ns;
        assert (result = x"fa636a2825b339c940668a3157244d17");

        state <= x"6385b79ffc538df997be478e7547d691";
        round_key <= x"47f7f7bc95353e03f96c32bcfd058dfd";
        wait for 1 ns;
        assert (result = x"247240236966b3fa6ed2753288425b6c");

        state <= x"f4bcd45432e554d075f1d6c51dd03b3c";
        round_key <= x"3caaa3e8a99f9deb50f3af57adf622aa";
        wait for 1 ns;
        assert (result = x"c81677bc9b7ac93b25027992b0261996");

        state <= x"9816ee7400f87f556b2c049c8e5ad036";
        round_key <= x"5e390f7df7a69296a7553dc10aa31f6b";
        wait for 1 ns;
        assert (result = x"c62fe109f75eedc3cc79395d84f9cf5d");

        state <= x"c57e1c159a9bd286f05f4be098c63439";
        round_key <= x"14f9701ae35fe28c440adf4d4ea9c026";
        wait for 1 ns;
        assert (result = x"d1876c0f79c4300ab45594add66ff41f");

        state <= x"baa03de7a1f9b56ed5512cba5f414d23";
        round_key <= x"47438735a41c65b9e016baf4aebf7ad2";
        wait for 1 ns;
        assert (result = x"fde3bad205e5d0d73547964ef1fe37f1");

        state <= x"e9f74eec023020f61bf2ccf2353c21c7";
        round_key <= x"549932d1f08557681093ed9cbe2c974e";
        wait for 1 ns;
        assert (result = x"bd6e7c3df2b5779e0b61216e8b10b689");

        state <= x"7ad5fda789ef4e272bca100b3d9ff59f";
        round_key <= x"13111d7fe3944a17f307a78b4d2b30c5";
        wait for 1 ns;
        assert (result = x"69c4e0d86a7b0430d8cdb78070b4c55a");

        finish(0);

    end process stimuli;

end structural;

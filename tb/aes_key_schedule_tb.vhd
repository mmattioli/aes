--
-- Written by Michael Mattioli
--
-- Description: AES key schedule testbench.
--

library std;
library ieee;
use std.env.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_key_schedule_tb is
end aes_key_schedule_tb;

architecture behavioral of aes_key_schedule_tb is

    component aes_key_schedule is
        port (  clk         : in std_logic;
                rst         : in std_logic;
                enable      : in std_logic;
                key         : in std_logic_vector(127 downto 0);
                round_keys  : out std_logic_vector((128*(rounds+1))-1 downto 0);
                complete    : out std_logic);
    end component aes_key_schedule;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal enable : std_logic := '0';
    signal key : std_logic_vector(127 downto 0);
    signal round_keys : std_logic_vector((128*(rounds+1))-1 downto 0);
    signal complete : std_logic;
    
    constant clock_period : time := 10ns;

begin

    --Instantiate the unit under test.
    uut: aes_key_schedule port map (clk => clk,
                                    rst => rst,
                                    enable => enable,
                                    key => key,
                                    round_keys => round_keys,
                                    complete => complete);

    -- Apply the clock.
    applied_clock : process
    begin
        wait for clock_period / 2;
        clk <= not clk;
    end process applied_clock;
    
    -- Apply the stimuli.
    stimuli : process
    begin
        key <= x"6920e299a5202a6d656e636869746f2a";
        enable <= '1';
        wait until complete = '1';
        assert (round_keys =    x"6920e299a5202a6d656e636869746f2a" & -- 0
                                x"fa8807605fa82d0d3ac64e6553b2214f" & -- 1
                                x"cf75838d90ddae80aa1be0e5f9a9c1aa" & -- 2
                                x"180d2f1488d0819422cb6171db62a0db" & -- 3
                                x"baed96ad323d173910f67648cb94d693" & -- 4
                                x"881b4ab2ba265d8baad02bc36144fd50" & -- 5
                                x"b34f195d096944d6a3b96f15c2fd9245" & -- 6
                                x"a7007778ae6933ae0dd05cbbcf2dcefe" & -- 7
                                x"ff8bccf251e2ff5c5c32a3e7931f6d19" & -- 8
                                x"24b7182e7555e77229674495ba78298c" & -- 9
                                x"ae127cdadb479ba8f220df3d4858f6b1"); -- 10
        
        enable <= '0';
        key <=x"2b7e151628aed2a6abf7158809cf4f3c";
        rst <='1';
        wait for clock_period * 2;
        rst <= '0';
        enable <= '1';
        wait until complete = '1';
        assert (round_keys =    x"2b7e151628aed2a6abf7158809cf4f3c" & 
                                x"a0fafe1788542cb123a339392a6c7605" &
                                x"f2c295f27a96b9435935807a7359f67f" &
                                x"3d80477d4716fe3e1e237e446d7a883b" &
                                x"ef44a541a8525b7fb671253bdb0bad00" &
                                x"d4d1c6f87c839d87caf2b8bc11f915bc" &
                                x"6d88a37a110b3efddbf98641ca0093fd" &
                                x"4e54f70e5f5fc9f384a64fb24ea6dc4f" &
                                x"ead27321b58dbad2312bf5607f8d292f" &
                                x"ac7766f319fadc2128d12941575c006e" &
                                x"d014f9a8c9ee2589e13f0cc8b6630ca6");
                        
        
        finish(0);
    end process stimuli;

end behavioral;

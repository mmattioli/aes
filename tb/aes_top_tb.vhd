--
-- Written by Michael Mattioli
--
-- Description: AES top level testbench.
--

library std;
library ieee;
use std.env.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_top_tb is
end aes_top_tb;

architecture behavioral of aes_top_tb is

    component aes_top is
        port (  clk         : in std_logic;
                rst         : in std_logic;
                enable      : in std_logic;
                inverse     : in std_logic;
                key         : in std_logic_vector(127 downto 0);
                input       : in std_logic_vector(127 downto 0);
                output      : out std_logic_vector(127 downto 0);
                complete    : out std_logic);
    end component aes_top;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal enable : std_logic := '0';
    signal inverse : std_logic := '0';
    signal key : std_logic_vector(127 downto 0);
    signal input : std_logic_vector(127 downto 0);
    signal output : std_logic_vector(127 downto 0);
    signal complete : std_logic;
    
    constant clock_period : time := 10ns;

begin

    --Instantiate the unit under test.
    uut: aes_top port map ( clk => clk,
                            rst => rst,
                            enable => enable,
                            inverse => inverse,
                            key => key,
                            input => input,
                            output => output,
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
        
        -- Encryption.
        inverse <= '0';
        
        enable <= '0';
        key <= x"2b7e151628aed2a6abf7158809cf4f3c";
        input <= x"00000000000000000000000000000000";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"7df76b0c1ab899b33e42f047b91b546f");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        key <= x"2b7e151628aed2a6abf7158809cf4f3c";
        input <= x"ae2d8a571e03ac9c9eb76fac45af8e51";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"f5d3d58503b9699de785895a96fdbaaf");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        key <= x"00000000000000000000000000000000";
        input <= x"f69f2445df4f9b17ad2b417be66c3710";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"664dfe9e123959a00127484f77fbad63");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        key <= x"00000000000000000000000000000000";
        input <= x"00000000000000000000000000000000";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"66e94bd4ef8a2c3b884cfa59ca342b2e");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        -- Decryption.
        inverse <= '1';
        
        key <= x"2b7e151628aed2a6abf7158809cf4f3c";
        input <= x"7df76b0c1ab899b33e42f047b91b546f";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"00000000000000000000000000000000");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        key <= x"2b7e151628aed2a6abf7158809cf4f3c";
        input <= x"f5d3d58503b9699de785895a96fdbaaf";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"ae2d8a571e03ac9c9eb76fac45af8e51");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        key <= x"00000000000000000000000000000000";
        input <= x"664dfe9e123959a00127484f77fbad63";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"f69f2445df4f9b17ad2b417be66c3710");
        
        rst <= '1';
        wait for clock_period * 2;
        rst <= '0';
        
        key <= x"00000000000000000000000000000000";
        input <= x"66e94bd4ef8a2c3b884cfa59ca342b2e";
        enable <= '1';
        wait until complete = '1';
        enable <= '0';
        assert (output = x"00000000000000000000000000000000");
        
        finish(0);
    end process stimuli;

end behavioral;

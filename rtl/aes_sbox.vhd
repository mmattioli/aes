--
-- Written by Michael Mattioli
--
-- Description: AES S-Box.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_sbox is
    port (  input   : in std_logic_vector(7 downto 0);
            inverse : in std_logic;
            output  : out std_logic_vector(7 downto 0));
end aes_sbox;

architecture structural of aes_sbox is
begin

    lut: process(inverse, input)
    begin

        -- Standard S-Box.
        if inverse = '0' then
            case input is

                -- Row 0.
                when x"00" => output <= x"63";
                when x"01" => output <= x"7c";
                when x"02" => output <= x"77";
                when x"03" => output <= x"7b";
                when x"04" => output <= x"f2";
                when x"05" => output <= x"6b";
                when x"06" => output <= x"6f";
                when x"07" => output <= x"c5";
                when x"08" => output <= x"30";
                when x"09" => output <= x"01";
                when x"0a" => output <= x"67";
                when x"0b" => output <= x"2b";
                when x"0c" => output <= x"fe";
                when x"0d" => output <= x"d7";
                when x"0e" => output <= x"ab";
                when x"0f" => output <= x"76";
                
                -- Row 1.
                when x"10" => output <= x"ca";
                when x"11" => output <= x"82";
                when x"12" => output <= x"c9";
                when x"13" => output <= x"7d";
                when x"14" => output <= x"fa";
                when x"15" => output <= x"59";
                when x"16" => output <= x"47";
                when x"17" => output <= x"f0";
                when x"18" => output <= x"ad";
                when x"19" => output <= x"d4";
                when x"1a" => output <= x"a2";
                when x"1b" => output <= x"af";
                when x"1c" => output <= x"9c";
                when x"1d" => output <= x"a4";
                when x"1e" => output <= x"72";
                when x"1f" => output <= x"c0";
                
                -- Row 2.
                when x"20" => output <= x"b7";
                when x"21" => output <= x"fd";
                when x"22" => output <= x"93";
                when x"23" => output <= x"26";
                when x"24" => output <= x"36";
                when x"25" => output <= x"3f";
                when x"26" => output <= x"f7";
                when x"27" => output <= x"cc";
                when x"28" => output <= x"34";
                when x"29" => output <= x"a5";
                when x"2a" => output <= x"e5";
                when x"2b" => output <= x"f1";
                when x"2c" => output <= x"71";
                when x"2d" => output <= x"d8";
                when x"2e" => output <= x"31";
                when x"2f" => output <= x"15";
                
                -- Row 3.
                when x"30" => output <= x"04";
                when x"31" => output <= x"c7";
                when x"32" => output <= x"23";
                when x"33" => output <= x"c3";
                when x"34" => output <= x"18";
                when x"35" => output <= x"96";
                when x"36" => output <= x"05";
                when x"37" => output <= x"9a";
                when x"38" => output <= x"07";
                when x"39" => output <= x"12";
                when x"3a" => output <= x"80";
                when x"3b" => output <= x"e2";
                when x"3c" => output <= x"eb";
                when x"3d" => output <= x"27";
                when x"3e" => output <= x"b2";
                when x"3f" => output <= x"75";
                
                -- Row 4.
                when x"40" => output <= x"09";
                when x"41" => output <= x"83";
                when x"42" => output <= x"2c";
                when x"43" => output <= x"1a";
                when x"44" => output <= x"1b";
                when x"45" => output <= x"6e";
                when x"46" => output <= x"5a";
                when x"47" => output <= x"a0";
                when x"48" => output <= x"52";
                when x"49" => output <= x"3b";
                when x"4a" => output <= x"d6";
                when x"4b" => output <= x"b3";
                when x"4c" => output <= x"29";
                when x"4d" => output <= x"e3";
                when x"4e" => output <= x"2f";
                when x"4f" => output <= x"84";
                
                -- Row 5.
                when x"50" => output <= x"53";
                when x"51" => output <= x"d1";
                when x"52" => output <= x"00";
                when x"53" => output <= x"ed";
                when x"54" => output <= x"20";
                when x"55" => output <= x"fc";
                when x"56" => output <= x"b1";
                when x"57" => output <= x"5b";
                when x"58" => output <= x"6a";
                when x"59" => output <= x"cb";
                when x"5a" => output <= x"be";
                when x"5b" => output <= x"39";
                when x"5c" => output <= x"4a";
                when x"5d" => output <= x"4c";
                when x"5e" => output <= x"58";
                when x"5f" => output <= x"cf";
                
                -- Row 6.
                when x"60" => output <= x"d0";
                when x"61" => output <= x"ef";
                when x"62" => output <= x"aa";
                when x"63" => output <= x"fb";
                when x"64" => output <= x"43";
                when x"65" => output <= x"4d";
                when x"66" => output <= x"33";
                when x"67" => output <= x"85";
                when x"68" => output <= x"45";
                when x"69" => output <= x"f9";
                when x"6a" => output <= x"02";
                when x"6b" => output <= x"7f";
                when x"6c" => output <= x"50";
                when x"6d" => output <= x"3c";
                when x"6e" => output <= x"9f";
                when x"6f" => output <= x"a8";
                
                -- Row 7.
                when x"70" => output <= x"51";
                when x"71" => output <= x"a3";
                when x"72" => output <= x"40";
                when x"73" => output <= x"8f";
                when x"74" => output <= x"92";
                when x"75" => output <= x"9d";
                when x"76" => output <= x"38";
                when x"77" => output <= x"f5";
                when x"78" => output <= x"bc";
                when x"79" => output <= x"b6";
                when x"7a" => output <= x"da";
                when x"7b" => output <= x"21";
                when x"7c" => output <= x"10";
                when x"7d" => output <= x"ff";
                when x"7e" => output <= x"f3";
                when x"7f" => output <= x"d2";
                
                -- Row 8.
                when x"80" => output <= x"cd";
                when x"81" => output <= x"0c";
                when x"82" => output <= x"13";
                when x"83" => output <= x"ec";
                when x"84" => output <= x"5f";
                when x"85" => output <= x"97";
                when x"86" => output <= x"44";
                when x"87" => output <= x"17";
                when x"88" => output <= x"c4";
                when x"89" => output <= x"a7";
                when x"8a" => output <= x"7e";
                when x"8b" => output <= x"3d";
                when x"8c" => output <= x"64";
                when x"8d" => output <= x"5d";
                when x"8e" => output <= x"19";
                when x"8f" => output <= x"73";
                
                -- Row 9.
                when x"90" => output <= x"60";
                when x"91" => output <= x"81";
                when x"92" => output <= x"4f";
                when x"93" => output <= x"dc";
                when x"94" => output <= x"22";
                when x"95" => output <= x"2a";
                when x"96" => output <= x"90";
                when x"97" => output <= x"88";
                when x"98" => output <= x"46";
                when x"99" => output <= x"ee";
                when x"9a" => output <= x"b8";
                when x"9b" => output <= x"14";
                when x"9c" => output <= x"de";
                when x"9d" => output <= x"5e";
                when x"9e" => output <= x"0b";
                when x"9f" => output <= x"db";
                
                -- Row a.
                when x"a0" => output <= x"e0";
                when x"a1" => output <= x"32";
                when x"a2" => output <= x"3a";
                when x"a3" => output <= x"0a";
                when x"a4" => output <= x"49";
                when x"a5" => output <= x"06";
                when x"a6" => output <= x"24";
                when x"a7" => output <= x"5c";
                when x"a8" => output <= x"c2";
                when x"a9" => output <= x"d3";
                when x"aa" => output <= x"ac";
                when x"ab" => output <= x"62";
                when x"ac" => output <= x"91";
                when x"ad" => output <= x"95";
                when x"ae" => output <= x"e4";
                when x"af" => output <= x"79";
                
                -- Row b.
                when x"b0" => output <= x"e7";
                when x"b1" => output <= x"c8";
                when x"b2" => output <= x"37";
                when x"b3" => output <= x"6d";
                when x"b4" => output <= x"8d";
                when x"b5" => output <= x"d5";
                when x"b6" => output <= x"4e";
                when x"b7" => output <= x"a9";
                when x"b8" => output <= x"6c";
                when x"b9" => output <= x"56";
                when x"ba" => output <= x"f4";
                when x"bb" => output <= x"ea";
                when x"bc" => output <= x"65";
                when x"bd" => output <= x"7a";
                when x"be" => output <= x"ae";
                when x"bf" => output <= x"08";
                
                -- Row c.
                when x"c0" => output <= x"ba";
                when x"c1" => output <= x"78";
                when x"c2" => output <= x"25";
                when x"c3" => output <= x"2e";
                when x"c4" => output <= x"1c";
                when x"c5" => output <= x"a6";
                when x"c6" => output <= x"b4";
                when x"c7" => output <= x"c6";
                when x"c8" => output <= x"e8";
                when x"c9" => output <= x"dd";
                when x"ca" => output <= x"74";
                when x"cb" => output <= x"1f";
                when x"cc" => output <= x"4b";
                when x"cd" => output <= x"bd";
                when x"ce" => output <= x"8b";
                when x"cf" => output <= x"8a";
                
                -- Row d.
                when x"d0" => output <= x"70";
                when x"d1" => output <= x"3e";
                when x"d2" => output <= x"b5";
                when x"d3" => output <= x"66";
                when x"d4" => output <= x"48";
                when x"d5" => output <= x"03";
                when x"d6" => output <= x"f6";
                when x"d7" => output <= x"0e";
                when x"d8" => output <= x"61";
                when x"d9" => output <= x"35";
                when x"da" => output <= x"57";
                when x"db" => output <= x"b9";
                when x"dc" => output <= x"86";
                when x"dd" => output <= x"c1";
                when x"de" => output <= x"1d";
                when x"df" => output <= x"9e";
                
                -- Row e.
                when x"e0" => output <= x"e1";
                when x"e1" => output <= x"f8";
                when x"e2" => output <= x"98";
                when x"e3" => output <= x"11";
                when x"e4" => output <= x"69";
                when x"e5" => output <= x"d9";
                when x"e6" => output <= x"8e";
                when x"e7" => output <= x"94";
                when x"e8" => output <= x"9b";
                when x"e9" => output <= x"1e";
                when x"ea" => output <= x"87";
                when x"eb" => output <= x"e9";
                when x"ec" => output <= x"ce";
                when x"ed" => output <= x"55";
                when x"ee" => output <= x"28";
                when x"ef" => output <= x"df";
                
                -- Row f.
                when x"f0" => output <= x"8c";
                when x"f1" => output <= x"a1";
                when x"f2" => output <= x"89";
                when x"f3" => output <= x"0d";
                when x"f4" => output <= x"bf";
                when x"f5" => output <= x"e6";
                when x"f6" => output <= x"42";
                when x"f7" => output <= x"68";
                when x"f8" => output <= x"41";
                when x"f9" => output <= x"99";
                when x"fa" => output <= x"2d";
                when x"fb" => output <= x"0f";
                when x"fc" => output <= x"b0";
                when x"fd" => output <= x"54";
                when x"fe" => output <= x"bb";
                when x"ff" => output <= x"16";

                when others =>

            end case;

        -- Inverse S-Box.
        else
            case input is
            
                -- Row 0.
                when x"00" => output <= x"52";
                when x"01" => output <= x"09";
                when x"02" => output <= x"6a";
                when x"03" => output <= x"d5";
                when x"04" => output <= x"30";
                when x"05" => output <= x"36";
                when x"06" => output <= x"a5";
                when x"07" => output <= x"38";
                when x"08" => output <= x"bf";
                when x"09" => output <= x"40";
                when x"0a" => output <= x"a3";
                when x"0b" => output <= x"9e";
                when x"0c" => output <= x"81";
                when x"0d" => output <= x"f3";
                when x"0e" => output <= x"d7";
                when x"0f" => output <= x"fb";
                
                -- Row 1.
                when x"10" => output <= x"7c";
                when x"11" => output <= x"e3";
                when x"12" => output <= x"39";
                when x"13" => output <= x"82";
                when x"14" => output <= x"9b";
                when x"15" => output <= x"2f";
                when x"16" => output <= x"ff";
                when x"17" => output <= x"87";
                when x"18" => output <= x"34";
                when x"19" => output <= x"8e";
                when x"1a" => output <= x"43";
                when x"1b" => output <= x"44";
                when x"1c" => output <= x"c4";
                when x"1d" => output <= x"de";
                when x"1e" => output <= x"e9";
                when x"1f" => output <= x"cb";
                
                -- Row 2.
                when x"20" => output <= x"54";
                when x"21" => output <= x"7b";
                when x"22" => output <= x"94";
                when x"23" => output <= x"32";
                when x"24" => output <= x"a6";
                when x"25" => output <= x"c2";
                when x"26" => output <= x"23";
                when x"27" => output <= x"3d";
                when x"28" => output <= x"ee";
                when x"29" => output <= x"4c";
                when x"2a" => output <= x"95";
                when x"2b" => output <= x"0b";
                when x"2c" => output <= x"42";
                when x"2d" => output <= x"fa";
                when x"2e" => output <= x"c3";
                when x"2f" => output <= x"4e";
                
                -- Row 3.
                when x"30" => output <= x"08";
                when x"31" => output <= x"2e";
                when x"32" => output <= x"a1";
                when x"33" => output <= x"66";
                when x"34" => output <= x"28";
                when x"35" => output <= x"d9";
                when x"36" => output <= x"24";
                when x"37" => output <= x"b2";
                when x"38" => output <= x"76";
                when x"39" => output <= x"5b";
                when x"3a" => output <= x"a2";
                when x"3b" => output <= x"49";
                when x"3c" => output <= x"6d";
                when x"3d" => output <= x"8b";
                when x"3e" => output <= x"d1";
                when x"3f" => output <= x"25";
                
                -- Row 4.
                when x"40" => output <= x"72";
                when x"41" => output <= x"f8";
                when x"42" => output <= x"f6";
                when x"43" => output <= x"64";
                when x"44" => output <= x"86";
                when x"45" => output <= x"68";
                when x"46" => output <= x"98";
                when x"47" => output <= x"16";
                when x"48" => output <= x"d4";
                when x"49" => output <= x"a4";
                when x"4a" => output <= x"5c";
                when x"4b" => output <= x"cc";
                when x"4c" => output <= x"5d";
                when x"4d" => output <= x"65";
                when x"4e" => output <= x"b6";
                when x"4f" => output <= x"92";
                
                -- Row 5.
                when x"50" => output <= x"6c";
                when x"51" => output <= x"70";
                when x"52" => output <= x"48";
                when x"53" => output <= x"50";
                when x"54" => output <= x"fd";
                when x"55" => output <= x"ed";
                when x"56" => output <= x"b9";
                when x"57" => output <= x"da";
                when x"58" => output <= x"5e";
                when x"59" => output <= x"15";
                when x"5a" => output <= x"46";
                when x"5b" => output <= x"57";
                when x"5c" => output <= x"a7";
                when x"5d" => output <= x"8d";
                when x"5e" => output <= x"9d";
                when x"5f" => output <= x"84";
                
                -- Row 6.
                when x"60" => output <= x"90";
                when x"61" => output <= x"d8";
                when x"62" => output <= x"ab";
                when x"63" => output <= x"00";
                when x"64" => output <= x"8c";
                when x"65" => output <= x"bc";
                when x"66" => output <= x"d3";
                when x"67" => output <= x"0a";
                when x"68" => output <= x"f7";
                when x"69" => output <= x"e4";
                when x"6a" => output <= x"58";
                when x"6b" => output <= x"05";
                when x"6c" => output <= x"b8";
                when x"6d" => output <= x"b3";
                when x"6e" => output <= x"45";
                when x"6f" => output <= x"06";
                
                -- Row 7.
                when x"70" => output <= x"d0";
                when x"71" => output <= x"2c";
                when x"72" => output <= x"1e";
                when x"73" => output <= x"8f";
                when x"74" => output <= x"ca";
                when x"75" => output <= x"3f";
                when x"76" => output <= x"0f";
                when x"77" => output <= x"02";
                when x"78" => output <= x"c1";
                when x"79" => output <= x"af";
                when x"7a" => output <= x"bd";
                when x"7b" => output <= x"03";
                when x"7c" => output <= x"01";
                when x"7d" => output <= x"13";
                when x"7e" => output <= x"8a";
                when x"7f" => output <= x"6b";
                
                -- Row 8.
                when x"80" => output <= x"3a";
                when x"81" => output <= x"91";
                when x"82" => output <= x"11";
                when x"83" => output <= x"41";
                when x"84" => output <= x"4f";
                when x"85" => output <= x"67";
                when x"86" => output <= x"dc";
                when x"87" => output <= x"ea";
                when x"88" => output <= x"97";
                when x"89" => output <= x"f2";
                when x"8a" => output <= x"cf";
                when x"8b" => output <= x"ce";
                when x"8c" => output <= x"f0";
                when x"8d" => output <= x"b4";
                when x"8e" => output <= x"e6";
                when x"8f" => output <= x"73";
                
                -- Row 9.
                when x"90" => output <= x"96";
                when x"91" => output <= x"ac";
                when x"92" => output <= x"74";
                when x"93" => output <= x"22";
                when x"94" => output <= x"e7";
                when x"95" => output <= x"ad";
                when x"96" => output <= x"35";
                when x"97" => output <= x"85";
                when x"98" => output <= x"e2";
                when x"99" => output <= x"f9";
                when x"9a" => output <= x"37";
                when x"9b" => output <= x"e8";
                when x"9c" => output <= x"1c";
                when x"9d" => output <= x"75";
                when x"9e" => output <= x"df";
                when x"9f" => output <= x"6e";
                
                -- Row a.
                when x"a0" => output <= x"47";
                when x"a1" => output <= x"f1";
                when x"a2" => output <= x"1a";
                when x"a3" => output <= x"71";
                when x"a4" => output <= x"1d";
                when x"a5" => output <= x"29";
                when x"a6" => output <= x"c5";
                when x"a7" => output <= x"89";
                when x"a8" => output <= x"6f";
                when x"a9" => output <= x"b7";
                when x"aa" => output <= x"62";
                when x"ab" => output <= x"0e";
                when x"ac" => output <= x"aa";
                when x"ad" => output <= x"18";
                when x"ae" => output <= x"be";
                when x"af" => output <= x"1b";
                
                -- Row b.
                when x"b0" => output <= x"fc";
                when x"b1" => output <= x"56";
                when x"b2" => output <= x"3e";
                when x"b3" => output <= x"4b";
                when x"b4" => output <= x"c6";
                when x"b5" => output <= x"d2";
                when x"b6" => output <= x"79";
                when x"b7" => output <= x"20";
                when x"b8" => output <= x"9a";
                when x"b9" => output <= x"db";
                when x"ba" => output <= x"c0";
                when x"bb" => output <= x"fe";
                when x"bc" => output <= x"78";
                when x"bd" => output <= x"cd";
                when x"be" => output <= x"5a";
                when x"bf" => output <= x"f4";
                
                -- Row c.
                when x"c0" => output <= x"1f";
                when x"c1" => output <= x"dd";
                when x"c2" => output <= x"a8";
                when x"c3" => output <= x"33";
                when x"c4" => output <= x"88";
                when x"c5" => output <= x"07";
                when x"c6" => output <= x"c7";
                when x"c7" => output <= x"31";
                when x"c8" => output <= x"b1";
                when x"c9" => output <= x"12";
                when x"ca" => output <= x"10";
                when x"cb" => output <= x"59";
                when x"cc" => output <= x"27";
                when x"cd" => output <= x"80";
                when x"ce" => output <= x"ec";
                when x"cf" => output <= x"5f";
                
                -- Row d.
                when x"d0" => output <= x"60";
                when x"d1" => output <= x"51";
                when x"d2" => output <= x"7f";
                when x"d3" => output <= x"a9";
                when x"d4" => output <= x"19";
                when x"d5" => output <= x"b5";
                when x"d6" => output <= x"4a";
                when x"d7" => output <= x"0d";
                when x"d8" => output <= x"2d";
                when x"d9" => output <= x"e5";
                when x"da" => output <= x"7a";
                when x"db" => output <= x"9f";
                when x"dc" => output <= x"93";
                when x"dd" => output <= x"c9";
                when x"de" => output <= x"9c";
                when x"df" => output <= x"ef";
                
                -- Row e.
                when x"e0" => output <= x"a0";
                when x"e1" => output <= x"e0";
                when x"e2" => output <= x"3b";
                when x"e3" => output <= x"4d";
                when x"e4" => output <= x"ae";
                when x"e5" => output <= x"2a";
                when x"e6" => output <= x"f5";
                when x"e7" => output <= x"b0";
                when x"e8" => output <= x"c8";
                when x"e9" => output <= x"eb";
                when x"ea" => output <= x"bb";
                when x"eb" => output <= x"3c";
                when x"ec" => output <= x"83";
                when x"ed" => output <= x"53";
                when x"ee" => output <= x"99";
                when x"ef" => output <= x"61";
                
                -- Row f.
                when x"f0" => output <= x"17";
                when x"f1" => output <= x"2b";
                when x"f2" => output <= x"04";
                when x"f3" => output <= x"7e";
                when x"f4" => output <= x"ba";
                when x"f5" => output <= x"77";
                when x"f6" => output <= x"d6";
                when x"f7" => output <= x"26";
                when x"f8" => output <= x"e1";
                when x"f9" => output <= x"69";
                when x"fa" => output <= x"14";
                when x"fb" => output <= x"63";
                when x"fc" => output <= x"55";
                when x"fd" => output <= x"21";
                when x"fe" => output <= x"0c";
                when x"ff" => output <= x"7d";

                when others =>

            end case;
            
        end if;

    end process lut;

end structural;

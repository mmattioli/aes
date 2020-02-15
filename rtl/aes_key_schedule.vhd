--
-- Written by Michael Mattioli
--
-- Description: AES key schedule.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_key_schedule is
    port (  clk         : in std_logic;
            rst         : in std_logic;
            enable      : in std_logic;
            key         : in std_logic_vector(127 downto 0);
            round_keys  : out std_logic_vector((128*(rounds+1))-1 downto 0);
            complete    : out std_logic);
end aes_key_schedule;

architecture behavioral of aes_key_schedule is

    -- Round constants.
    type round_constant_words is array (1 to rounds) of std_logic_vector(31 downto 0);
    constant round_constant : round_constant_words := ( x"01000000",
                                                        x"02000000",
                                                        x"04000000",
                                                        x"08000000",
                                                        x"10000000",
                                                        x"20000000",
                                                        x"40000000",
                                                        x"80000000",
                                                        x"1b000000",
                                                        x"36000000");

    -- Round keys split into words (11 round keys with 4 words each = 44 total words).
    type key_words is array (0 to (4*(rounds+1))-1) of std_logic_vector(31 downto 0);
    signal words : key_words := (others=>(others=>'0'));
    
    -- Identify when the key is fully expanded and all of our round keys are ready.
    signal finished : std_logic := '0';
    
    -- Keep track of which word we're working on.
    signal current_word : integer range 0 to key_words'length-1 := 0;

begin

    make_round_keys : process(clk, rst)
        -- Used to manipulate the current word we're working on.
        variable temp_word : std_logic_vector(31 downto 0);
        -- Simply copies the current word we're working on. This just makes everything easier to write (one letter is smaller than a whole signal name).
        variable i : integer;
    begin
        -- Set the variable to the current_word.
        i := current_word;
        -- Check for reset.
        if rising_edge(clk) then
            if rst = '1' then
                finished <= '0';
                current_word <= 0;
            -- Make the round keys.
            elsif enable = '1' and finished = '0' then
                -- First 4 words (key 0) is just the supplied key, nothing fancy.
                if i <= 3 then
                    words(i) <= key(127-(i*32) downto 96-(i*32));
                else
                    temp_word := words(i-1);
                    if i mod 4 = 0 then
                        -- Rotate word.
                        temp_word := temp_word(23 downto 0) & temp_word(31 downto 24);
                        -- Substitute word.
                        for j in 0 to 3 loop
                            -- When j = 0 => temp_word(7 downto 0) := normal_sbox(conv_integer(temp_word(7 downto 4)), conv_integer(temp_word(3 downto 0)));
                            -- When j = 3 => temp_word(31 downto 24) := normal_sbox(conv_integer(temp_word(31 downto 28)), conv_integer(temp_word(27 downto 24)));
                            temp_word((8*(j+1))-1 downto (8*j)) := normal_sbox(conv_integer(temp_word((8*(j+1))-1 downto (8*j)+4)), conv_integer(temp_word((8*(j+1))-1-4 downto (8*j))));
                        end loop; 
                        -- XOR word with round constant.
                        temp_word := temp_word xor round_constant(i/4);
                    end if;
                    words(i) <= words(i-4) xor temp_word;
                end if;
                -- Check if we've reached the end.
                if i = key_words'length-1 then
                    finished <= '1';
                -- Incremement so we can move onto the next word on the next clock cycle.
                else
                    current_word <= current_word + 1;
                end if;
            end if;
        end if;
    end process make_round_keys;

    output_round_keys : for i in 0 to key_words'length-1 generate
        -- When i = 0 => round_keys(1407 downto 1376) <= words(0);
        -- When i = 43 => round_keys(31 downto 0) <= words(43);
        round_keys(((44*32)-1)-(i*32) downto (43*32)-(i*32)) <= words(i);
    end generate output_round_keys;
    
    complete <= finished;

end behavioral;

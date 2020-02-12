--
-- Written by Michael Mattioli
--
-- Description: AES SubBytes operation.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes.all;

entity aes_mix_columns is
    port (  state   : in std_logic_vector(127 downto 0);
            inverse : in std_logic;
            result  : out std_logic_vector(127 downto 0));
end aes_mix_columns;

architecture structural of aes_mix_columns is

    -- Standard 4x4 matrix which holds 16x 8-bit values (128 bits in total).
    type matrix is array(15 downto 0) of std_logic_vector(7 downto 0);
    -- Matrix with an extra bit in each value used during the multiplication operations.
    type intermediary_matrix is array(15 downto 0) of std_logic_vector(8 downto 0);
    
    -- Signals used to hold the "results" of the operations.
    signal matrix_current : matrix;
    signal matrix_final : matrix;
    signal matrix_multiply_2 : matrix;
    signal matrix_multiply_3 : matrix;
    signal matrix_multiply_9 : matrix;
    signal matrix_multiply_b : matrix;
    signal matrix_multiply_d : matrix;
    signal matrix_multiply_e : matrix;
    
    -- Signals used to hold intermediary "results" while performing the operations. 
    signal intermediary_multiply_2 : intermediary_matrix;
    signal intermediary_multiply_3 : intermediary_matrix;
    signal intermediary_xor : intermediary_matrix;
    
begin

-- Map the 128-bit state to a 4x4 matrix of bytes (16x 8-bit values).
map_to_matrix : process(state)
begin
    for i in 15 downto 0 loop
        matrix_current(15-i) <= state((8*i)+7 downto (8*i));
    end loop;
end process map_to_matrix;

-- The Galois field specifies multiplying by either 1, 2, or 3. Since multiplying anything by 1 yields itself, there isn't much to do.
-- The easiest path is to simply multiply all values by 2 and by 3 and then "pick" the resulting values as needed per the Galois field.
-- According to the specification, if the 8th bit is high then xor with x"1b".

-- Multiply by 2, 3.
multiply_by_2_3 : process(matrix_current)
    variable temp1, temp2 : std_logic_vector(8 downto 0);
begin

    for i in 15 downto 0 loop
        
        -- 2.
        temp1 := matrix_current(i) & '0';
        if temp1(8) = '1' then
             matrix_multiply_2(i) <= temp1(7 downto 0) xor x"1b";
        else
            matrix_multiply_2(i) <= temp1(7 downto 0);
        end if;
        
        -- 3.
        temp2 := temp1 xor '0' & matrix_current(i); -- 3 * value = 2 * value xor value.
        if temp2(8) = '1' then
            matrix_multiply_3(i) <= temp2(7 downto 0) xor x"1b";
        else
            matrix_multiply_3(i) <= temp2(7 downto 0);
        end if;

    end loop;

end process multiply_by_2_3;

-- Multiply by 9, 11, 13, 14.
multiply_by_9_11_13_14 : process(matrix_current)
    variable temp1, temp2, temp3 : std_logic_vector(8 downto 0);
begin

    for i in 15 downto 0 loop
    
        temp1 := matrix_current(i) & '0';
        if temp1(8) = '1' then
            temp1(7 downto 0) := temp1(7 downto 0) xor x"1b";
        end if;

        temp2 := temp1(7 downto 0) & '0';
        if temp2(8) = '1' then
            temp2(7 downto 0) := temp2(7 downto 0) xor x"1b";
        end if;

        temp3 := temp2(7 downto 0) & '0';
        if temp3(8) = '1' then
            temp3(7 downto 0) := temp3(7 downto 0) xor x"1b";
        end if;
        
        -- 9.
        matrix_multiply_9(i) <= matrix_current(i) xor temp3(7 downto 0);
        
        -- 11 (b).
        matrix_multiply_b(i) <= matrix_current(i) xor temp1(7 downto 0) xor temp3(7 downto 0);
        
        -- 13 (d).
        matrix_multiply_d(i) <= matrix_current(i) xor temp2(7 downto 0) xor temp3(7 downto 0);
        
        --14 (e).
        matrix_multiply_e(i) <= temp1(7 downto 0) xor temp2(7 downto 0) xor temp3(7 downto 0);
        
    end loop;

end process multiply_by_9_11_13_14;

-- Now we "pick" our values according to the Galois field.
pick_values : process(matrix_final, matrix_current, matrix_multiply_2, matrix_multiply_3)
begin

    -- Standard operation.
    if inverse = '0' then

        -- Row 0 [2 3 1 1].
        matrix_final(0) <= matrix_multiply_2(0) xor matrix_multiply_3(1) xor matrix_current(2) xor matrix_current(3);
        matrix_final(4) <= matrix_multiply_2(4) xor matrix_multiply_3(5) xor matrix_current(6) xor matrix_current(7);
        matrix_final(8) <= matrix_multiply_2(8) xor matrix_multiply_3(9) xor matrix_current(10) xor matrix_current(11);
        matrix_final(12) <= matrix_multiply_2(12) xor matrix_multiply_3(13) xor matrix_current(14) xor matrix_current(15);
        
        -- Row 1 [1 2 3 1].
        matrix_final(1) <= matrix_current(0) xor matrix_multiply_2(1) xor matrix_multiply_3(2) xor matrix_current(3);
        matrix_final(5) <= matrix_current(4) xor matrix_multiply_2(5) xor matrix_multiply_3(6) xor matrix_current(7);
        matrix_final(9) <= matrix_current(8) xor matrix_multiply_2(9) xor matrix_multiply_3(10) xor matrix_current(11);
        matrix_final(13) <= matrix_current(12) xor matrix_multiply_2(13) xor matrix_multiply_3(14) xor matrix_current(15);
        
        -- Row 2 [1 1 2 3].
        matrix_final(2) <= matrix_current(0) xor matrix_current(1) xor matrix_multiply_2(2) xor matrix_multiply_3(3);
        matrix_final(6) <= matrix_current(4) xor matrix_current(5) xor matrix_multiply_2(6) xor matrix_multiply_3(7);
        matrix_final(10) <= matrix_current(8) xor matrix_current(9) xor matrix_multiply_2(10) xor matrix_multiply_3(11);
        matrix_final(14) <= matrix_current(12) xor matrix_current(13) xor matrix_multiply_2(14) xor matrix_multiply_3(15);
        
        -- Row 3 [3 1 1 2].
        matrix_final(3) <= matrix_multiply_3(0) xor matrix_current(1) xor matrix_current(2) xor matrix_multiply_2(3);
        matrix_final(7) <= matrix_multiply_3(4) xor matrix_current(5) xor matrix_current(6) xor matrix_multiply_2(7);
        matrix_final(11) <= matrix_multiply_3(8) xor matrix_current(9) xor matrix_current(10) xor matrix_multiply_2(11);
        matrix_final(15) <= matrix_multiply_3(12) xor matrix_current(13) xor matrix_current(14) xor matrix_multiply_2(15);
    
    -- Inverse operation.
    else
        
        -- Row 0 [14 11 3 9].
        matrix_final(0) <= matrix_multiply_e(0) xor matrix_multiply_b(1) xor matrix_multiply_d(2) xor matrix_multiply_9(3);
        matrix_final(4) <= matrix_multiply_e(4) xor matrix_multiply_b(5) xor matrix_multiply_d(6) xor matrix_multiply_9(7);
        matrix_final(8) <= matrix_multiply_e(8) xor matrix_multiply_b(9) xor matrix_multiply_d(10) xor matrix_multiply_9(11);
        matrix_final(12) <= matrix_multiply_e(12) xor matrix_multiply_b(13) xor matrix_multiply_d(14) xor matrix_multiply_9(15);
        
        -- Row 1 [9 14 11 13].
        matrix_final(1) <= matrix_multiply_9(0) xor matrix_multiply_e(1) xor matrix_multiply_b(2) xor matrix_multiply_d(3);
        matrix_final(5) <= matrix_multiply_9(4) xor matrix_multiply_e(5) xor matrix_multiply_b(6) xor matrix_multiply_d(7);
        matrix_final(9) <= matrix_multiply_9(8) xor matrix_multiply_e(9) xor matrix_multiply_b(10) xor matrix_multiply_d(11);
        matrix_final(13) <= matrix_multiply_9(12) xor matrix_multiply_e(13) xor matrix_multiply_b(14) xor matrix_multiply_d(15);
        
        -- Row 2 [13 9 14 11].
        matrix_final(2) <= matrix_multiply_d(0) xor matrix_multiply_9(1) xor matrix_multiply_e(2) xor matrix_multiply_b(3);
        matrix_final(6) <= matrix_multiply_d(4) xor matrix_multiply_9(5) xor matrix_multiply_e(6) xor matrix_multiply_b(7);
        matrix_final(10) <= matrix_multiply_d(8) xor matrix_multiply_9(9) xor matrix_multiply_e(10) xor matrix_multiply_b(11);
        matrix_final(14) <= matrix_multiply_d(12) xor matrix_multiply_9(13) xor matrix_multiply_e(14) xor matrix_multiply_b(15);
        
        -- Row 3 [11 9 13 14].
        matrix_final(3) <= matrix_multiply_b(0) xor matrix_multiply_d(1) xor matrix_multiply_9(2) xor matrix_multiply_e(3);
        matrix_final(7) <= matrix_multiply_b(4) xor matrix_multiply_d(5) xor matrix_multiply_9(6) xor matrix_multiply_e(7);
        matrix_final(11) <= matrix_multiply_b(8) xor matrix_multiply_d(9) xor matrix_multiply_9(10) xor matrix_multiply_e(11);
        matrix_final(15) <= matrix_multiply_b(12) xor matrix_multiply_d(13) xor matrix_multiply_9(14) xor matrix_multiply_e(15);
    
    end if;

end process pick_values;

-- Transform our 4x4 matrix back into a standard 128-bit value.
output_result : process(matrix_final)
begin
    for i in 15 downto 0 loop
        result((8*i)+7 downto (8*i)) <= matrix_final(15-i);
    end loop;
end process output_result;

end structural;

-- used ChatGPT to verify my code: minor issues found which I corrected

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kogge_stone_16bit is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           cout : out STD_LOGIC);
end kogge_stone_16bit;

architecture Behavioral of kogge_stone_16bit is

-- signals for the pre-processing layer
signal g0: std_logic_vector(15 downto 0);
signal p0: std_logic_vector(15 downto 0);

-- signals for the each stage of the prefix computation and carry generation layer
signal g1, g2, g3, g4: std_logic_vector(15 downto 0);
signal p1, p2, p3, p4: std_logic_vector(15 downto 0);

-- vector to keep the carries
signal carries: std_logic_vector(15 downto 0);

begin

pre_processing: for i in 0 to 15 generate
    g0(i) <= x(i) and y(i);
    p0(i) <= x(i) xor y(i);
end generate pre_processing;

buffer_generate_1: g1(0) <= g0(0);
buffer_propagate_1: p1(0) <= p0(0);
prefix_computation_and_carry_generation_1: for ii in 1 to 15 generate
    g1(ii) <= g0(ii) or (p0(ii) and g0(ii-1));
    p1(ii) <= p0(ii) and p0(ii-1);
end generate prefix_computation_and_carry_generation_1;

buffer_generate_2: g2(0) <= g1(0); 
g2(1) <= g1(1);
buffer_propagate_2: p2(0) <= p1(0); 
p2(1) <= p1(1);
prefix_computation_and_carry_generation_2: for iii in 2 to 15 generate
    g2(iii) <= g1(iii) or (p1(iii) and g1(iii-2));
    p2(iii) <= p1(iii) and p1(iii-2);
end generate prefix_computation_and_carry_generation_2;

buffer_generate_propagate_3: for j in 0 to 3 generate
    g3(j) <= g2(j);
    p3(j) <= p2(j);
end generate buffer_generate_propagate_3;  
prefix_computation_and_carry_generation_3: for iv in 4 to 15 generate
    g3(iv) <= g2(iv) or (p2(iv) and g2(iv-4));
    p3(iv) <= p2(iv) and p2(iv-4);
end generate prefix_computation_and_carry_generation_3;

buffer_generate_propagate_4: for jj in 0 to 7 generate
    g4(jj) <= g3(jj);
    p4(jj) <= p3(jj);
end generate buffer_generate_propagate_4; 
prefix_computation_and_carry_generation_4: for v in 8 to 15 generate
    g4(v) <= g3(v) or (p3(v) and g3(v-8));
    p4(v) <= p3(v) and p3(v-8);
end generate prefix_computation_and_carry_generation_4;

carries(0) <= cin;
carry_generation: for vi in 0 to 14 generate
    carries(vi + 1) <= g4(vi) or (p4(vi) and cin);
end generate carry_generation;
cout <= g4(15) or (p4(15) and cin);

post_processing: for vii in 0 to 15 generate
    s(vii) <= p0(vii) xor carries(vii);
end generate post_processing;

end Behavioral;

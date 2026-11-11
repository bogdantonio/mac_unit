library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_16b_dadda is
end tb_16b_dadda;

architecture Behavioral of tb_16b_dadda is

component dadda_16bit is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

constant T: time := 10ns;

signal a, b: std_logic_vector(15 downto 0);
signal result: std_logic_vector(31 downto 0);

begin

uut: dadda_16bit port map (a => a, b => b, result => result);

a <= x"0001", x"0002" after T, x"0231" after 2*T, x"0000" after 3*T;
b <= x"00FF", x"000F" after 1.5*T, x"9301" after 2.5*T, x"fed1" after 3.5*T; 

end Behavioral;

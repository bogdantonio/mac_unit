library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_16b_ksa is
end tb_16b_ksa;

architecture Behavioral of tb_16b_ksa is

component kogge_stone_16bit is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           cout : out STD_LOGIC);
end component;

signal x, y, s: std_logic_vector(15 downto 0);
signal cin, cout: std_logic;

constant T :time := 10 ns;

begin

uut: kogge_stone_16bit port map (x => x, y => y, cin => cin, s => s, cout => cout);

x <= x"0001", x"0011" after T, x"015f" after 2*T, x"f000" after 3*T, x"1dd1" after 4*T;
y <= x"11f1", x"0011" after 1.5*T, x"0ea1" after 2.5*T, x"0001" after 3.5*T, x"ba10" after 4.5*T;
cin <= '0', '1' after 3*T;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kogge_stone_32bit is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (31 downto 0);
           cout : out STD_LOGIC);
end kogge_stone_32bit;

architecture Behavioral of kogge_stone_32bit is

component kogge_stone_16bit is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : in STD_LOGIC_VECTOR (15 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           cout : out STD_LOGIC);
end component;

signal carry_transfer: std_logic;

begin

lower_ksa: kogge_stone_16bit port map(
    x => x(15 downto 0), 
    y => y(15 downto 0), 
    cin => cin, 
    s => s(15 downto 0), 
    cout => carry_transfer
);

higher_ksa: kogge_stone_16bit port map(
    x => x(31 downto 16), 
    y => y(31 downto 16), 
    cin => carry_transfer, 
    s => s(31 downto 16), 
    cout => cout
);

end Behavioral;

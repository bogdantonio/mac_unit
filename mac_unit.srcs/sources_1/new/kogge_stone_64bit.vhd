library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kogge_stone_64bit is
    Port ( x : in STD_LOGIC_VECTOR (63 downto 0);
           y : in STD_LOGIC_VECTOR (63 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (63 downto 0);
           cout : out STD_LOGIC);
end kogge_stone_64bit;

architecture Behavioral of kogge_stone_64bit is

component kogge_stone_32bit is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           y : in STD_LOGIC_VECTOR (31 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (31 downto 0);
           cout : out STD_LOGIC);
end component;

signal carry_transfer: std_logic;

begin

lower_ksa: kogge_stone_32bit port map(
    x => x(31 downto 0),
    y => y(31 downto 0),
    cin => cin,
    s => s(31 downto 0),
    cout => carry_transfer
); 

upper_ksa: kogge_stone_32bit port map (
    x => x(63 downto 32),
    y => y(63 downto 32),
    cin => carry_transfer,
    s => s(63 downto 32),
    cout => cout
);

end Behavioral;

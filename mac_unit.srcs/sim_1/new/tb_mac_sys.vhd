library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mac_sys is
end tb_mac_sys;

architecture Behavioral of tb_mac_sys is

component mac_system is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;

constant T: time := 10 ns;

signal A, B: std_logic_vector(31 downto 0);
signal result: std_logic_vector(63 downto 0);

signal clk: std_logic := '0';

begin

clk <= not clk after T;

A <= x"00000005",
         x"0000FF00" after 4*T,
         x"00FF0121" after 8*T,
         x"00000000" after 12*T,
         x"01BD2211" after 16*T;

    B <= x"0000000A",
         x"00000001" after 4*T,
         x"432FA2E0" after 8*T,
         x"FFFF00AA" after 12*T,
         x"00000002" after 16*T;
         
uut: mac_system port map (clk => clk, A => A, B => B, result => result);


end Behavioral;

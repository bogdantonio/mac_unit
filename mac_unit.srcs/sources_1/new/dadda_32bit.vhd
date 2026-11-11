library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity dadda_32bit is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end dadda_32bit;

architecture Behavioral of dadda_32bit is

component dadda_16bit is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal a_high, a_low: std_logic_vector(15 downto 0);
signal b_high, b_low: std_logic_vector(15 downto 0);

-- signals for the partial results
signal PLL, PLH, PHL, PHH: std_logic_vector(31 downto 0);
signal EPLL, EPLH, EPHL, EPHH: std_logic_vector(63 downto 0); 

begin

a_high <= a(31 downto 16);
a_low <= a(15 downto 0);

b_high <= b(31 downto 16);
b_low <= b(15 downto 0);

-- partial results computation
low_low: dadda_16bit port map (a => a_low, b => b_low, result => PLL);
low_high: dadda_16bit port map (a => a_low, b => b_high, result => PLH);
high_low: dadda_16bit port map (a => a_high, b => b_low, result => PHL);
high_high: dadda_16bit port map (a => a_high, b => b_high, result => PHH);

EPLL <= x"00000000" & PLL;
EPLH <= x"0000" & PLH & x"0000";
EPHL <= x"0000" & PHL & x"0000";
EPHH <= PHH & x"00000000";

result <= std_logic_vector(unsigned(EPLL) + unsigned (EPLH) + unsigned (EPHL) + unsigned (EPHH));

end Behavioral;

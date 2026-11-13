library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mac_unit is
    Port ( clk: in std_logic;
           A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0);
           
           -- control signals
           CBREAK_wr: in std_logic;
           ACC_wr: in std_logic
           );
end mac_unit;

architecture Behavioral of mac_unit is

component dadda_32bit is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;

component kogge_stone_64bit is
    Port ( x : in STD_LOGIC_VECTOR (63 downto 0);
           y : in STD_LOGIC_VECTOR (63 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (63 downto 0);
           cout : out STD_LOGIC);
end component;

signal ACCH, ACCL: std_logic_vector (31 downto 0) := x"00000000";

signal CBREAK: std_logic_vector(127 downto 0);

-- intermediary signals
signal mul_result: std_logic_vector(63 downto 0);
signal acc_result: std_logic_vector(63 downto 0);
signal acc_cout: std_logic;

begin

multiply: dadda_32bit port map (a => A, b => B, result => mul_result);

process(clk)
begin
    if rising_edge (clk) then
        if CBREAK_wr = '1' then
            CBREAK(127 downto 64) <= mul_result;
            CBREAK(63 downto 0) <= ACCH & ACCL;
        end if;
    end if;
end process;

accumulate: kogge_stone_64bit port map (x => CBREAK(127 downto 64), y => CBREAK(63 downto 0) , cin => '0', s => acc_result, cout => open);

process(clk)
begin
    if rising_edge (clk) then
        if ACC_wr = '1' then
            ACCH <= acc_result(63 downto 32);
            ACCL <= acc_result(31 downto 0);
        end if;
    end if;
end process;

result <= ACCH & ACCL;

end Behavioral;

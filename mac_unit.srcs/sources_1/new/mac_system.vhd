library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mac_system is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0));
end mac_system;

architecture Behavioral of mac_system is

component mac_unit is
    Port ( clk: in std_logic;
           A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           result : out STD_LOGIC_VECTOR (63 downto 0);
           
           -- control signals
           CBREAK_wr: in std_logic;
           ACC_wr: in std_logic
           );
end component;

component control_unit is
    Port ( clk : in std_logic;
           CBREAK_wr: out std_logic;
           ACC_wr: out std_logic 
    );
end component;
 
signal cu_buffer1, cu_buffer2: std_logic;

begin

mac: mac_unit port map (clk => clk, A => A, B => B, result => result, CBREAK_wr => cu_buffer1, ACC_wr => cu_buffer2);

control: control_unit port map (clk => clk, CBREAK_wr => cu_buffer1, ACC_wr => cu_buffer2);

end Behavioral;

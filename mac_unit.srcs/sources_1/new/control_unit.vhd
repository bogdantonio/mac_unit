library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( clk : in std_logic;
           CBREAK_wr: out std_logic;
           ACC_wr: out std_logic 
    );
end control_unit;

architecture Behavioral of control_unit is

type available_states is (S_LOAD_MUL, S_ADD);
signal state, next_state: available_states := S_LOAD_MUL;

begin

process(clk)
begin
    if rising_edge (CLK) then
        state <= next_state;
    end if;
end process;

process(state)
begin
    -- the great reset
    CBREAK_wr <= '0';
    ACC_wr <= '0';
    next_state <= state;
    
    case state is
        when S_LOAD_MUL =>
            CBREAK_wr <= '1';
            next_state <= S_ADD;
        when S_ADD =>
            ACC_wr <= '1';
            next_state <= S_LOAD_MUL;
    end case;
end process;

end Behavioral;

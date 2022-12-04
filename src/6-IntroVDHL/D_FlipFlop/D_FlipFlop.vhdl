library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FlipFLop is
    port (D, Clk: in  STD_LOGIC;
          Q,No_Q: out STD_LOGIC);
end entity;

architecture behaviour_D_FlipFlop of D_FlipFLop is
    signal Qt: std_logic;
begin
    process(Clk)
    begin
        if (Clk'event and Clk='1') then
            Qt <= D;
        end if
    end process
    Q <= Qt;
    No_Q <= not Qt;
end architecture;

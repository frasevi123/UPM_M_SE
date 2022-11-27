library ieee;
use ieee.std_logic_1164.all;

entity D_FlipFLop is
    port( D, Clk: in std_logic;
          Q,No_Q: out std_logic);
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

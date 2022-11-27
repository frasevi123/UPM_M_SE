library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    port (si, clk : in  STD_LOGIC;
          so      : out STD_LOGIC);
end entity;

architecture behaviour_shift_register of shift_register is
    signal dq_array: STD_LOGIC_VECTOR(3 downto 0);
begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            dq_array <= si & dq_array(3 downto 1);
        end if;
    end process;
    so <= dq_array(0);
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    port( si, clk: in std_logic;
          so: out std_logic);
end entity;

architecture behaviour_shift_register of shift_register is
    signal dq_array: std_logic_vector(3 downto 0);
begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            dq_array <= si & dq_array(3 downto 1);
        end if;
    end process;
    so <= dq_array(0);
end architecture;

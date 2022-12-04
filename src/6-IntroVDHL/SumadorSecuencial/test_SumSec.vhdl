library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_SumSec is
end test_SumSec;

architecture t_ss of test_SumSec is
    component SumSec is
        port (Clk, SC : in  STD_LOGIC;
              SM      : out STD_LOGIC);
    end component;
    
    signal Clk_s, SC_s, SM_s : STD_LOGIC;
begin
    
    clk_proc : process begin
        clk_s <= '0';
            wait for 1 ns;
        clk_s <= '1';
            wait for 1 ns;
    end process;

    test_proc : process begin
        SC_s <= '0';
            wait for 1 ns;
        SC_s <= '1';
            wait for 1 ns;
        SC_s <= '1';
            wait for 1 ns;
        SC_s <= '0';
            wait for 1 ns;
        SC_s <= '1';
            wait for 1 ns;
        SC_s <= '0';
            wait for 1 ns;
        SC_s <= '1';
            wait for 1 ns;
        SC_s <= '0';
            wait for 1 ns;
        SC_s <= '1';
            wait for 1 ns;
    end process;

end architecture t_ss;

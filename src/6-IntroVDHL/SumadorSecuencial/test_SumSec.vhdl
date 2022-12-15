library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_SumSec is
end test_SumSec;

architecture t_ss of test_SumSec is
    component SumSec is
        port (Clk, SC : in  STD_LOGIC;
              iA, iB  : in  STD_LOGIC;
              SM      : out STD_LOGIC);
    end component;

    constant T : time := 10 ns;
    
    signal Clk_s, SC_s, SM_s : STD_LOGIC;
    signal iA_s, iB_s        : STD_LOGIC;

begin

    test : SumSec port map (Clk => Clk_s,
                            SC  => SC_s,
                            iA  => iA_s,
                            iB  => iB_s,
                            SM  => SM_s);
    
    SC_s <= '1';
    
    clk_proc : process begin
        Clk_s <= '1';
            wait for T/2;
        Clk_s <= '0';
            wait for T/2;
    end process;

    test_proc : process begin
            iA_s <= '0';
            iB_s <= '0';
            wait for T;
            
            iA_s <= '1';
            iB_s <= '0';
            wait for T;
            
            iA_s <= '0';
            iB_s <= '0';
            wait for T;
            
            iA_s <= '1';
            iB_s <= '0';
            wait for T;
            
            iA_s <= '0';
            iB_s <= '0';
            wait for T;

            iA_s <= '0';
            iB_s <= '0';
            wait for T;

    end process;

end architecture t_ss;

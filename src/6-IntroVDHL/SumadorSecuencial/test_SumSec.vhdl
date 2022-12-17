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
        -- Los bits se meten en "orden inverso".
        -- Para meter 2 en el registro y que quede así |0|0|1|0|
        --  se tiene que meter primero un 0, luego un 1, y luego dos 0.
        -- Para meter 5 en el registro y que quede así |0|1|0|1|
        --  se tiene que meter primero un 1, luego 0, luego 1, y luego 0
        -- La salida daría 7, también al revés: |1|1|1|0|, porque va
        --  sumando los bits de menos a más significativos, y los
        --  saca en ese orden también.
        -- 2 + 5 = 7
            iA_s <= '0';
            iB_s <= '1';
            wait for T;
            
            iA_s <= '1';
            iB_s <= '0';
            wait for T;
            
            iA_s <= '0';
            iB_s <= '1';
            wait for T;
            
            iA_s <= '0';
            iB_s <= '0';
            wait for T;

    end process;

end architecture t_ss;

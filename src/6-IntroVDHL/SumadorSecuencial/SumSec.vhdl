library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumSec is
    port (Clk, SC : in  STD_LOGIC;
          SM      : out STD_LOGIC
          );
end SumSec;

architecture arch_sumsec of SumSec is
    component ST
        port (A, B, Cin : in  STD_LOGIC;
              Cout, S   : out STD_LOGIC);
    end component;

    component shift_register
        port (si, clk : in  STD_LOGIC;
              so      : out STD_LOGIC);
    end component;

    component D_FlipFlop
        port (D, Clk  : in  STD_LOGIC;
              Q, No_Q : out STD_LOGIC);
    end component;
    
    
    signal CLK_s   : STD_LOGIC;
    
    signal SRAo_s  : STD_LOGIC;
    signal SRBo_s  : STD_LOGIC;
    
    signal DFFQ_s  : STD_LOGIC;
    signal DFFQn_s : STD_LOGIC;
    
    signal S_s     : STD_LOGIC;
    signal Cout_s  : STD_LOGIC;
    
    signal SM_s    : STD_LOGIC;
    
begin

    CLK_s <= Clk NAND SC;

    SR_A : shift_register
    port map (si  => SRAo_s,
              clk => CLK_s,
              so  => SRAo_s);

    SR_B : shift_register
    port map (si  => SRBo_s,
              clk => CLK_s,
              so  => SRBo_s);
              
    DFF : D_FlipFlop
    port map (D    => Cout_s,
              Clk  => CLK_s,
              Q    => DFFQ_s,
              No_Q => DFFQn_s);
              
              
    Sumador : ST
    port map (A    => SRAo_s,
              B    => SRBo_s,
              Cin  => DFFQ_s,
              S    => S_s,
              Cout => Cout_s);

    SR_c : shift_register
    port map (si  => S_s,
              clk => CLK_s,
              so  => SM_s);

    SM <= SM_s;

end arch_sumsec;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumSec is
    port (Clk, SC : in  STD_LOGIC;
          iA, iB  : in  STD_LOGIC;
          SM      : out STD_LOGIC);
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
    
    signal CLK_s          : STD_LOGIC; -- Señal clock
    signal SRAo_s, SRBo_s : STD_LOGIC; -- Señales de salida de los registros
    signal DQ_s, DQn_s    : STD_LOGIC; -- Señales de salida del biestable
    signal Cout_s, S_s    : STD_LOGIC; -- Señales de salida del sumador
    signal SM_s           : STD_LOGIC; -- Salida del último registro; resultado

begin

    CLK_s <= Clk NAND SC;

    SR_A : shift_register
    port map (si  => iA,
              clk => CLK_s,
              so  => SRAo_s);

    SR_B : shift_register
    port map (si  => iB,
              clk => CLK_s,
              so  => SRBo_s);

    Sumador : ST
    port map (A    => SRAo_s,
              B    => SRBo_s,
              Cin  => DQ_s,
              S    => S_s,
              Cout => Cout_s);

    Biestable : D_FlipFlop
    port map (D    => Cout_s,
              Clk  => CLK_s,
              Q    => DQ_s,
              No_Q => DQn_s);

    SR_C : shift_register
    port map (si  => S_s,
              Clk => CLK_S,
              so  => SM_s);

    SM <= SM_s;

end arch_sumsec;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumsec is
	port (Clk, SC : in  STD_LOGIC;
	      SM      : out STD_LOGIC);
end sumsec;

architecture arch_sumsec of sumsec is
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
	
	signal s_nand_1, s_sr0, s_sr1, s_A, s_B, s_Cout, s_Sum, s_Q, s_No_Q : STD_LOGIC;

begin

    s_nand_1 <= Clk NAND SC;
    
    s_A <= s_sr0;
    s_B <= s_sr1;

	sr0 : shift_register
	port map (si => s_A,
              clk => s_nand_1,
              so => s_sr0);

	sr1 : shift_register
	port map (si => s_B,
              clk => s_nand_1,
              so => s_sr1);

	sum0 : ST
	port map (A => s_A, 
              B => s_B,
              Cin => s_Q,
              Cout => s_Cout,
              S => s_Sum);

	D0 : D_FlipFlop
	port map(D => s_Cout,
             Clk => s_nand_1,
             Q => s_Q,
             No_Q => s_No_Q);

	sr2 : shift_register
	port map (si => s_Sum,
              clk => s_nand_1,
              so => SM);

end arch_sumsec;

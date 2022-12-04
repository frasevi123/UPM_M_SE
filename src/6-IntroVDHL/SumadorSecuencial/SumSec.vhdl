library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumsec is
	port (Clk, SC : in  STD_LOGIC;
	      SM      : out STD_LOGIC);
end sumsec;

architecture arch_sumsec is
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

begin

	sr0 : shift_register
	port map ();

	sr1 : shift_register
	port map ();

	sum0 : ST
	port map ();

	D0 : D_FlipFlop
	port map();

	sr2 : shift_register
	port map ();

end arch_sumsec;

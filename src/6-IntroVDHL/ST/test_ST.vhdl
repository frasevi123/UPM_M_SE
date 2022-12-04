library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_ST is
end test_ST;

architecture t_ST of test_ST is
	component ST
	port (A, B, Cin : in  STD_LOGIC;
          Cout, S   : out STD_LOGIC);
	end component;

signal a_s, b_s, Cin_s, Cout_s, S_s : STD_LOGIC;

begin
	test : ST port map (A    => a_s,
                        B    => b_s,
			            Cin  => Cin_s,
			            Cout => Cout_s,
			            S    => S_s);

	test_proc : process begin
		Cin_s <= '0';
		a_s   <= '0';
		b_s   <= '0';
		wait for 1 ns;

		a_s   <= '0';
		b_s   <= '1';
		wait for 1 ns;

		a_s   <= '1';
		b_s   <= '0';
		wait for 1 ns;

		a_s   <= '1';
		b_s   <= '1';
		wait for 1 ns;

 -- -------------------------------------------
 -- -------------------------------------------

		Cin_s <= '1';
		a_s   <= '0';
		b_s   <= '0';
		wait for 1 ns;

		a_s   <= '0';
		b_s   <= '1';
		wait for 1 ns;

		a_s   <= '1';
		b_s   <= '0';
		wait for 1 ns;

		a_s   <= '1';
		b_s   <= '1';
		wait for 1 ns;

	end process;
end architecture t_ST;


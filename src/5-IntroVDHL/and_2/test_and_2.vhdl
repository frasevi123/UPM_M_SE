library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_and_2 is
end entity test_and_2;

architecture t_and_2 of test_and_2 is

	component and_2
		port (A: in  STD_LOGIC;
		      B: in  STD_LOGIC;
		      C: out STD_LOGIC);
	end component;

	signal A2_s, B2_s, C2_s : STD_LOGIC;

begin
	lab1: and_2 port map (A => A2_s,
						  B => B2_s,
						  C => C2_s);
process is
begin
	loop
		A2_s <= '0';
		B2_s <= '0';
		wait for 1 ns;
	
		A2_s <= '0';
		B2_s <= '1';
		wait for 1 ns;

		A2_s <= '1';
		B2_s <= '0';
		wait for 1 ns;

		A2_s <= '1';
		B2_s <= '1';
		wait for 1 ns;

	end loop;
end process;

end architecture t_and_2;

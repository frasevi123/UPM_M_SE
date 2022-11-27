library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_shift_register is
end test_shift_register;

architecture t_sr of test_shift_register is
	component shift_register
		port (si, clk : in  STD_LOGIC;
			  so      : out STD_LOGIC);
	end component;

	signal si_s, clk_s, so_s : STD_LOGIC;
begin
	test : shift_register
		   port map (si  => si_s,
					 clk => clk_s,
					 so  => so_s);

	clk_proc : process begin
		clk_s <= '0';
		wait for 1 ns;
		clk_s <= '1';
		wait for 1 ns;
	end process;

	test_proc : process begin
		si_s <= '0';
		wait for 2 ns;
		si_s <= '1';
		wait for 2 ns;
		si_s <= '1';
		wait for 2 ns;
		si_s <= '0';
		wait for 2 ns;
	end process;

end architecture t_sr;





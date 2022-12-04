library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ST is
	port (A, B, Cin : in  STD_LOGIC;
              Cout, S   : out STD_LOGIC);
end ST;

architecture arch_st of ST is
begin
	Cout <= (a and b) or (a and Cin) or (b and Cin);
	S    <= a xor b xor Cin;
end arch_st;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_2 is
    port (A : in  STD_LOGIC;
          B : in  STD_LOGIC;
          C : out STD_LOGIC);
end entity and_2;

architecture behaviour_and_2 of and_2 is
begin
    C <= A and B;
end architecture behaviour_and_2;

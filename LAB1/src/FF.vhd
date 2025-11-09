LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ff is
	port (
		R 					  : in std_logic;
		Clock, Resetn, Enable : in std_logic; -- rst sincrono, enable attivo alto
		Q 					  : out std_logic
	);
end ff;

architecture Behavior of ff is
begin
	process (Clock)
	begin
		if (Resetn = '0') then
			Q <= '0';
		elsif (rising_edge(Clock)) then
			if Enable = '1' then
				Q <= R;
			end if;
		end if;
	end process;
end Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity regn_s is
	generic (N : integer:=4);
	port (
		R 					  : in signed(N-1 downto 0);
		Clock, Resetn, Enable : in std_logic; -- rst sincrono, enable attivo alto
		Q 					  : out signed(N-1 downto 0)
	);
end regn_s;

architecture Behavior of regn_s is
begin
	process (Clock)
	begin
		if (Resetn = '0') then
			Q <= (others => '0');
		elsif (rising_edge(Clock)) then
			if Enable = '1' then
				Q <= R;
			end if;
		end if;
	end process;
end Behavior;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity booth_encoder is
    port(
        a     : in signed(15 downto 0);
        be_in : in unsigned(2 downto 0);
        s     : out std_logic;
        p     : out signed(16 downto 0)
    );
end booth_encoder;

architecture behavioral of booth_encoder is
    signal a_n : signed(15 downto 0);
begin
    a_n <= not(a);
    process(a, be_in)
    begin
        case be_in is
            when "000" | "111" =>
                s <= '0';
                p <= (others => '0');
            when "001" | "010" =>
                s <= '0';
                p <= '0' & a;
            when "011" =>
                s <= '0';
                p <= '0' & shift_left(a, 1) ;
            when "100" =>
                s <= '1';
                p <= '1' & shift_left(a_n, 1);
            when "101" | "110" =>
                s <= '1';
                p <= '1' & a_n;
            when others =>
                s <= '1';
                p <= (others => '0');
        end case;
    end process;
end behavioral;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r4mbe is
    port(
        x, a : in unsigned(15 downto 0);
        y : out unsigned(31 downto 0)
    );
end r4mbe;



architecture structural of r4mbe is
    type vector_be9 is array (0 to 8) of unsigned(2 downto 0);

    signal be_in : vector_be9;


begin
    be_in(8) <= "00" & x(15);
    be_in(0) <= x(1) & x(0) & '0';

    gen_be: for i in 1 to 7 generate
        be_in(i) <= x(2*i+1 downto 2*i-1);
    end generate gen_be;

end structural;

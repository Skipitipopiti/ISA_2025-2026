library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r4mbe is
    port(
        x, a : in unsigned(7 downto 0);
        y : out unsigned(15 downto 0)
    );
end r4mbe;



architecture structural of r4mbe is
    type vector_be9 is array (0 to 4) of unsigned(2 downto 0);
    type vector_p_be9 is array (0 to 3) of signed(8 downto 0);

    signal be_in : vector_be9; -- booth encoder inputs
    signal s_be  : std_logic_vector(4 downto 0); -- booth encoder out sign bits
    signal p_be  : vector_p_be9; -- booth encoder out partial products

    component booth_encoder is
    port(
        a     : in signed(7 downto 0);
        be_in : in unsigned(2 downto 0);
        s     : out std_logic;
        p     : out signed(8 downto 0) -- 9 bits per via dello shift left, l'ultimo p ne ha uno in meno perché non è mai shiftato
    );
    end component booth_encoder;

    component wallace_tree
        port(
            p0, p1, p2, p3  : in signed(8 downto 0);
            p4              : in signed(7 downto 0);
            s               : in std_logic_vector(4 downto 0);
            sum             : out signed(15 downto 0)
        );
    end component;

begin
    -- triplets generation for booth encoders
    be_in(4) <= "00" & x(15);
    be_in(0) <= x(1) & x(0) & '0';

    gen_be: for i in 1 to 3 generate
        be_in(i) <= x(2*i+1 downto 2*i-1);
    end generate gen_be;

    -- booth encoders instantiation
    be_g_inst: for i in 0 to 4 generate
        be_inst: booth_encoder
            port map(
                a     => signed(a),
                be_in => be_in(i),
                s     => s_be(i),
                p     => p_be(i)
            );
    end generate be_g_inst;

    -- wallace tree instantiation
    wt_inst: wallace_tree
        port map(
            p0  => p_be(0),
            p1  => p_be(1),
            p2  => p_be(2),
            p3  => p_be(3),
            p4  => signed(p_be(4)(7 downto 0)), -- last partial product is 8 bits only, seguento bewick.pdf, ho scartato il segno perché è sempre positivo
            s   => s_be(4 downto 0),
            sum => signed(y)
        );

end structural;

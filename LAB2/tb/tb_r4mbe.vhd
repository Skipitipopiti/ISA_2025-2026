library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_r4mbe is
end tb_r4mbe;

architecture behavior of tb_r4mbe is

    signal x_tb : unsigned(7 downto 0);
    signal a_tb : unsigned(7 downto 0);
    signal y_tb : unsigned(15 downto 0);

    component r4mbe is
        port(
            x, a : in unsigned(7 downto 0);
            y : out unsigned(15 downto 0)
        );
    end component;

begin
    uut: r4mbe
        port map(
            x => x_tb,
            a => a_tb,
            y => y_tb
        );

    stim_proc: process
    begin
        -- test vector 1
        x_tb <= "00011010"; -- 26
        a_tb <= "00000101"; -- 5
        wait for 100 ns;

        -- test vector 2
        x_tb <= "11100100"; -- 228
        a_tb <= "00000011"; -- 3
        wait for 100 ns;

        -- test vector 3
        x_tb <= "01111111"; -- 127
        a_tb <= "01111111"; -- 127
        wait for 100 ns;

        -- test vector 4
        x_tb <= "10000000"; -- 128
        a_tb <= "10000000"; -- 128
        wait for 100 ns;

        wait;
    end process;

end behavior;

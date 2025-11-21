library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_wallace_tree is
end tb_wallace_tree;

architecture behavior of tb_wallace_tree is

    -- component under test
    component wallace_tree
        port(
            p0, p1, p2, p3  : in signed(8 downto 0);
            p4              : in signed(7 downto 0);
            s               : in std_logic_vector(8 downto 0);
            sum             : out signed(15 downto 0)
        );
    end component;

    -- signals
    signal p0_tb, p1_tb, p2_tb, p3_tb : signed(8 downto 0);
    signal p4_tb                       : signed(7 downto 0);
    signal s_tb                        : std_logic_vector(8 downto 0);
    signal sum_tb                      : signed(15 downto 0);
begin
    -- instantiate the unit under test (UUT)
    uut: wallace_tree
        port map (
            p0 => p0_tb,
            p1 => p1_tb,
            p2 => p2_tb,
            p3 => p3_tb,
            p4 => p4_tb,
            s  => s_tb,
            sum => sum_tb
        );

    -- stimulus process
    stim_proc: process
    begin		
        -- test case 1
        p0_tb <= to_signed(45, 9);
        p1_tb <= to_signed(23, 9);
        p2_tb <= to_signed(12, 9);
        p3_tb <= to_signed(7, 9);
        p4_tb <= to_signed(3, 8);
        s_tb  <= "000000000";
        wait for 100 ns;

        -- test case 2
        p0_tb <= to_signed(100, 9);
        p1_tb <= to_signed(50, 9);
        p2_tb <= to_signed(25, 9);
        p3_tb <= to_signed(10, 9);
        p4_tb <= to_signed(5, 8);
        s_tb  <= "000000000";
        wait for 100 ns;

        -- end simulation
        wait;
    end process;

end behavior;
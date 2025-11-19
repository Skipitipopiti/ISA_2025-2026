library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wallace_tree is
    port(
        p0, p1, p2, p3, p4, p5, p6, p7, p8 : in signed(16 downto 0) ;
        s                                  : in std_logic_vector(8 downto 0) ;
        sum                                : out signed(31 downto 0)  -- scusa..
    );
end wallace_tree;

architecture structural of wallace_tree is

    component fa
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            s    : out std_logic;
            cout : out std_logic
        );
    end component;

    component ha
        Port (
            a     : in  std_logic;
            b     : in  std_logic;
            sum   : out std_logic;
            cout  : out std_logic
        );
    end component;

    -- layer 1
    signal s_l1 : std_logic_vector(19 downto 0);  -- uscite adders layer 1
    signal c_l1 : std_logic_vector(19 downto 0);  -- uscite carry layer 1

    ha0_l1 : ha port map (
        a    => p0(0),
        b    => s(1),
        sum  => s_l1(0),
        cout => c_l1(0)
    );
    s_l1(1) <= p0(1);  -- since we used it in ha0_l1
    fa2_l1 : fa port map (
        a    => p0(2),
        b    => p1(2),
        cin  => s(2),
        s    => s_l1(2),
        cout => c_l1(3)
    );
    ha3_l1 : ha port map (
        a    => p0(3),
        b    => p1(3),
        sum  => s_l1(3),
        cout => c_l1(4)
    );
    

    fa_layer1 : for i in 0 to 17 generate
        
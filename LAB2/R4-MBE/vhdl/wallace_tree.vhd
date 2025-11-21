library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wallace_tree is
    port(
        p0, p1, p2, p3  : in signed(8 downto 0);
        p4              : in signed(7 downto 0);
        s               : in std_logic_vector(4 downto 0);
        sum             : out signed(15 downto 0)
    );
end wallace_tree;

architecture structural of wallace_tree is

    component fa
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            sum  : out std_logic;
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

    -- signals
    signal s_l0 : std_logic_vector(11 downto 0);  -- layer 1 first operand (first row)
    signal c_l0 : std_logic_vector(11 downto 0);  -- l1 second oprd
    signal f_l0 : std_logic_vector(11 downto 0);  -- l1 third oprd

    signal s_l1 : std_logic_vector(15 downto 0);   -- l1 sum output and l2 first oprd
    signal c_l1 : std_logic_vector(13 downto 0);   -- l1 cout and l2 second oprd
    signal f_l1 : std_logic_vector(9 downto 0);    -- l2 third oprd

    signal s_l2 : std_logic_vector(15 downto 0);   -- l2 sum ouput and l3 first oprd
    signal c_l2 : std_logic_vector(13 downto 0);   -- l2 cout and l3 second oprd
    signal f_l2 : std_logic_vector(6 downto 0);    -- l3 third oprd

    signal s_l3 : std_logic_vector(16 downto 0);   -- l3 sum output and final first oprd
    signal c_l3 : std_logic_vector(13 downto 0);   -- l3 cout and final second oprd

    signal s_l4 : std_logic_vector(2 downto 0); -- padding for final result
    signal s_add : unsigned(13 downto 0); -- final result MSBs from beh adder

    begin
    
    -- layer 0
    -- operands building
    s_l0 <= not(s(0)) & s(0) & s(0) & std_logic_vector(p0); -- first oprd build
    c_l0 <= '1' & not(s(1)) & std_logic_vector(p1) & s(1); -- second oprd build
    f_l0 <= '1' & not(s(2)) & std_logic_vector(p2) & s(2); -- third oprd build
    
    -- processing
    ha0_l0 : ha port map (
        a    => s_l0(0),
        b    => c_l0(0),
        sum  => s_l1(0),
        cout => c_l1(0)
    );

    s_l1(1) <= s_l0(1);  -- direct connection

    fa0_l0 : fa port map ( -- parto sempre da 0 per comodità
        a    => s_l0(2),
        b    => c_l0(1),
        cin  => f_l0(0),
        sum  => s_l1(2),
        cout => c_l1(1)
    );

    ha1_l0 : ha port map (
        a    => s_l0(3),
        b    => c_l0(2),
        sum  => s_l1(3),
        cout => c_l1(2)
    );

    fa_1to8_l0 : for i in 0 to 7 generate
        fa_g_l0 : fa port map (
            a    => s_l0(i+4),
            b    => c_l0(i+3),
            cin  => f_l0(i+1),
            sum  => s_l1(i+4),
            cout => c_l1(i+3)
        );
    end generate;

    ha2_l0 : ha port map (
        a    => c_l0(11),
        b    => f_l0(9),
        sum  => s_l1(12),
        cout => c_l1(11)
    );

    s_l1(13) <= f_l0(10);  -- direct connection
    s_l1(14) <= f_l0(11);  -- direct connection
    s_l1(15) <= not(s(3));    -- padding

    c_l1(12) <= p3(8);  -- padding
    c_l1(13) <= p4(7);  -- padding


    -- layer 1

    -- operands building
    -- s_l1 end c_l1 come ready from previous layer
    f_l1 <= p4(6) & std_logic_vector(p3(7 downto 0)) & s(3); -- third oprd build

    -- processing
    s_l2(0) <= s_l1(0);  -- direct connection

    ha0_l1 : ha port map (
        a    => s_l1(1),
        b    => c_l1(0),
        sum  => s_l2(1),
        cout => c_l2(0)
    );

    s_l2(2) <= s_l1(2);  -- direct connection

    ha1_l1 : ha port map (
        a    => s_l1(3),
        b    => c_l1(1),
        sum  => s_l2(3),
        cout => c_l2(1)
    );

    fa0_l1 : fa port map (
        a    => s_l1(4),
        b    => c_l1(2),
        cin  => f_l1(0),
        sum  => s_l2(4),
        cout => c_l2(2)
    );

    ha2_l1 : ha port map (
        a    => s_l1(5),
        b    => c_l1(3),
        sum  => s_l2(5),
        cout => c_l2(3)
    );

    fa_1to9_l1 : for i in 0 to 8 generate
        fa_g_l1 : fa port map (
            a    => s_l1(i+6),
            b    => c_l1(i+4),
            cin  => f_l1(i+1),
            sum  => s_l2(i+6),
            cout => c_l2(i+4)
        );
    end generate;

    ha3_l1 : ha port map (
        a    => s_l1(15),
        b    => c_l1(13),
        sum  => s_l2(15),
        cout => c_l2(13)
    );

    -- layer 2
    -- operands building
    -- s_l2 end c_l2 come ready from previous layer
    f_l2 <= std_logic_vector(p4(5 downto 0)) & s(4);
    
    -- processing
    s_l3(0) <= s_l2(0);  -- direct connection
    s_l3(1) <= s_l2(1);  -- direct connection

    ha0_l2 : ha port map (
        a    => s_l2(2),
        b    => c_l2(0),
        sum  => s_l3(2),
        cout => c_l3(0)
    );

    s_l3(3) <= s_l2(3);  -- direct connection
    c_l3(1) <= '0';      -- to prepare for last addition

    ha_1to2_l2 : for i in 0 to 1 generate
        ha_g_l2 : ha port map (
            a    => s_l2(i+4),
            b    => c_l2(i+1),
            sum  => s_l3(i+4),
            cout => c_l3(i+2)
        );
    end generate;

    fa0_l2 : fa port map (
        a    => s_l2(6),
        b    => c_l2(3),
        cin  => f_l2(0),
        sum  => s_l3(6),
        cout => c_l3(4)
    );

    ha3_l2 : ha port map (
        a    => s_l2(7),
        b    => c_l2(4),
        sum  => s_l3(7),
        cout => c_l3(5)
    );

    fa_1to6_l2 : for i in 0 to 5 generate
        fa_g_l2 : fa port map (
            a    => s_l2(i+8),
            b    => c_l2(i+5),
            cin  => f_l2(i+1),
            sum  => s_l3(i+8),
            cout => c_l3(i+6)
        );
    end generate;

    ha_4to5_l2 : for i in 0 to 1 generate
        ha_g_l2 : ha port map (
            a    => s_l2(i+14),
            b    => c_l2(i+11),
            sum  => s_l3(i+14),
            cout => c_l3(i+12)
        );
    end generate;

    s_l3(16) <= c_l2(13);    -- padding

    -- layer 3
    -- operands building
    -- s_l3 end c_l3 come ready from previous layer

    -- processing, last adderx14
    s_l4(0) <= s_l3(0);  -- direct connection
    s_l4(1) <= s_l3(1);  -- direct connection
    s_l4(2) <= s_l3(2);  -- direct connection
    s_add <= unsigned(s_l3(16 downto 3)) + unsigned(c_l3); -- cout viene scartato qui, poi ne scarto un altro dopo per la questione degli Ss
    
    -- final result allignment
    sum <= signed(std_logic_vector(s_add(12 downto 0)) & s_l4);

end structural;

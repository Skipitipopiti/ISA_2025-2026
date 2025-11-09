library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity data_gen16 is  
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    D0    : out std_logic_vector(15 downto 0);
    D1    : out std_logic_vector(15 downto 0);
    D2    : out std_logic_vector(15 downto 0);
    VOUT  : out std_logic;
    END_SIM : out std_logic);
end entity data_gen16;

architecture beh of data_gen16 is

  constant tco : time := 1 ns;

  type tval_t is array (0 to 9) of std_logic_vector(15 downto 0);
  constant ctvalA : tval_t := (
    ("0011111111000000"),  -- 1.5
    ("0100000000000000"),  -- 2
    ("0011100100011101"),  -- 0.0001
    ("0101000001100000"),  -- 1.5e10
    ("0000000000000010"),  -- 1.5e-40
    ("1011111111000000"),  -- -1.5
    ("0011111111000000"),  -- 1.5
    ("0011111111000000"),  -- 1.5
    ("0101000000010101"),  -- 1e10
    ("0011111110000000")  -- 1
    );  

  constant ctvalB : tval_t := (
    ("0100000000000000"),  -- 2
    ("0011111111000000"),  -- 1.5
    ("0011100101010010"),  -- 0.0002
    ("0101000010010101"),  -- 2e10 
    ("0000000000000010"),  -- 2.0e-40
    ("0100000000000000"),  -- 2
    ("0011111110000000"),  -- 1
    ("0000000000000000"),  -- 0
    ("0010111011011100"),  -- 1e-10
    ("0011111110000000")  -- 1                                                            -- 
    );  
  
  signal cnt : integer := 0;
  signal sEnd_sim : std_logic;

  signal sEnd_sim_pipe : std_logic_vector(9 downto 0);
  
begin  -- architecture beh

  process (CLK, RST_n) is
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      cnt <= 0;  
      D0 <= (others => '0');
      D1 <= (others => '0');
      D2 <= (others => '0');
      VOUT <= '0';
      sEnd_sim <= '0';
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if (cnt < 10) then
        cnt <= cnt + 1 after tco;
        D0 <= ctvalA(cnt) after tco;
        D1 <= ctvalB(cnt) after tco;
        VOUT <= '1' after tco;
        sEnd_sim <= '0' after tco;          
      else
        VOUT <= '0' after tco;
        sEnd_sim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n) is
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      sEnd_sim_pipe <= (others => '0');
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      sEnd_sim_pipe(0) <= sEnd_sim after tco;
      sEnd_sim_pipe(9 downto 1) <= sEnd_sim_pipe(8 downto 0) after tco;
    end if;
  end process;

  END_SIM <= sEnd_sim_pipe(9);

end beh;

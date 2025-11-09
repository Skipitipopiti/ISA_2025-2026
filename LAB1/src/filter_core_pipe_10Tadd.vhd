library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity filter_core_pipe_10Tadd is
port(
  clk                               : in std_logic; -- clock

  DIN                               : in signed(8 downto 0); -- input samples, arrivano uno alla volta assieme a VIN
  b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10 : in signed(8 downto 0); -- coefficienti del filtro
  a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10 : in signed(8 downto 0); -- coefficienti di autoregressione (non utilizzati) 
  VIN                               : in std_logic; -- segnale di validazione, quando è attivo (alto), è pronto un nuovo campione in DIN
  RST_n                             : in std_logic; -- attivo basso
  
  DOUT                              : out signed(8 downto 0); -- output del filtro, un campione alla volta
  VOUT                              : out std_logic -- segnale di validazione, quando è attivo (alto), è pronto un nuovo campione in DOUT
);
end filter_core_pipe_10Tadd;

architecture beh of filter_core_pipe_10Tadd is
  
  type signed_vector is array (0 to 10) of signed(8 downto 0);-- y signals
  type signed_vector_y_tmp is array (0 to 10) of signed(17 downto 0); -- appoggio moltiplicazione
  type signed_vector_acc is array (0 to 10) of signed(12 downto 0);

  component regn_s is
      generic (N : integer:=4);
      port (
        R             : in signed(N-1 downto 0);
        Clock, Resetn, Enable : in std_logic; -- rst sincrono, enable attivo alto
        Q             : out signed(N-1 downto 0)
      );
  end component;

  component ff is
      port (
        R             : in std_logic;
        Clock, Resetn, Enable : in std_logic; 
        Q             : out std_logic
      );
  end component;

  signal x : signed_vector;
  signal y : signed_vector;
  signal y_p : signed_vector;
  signal b : signed_vector; -- vettore dei coefficienti
  signal bi : signed_vector;
  signal y_tmp : signed_vector_y_tmp;
  signal z : signed_vector_acc;
  signal z_temp : signed(8 downto 0);
  signal v_o : std_logic;
  signal v_o_d : std_logic;
  

  begin
    b(0) <= b0; b(1) <= b1; b(2) <= b2;
    b(3) <= b3; b(4) <= b4; b(5) <= b5; b(6) <= b6;
    b(7) <= b7; b(8) <= b8; b(9) <= b9; b(10) <= b10;
    
  -- in regs
  
  DIN_REG: regn_s
      generic map (N =>9)
      port map(
        R      => DIN,
        Clock  => clk,
        Resetn => RST_n,
        Enable => '1',
        Q      => x(0)
      );
    
  VIN_REG: ff
      port map(
        R      => VIN, 
        Clock  => clk,
        Resetn => RST_n,
        Enable => '1',
        Q      => v_o
      );

  BIN_REG: 
    for i in 0 to 10 generate
    begin
      REG : regn_s 
          generic map(N => 9)
          port map(
            R      => b(i),
            Clock  => clk,
            Resetn => RST_n,
            Enable => '1',
            Q      => bi(i)
          );
    end generate;

    



  -- filter

  FIR_SHIFT_REG:
  for i in 0 to 9 generate
  begin
    REG : regn_s 
        generic map(N => 9)
        port map(
          R      => x(i),
          Clock  => clk,
          Resetn => RST_n,
          Enable => v_o,
          Q      => x(i+1)
        );
  end generate;

  MULT:
  for i in 0 to 10 generate
    begin
      y_tmp(i) <= x(i) * bi(i);
      y(i) <= resize(y_tmp(i)(16 downto 8), 9);      -- Q2.16 --> Q1.8
  end generate;

  AFTER_MULT_PIPE: -- registri di pipe dopo i moltiplicatori 
  for i in 0 to 10 generate
  begin
    REG : regn_s
        generic map(N => 9)
        port map(
          R      => y(i),
          Clock  => clk,
          Resetn => RST_n,
          Enable => v_o,
          Q      => y_p(i)
        );
  end generate;

  z(0) <= resize(y_p(0), 13);                         -- Q1.8 ? Q5.8

  SUM:
  for i in 0 to 9 generate
    z(i+1) <= z(i) + resize(y_p(i+1), 13);
  end generate;
  
  
  -- out regs
  
  z_temp <= resize(z(10)(8 downto 0), 9);
  DOUT_REG: regn_s
      generic map (N =>9)
      port map(
        R      => z_temp,
        Clock  => clk,
        Resetn => RST_n,
        Enable => '1',
        Q      => DOUT
      );
    

--  v_o <= v(0) and v(10);
  VOUT_DELAY_REG: ff port map(
        R      => v_o,
        Clock  => clk,
        Resetn => RST_n,
        Enable => '1',
        Q      => v_o_d
      );

  VOUT_REG: ff
      port map(
        R      => v_o_d,
        Clock  => clk,
        Resetn => RST_n,
        Enable => '1',
        Q      => VOUT
      );
   

end beh;
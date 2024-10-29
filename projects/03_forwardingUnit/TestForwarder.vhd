library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestForwarder is
end entity;

architecture test of TestForwarder is
  type test_Forwarder is record
    n, m: unsigned(4 downto 0);    
    exMemD: unsigned(4 downto 0);
    exMemRegWrite: std_logic;
    memWbrD: unsigned(4 downto 0);
    memWbrRegWrite: std_logic;
    forwardA: unsigned(1 downto 0);
    forwardB: unsigned(1 downto 0);    
  end record;

  signal forwarder: test_Forwarder;
begin
  process
  begin
    wait for 10 ns;

    --Test (a)
    forwarder.exMemRegWrite <= '0';
    forwarder.memWbrRegWrite <= '0';
    forwarder.n <= "00001";
    forwarder.m <= "00010";
    forwarder.exMemD <= "00100";
    forwarder.memWbrD <= "01000";
    wait for 10 ns;
    assert forwarder.forwardA = "00"; 
    assert forwarder.forwardB = "00";


    --Test (b)
    forwarder.exMemRegWrite <= '0';
    forwarder.memWbrRegWrite <= '0';
    forwarder.n <= "00001";
    forwarder.m <= "00001";
    forwarder.exMemD <= "00001";
    forwarder.memWbrD <= "00001";    
    wait for 10 ns;
    assert forwarder.forwardA = "00"; 
    assert forwarder.forwardB = "00";
    
    --Test (c)
    forwarder.exMemRegWrite <= '-';
    forwarder.memWbrRegWrite <= '1';
    forwarder.n <= "00001";
    forwarder.m <= "00010";
    forwarder.exMemD <= "00100";
    forwarder.memWbrD <= "01000";    
    wait for 10 ns;
    assert forwarder.forwardA = "00"; 
    assert forwarder.forwardB = "00";

    --Test (d)
    forwarder.exMemRegWrite <= '1';
    forwarder.memWbrRegWrite <= '-';
    forwarder.n <= "00001";
    forwarder.m <= "00001";
    forwarder.exMemD <= "00001";
    forwarder.memWbrD <= (others => '-');    
    wait for 10 ns;
    assert forwarder.forwardA = "10"; 
    assert forwarder.forwardB = "10";

    --Test (e)
    forwarder.exMemRegWrite <= '-';
    forwarder.memWbrRegWrite <= '1';
    forwarder.n <= "00001";
    forwarder.m <= "00001";
    forwarder.exMemD <= (others => '-');
    forwarder.memWbrD <= "00001";    
    wait for 10 ns;
    assert forwarder.forwardA = "01"; 
    assert forwarder.forwardB = "01";

    --Test (f)
    forwarder.exMemRegWrite <= '1';
    forwarder.memWbrRegWrite <= '1';
    forwarder.n <= "00001";
    forwarder.m <= "00001";
    forwarder.exMemD <= "00001";
    forwarder.memWbrD <= "00001";    
    wait for 10 ns;
    assert forwarder.forwardA = "10"; 
    assert forwarder.forwardB = "10";

    --Test (g)
    forwarder.exMemRegWrite <= '1';
    forwarder.memWbrRegWrite <= '-';
    forwarder.n <= to_unsigned(31, 5);
    forwarder.m <= to_unsigned(31, 5);
    forwarder.exMemD <= to_unsigned(31, 5);
    forwarder.memWbrD <= (others => '-');    
    wait for 10 ns;
    assert forwarder.forwardA = "00"; 
    assert forwarder.forwardB = "00";

    --Test (h)
    forwarder.exMemRegWrite <= '-';
    forwarder.memWbrRegWrite <= '1';
    forwarder.n <= to_unsigned(31, 5);
    forwarder.m <= to_unsigned(31, 5);
    forwarder.exMemD <= (others => '-');
    forwarder.memWbrD <= to_unsigned(31, 5);    
    wait for 10 ns;
    assert forwarder.forwardA = "00"; 
    assert forwarder.forwardB = "00";
    
    wait for 10 ns;
    wait;
  end process;    

  unit: entity work.Forwarder
    port map(
      n => forwarder.n,
      m => forwarder.m,
      exMemD => forwarder.exMemD,
      exMemRegWrite => forwarder.exMemRegWrite,
      memWbrD => forwarder.memWbrD,
      memWbrRegWrite => forwarder.memWbrRegWrite,
      forwardA => forwarder.forwardA,
      forwardB => forwarder.forwardB);
end architecture;

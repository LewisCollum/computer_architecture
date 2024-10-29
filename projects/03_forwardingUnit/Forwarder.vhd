library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Forwarder is
  port(
    n, m: in unsigned(4 downto 0);
    
    exMemD: in unsigned(4 downto 0);
    exMemRegWrite: in std_logic;
    
    memWbrD: in unsigned(4 downto 0);
    memWbrRegWrite: in std_logic;
    
    forwardA: out unsigned(1 downto 0);
    forwardB: out unsigned(1 downto 0));
end entity;
 
architecture behavioral of Forwarder is
begin
  process(n, m, exMemD, memWbrD, exMemRegWrite, memWbrRegWrite)
    impure function isExecutionHazardFromN return boolean is
    begin
      return exMemRegWrite = '1' and
        exMemD /= 31 and
        exMemD = n;
    end function;

    impure function isExecutionHazardFromM return boolean is
    begin
      return exMemRegWrite = '1' and
        exMemD /= 31 and
        exMemD = m;
    end function;

    impure function isMemoryHazardFromN return boolean is
    begin
      return memWbrRegWrite = '1' and
        memWbrD /= 31 and
        not (exMemRegWrite = '1' and exMemD /= 31 and exMemD = n) and
        memWbrD = n;
    end function;

    impure function isMemoryHazardFromM return boolean is
    begin
      return memWbrRegWrite = '1' and
        memWbrD /= 31 and
        not (exMemRegWrite = '1' and exMemD /= 31 and exMemD = m) and
        memWbrD = m;
    end function;    
    
  begin
    if isExecutionHazardFromN then
      forwardA <= "10";
    elsif isMemoryHazardFromN then
      forwardA <= "01";
    else
      forwardA <= "00";
    end if;
    
    if isExecutionHazardFromM then
      forwardB <= "10";
    elsif isMemoryHazardFromM then
      forwardB <= "01";
    else
      forwardB <= "00";
    end if;
    
  end process;
end architecture;

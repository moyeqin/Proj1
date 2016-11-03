library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity main_control_test is
end main_control_test;

architecture behave of main_control_test is
component main_control is
port(op : in std_logic_vector(5 downto 0);
 RegWrt :out std_logic;
 ALUsrc :out std_logic;
 RegDst :out std_logic;
MemtoReg : out std_logic;
 MemWrt :out std_logic;
 branch :out std_logic;
   jump :out std_logic;
  Extop :out std_logic;
  ALUop :out std_logic_vector(2 downto 0));
end component;

signal op : std_logic_vector(5 downto 0);
signal RegWrt : std_logic;
signal ALUsrc : std_logic;
signal RegDst : std_logic;
signal MemtoReg : std_logic;
signal MemWrt : std_logic;
signal branch : std_logic;
signal jump : std_logic;
signal Extop : std_logic;
signal ALUop : std_logic_vector(2 downto 0);

begin
u: main_control port map(op=>op,RegWrt=>RegWrt,ALUsrc=>ALUsrc,RegDst=>RegDst,MemtoReg=>MemtoReg,MemWrt=>MemWrt,branch=>branch,jump=>jump,Extop=>Extop,ALUop=>ALUop);
process
begin
op<="000000";
wait for 5 ns;

op<="100011";
wait for 5 ns;

op<="101011";
wait for 5 ns;

op<="000100";
wait for 5 ns;

op<="000101";
wait for 5 ns;

op<="000111";
wait for 5 ns;

op<="001000";
wait for 5 ns;
end process;
end behave;

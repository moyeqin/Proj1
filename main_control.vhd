library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity main_control is
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
end main_control;

architecture dataflows of main_control is

component and_gate_6to1 is
port(x : in std_logic_vector(5 downto 0);
     z :out std_logic);
end component;

component or_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component or_gate_3to1 is
port(x : in std_logic_vector(2 downto 0);
     z :out std_logic);
end component;

component not_gate is
port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

signal sig_R : std_logic;
signal sig_LW : std_logic;
signal sig_SW : std_logic;
signal sig_beq : std_logic;
signal sig_bne : std_logic;
signal sig_bgtz : std_logic;
signal sig_addi : std_logic;

signal op_inverse : std_logic_vector(5 downto 0);


begin

G1: for I in 0 to 5 generate
not_gate_map: not_gate port map(x=>op(I),z=>op_inverse(I));
end generate G1;

--R-Type op
and_gate_map0: and_gate_6to1 port map(x=>op_inverse,z=>sig_R);
--lw op
and_gate_map1: and_gate_6to1 port map(x(0)=>op(0),x(1)=>op(1),x(2)=>op_inverse(2),x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op(5),z=>sig_LW);
--sw op
and_gate_map2: and_gate_6to1 port map(x(0)=>op(0),x(1)=>op(1),x(2)=>op_inverse(2),x(3)=>op(3),x(4)=>op_inverse(4),x(5)=>op(5),z=>sig_SW);
--beq op
and_gate_map3: and_gate_6to1 port map(x(0)=>op_inverse(0),x(1)=>op_inverse(1),x(2)=>op(2),x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_beq);
--bne op
and_gate_map4: and_gate_6to1 port map(x(0)=>op(0),x(1)=>op_inverse(1),x(2)=>op(2),x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_bne);
--bgtz op
and_gate_map5: and_gate_6to1 port map(x(0)=>op(0),x(1)=>op(1),x(2)=>op(2),x(3)=>op_inverse(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_bgtz);
--addi op
and_gate_map6: and_gate_6to1 port map(x(0)=>op_inverse(0),x(1)=>op_inverse(1),x(2)=>op_inverse(2),x(3)=>op(3),x(4)=>op_inverse(4),x(5)=>op_inverse(5),z=>sig_addi);

--RegWrt
or_gate_map0: or_gate_3to1 port map(x(0)=>sig_R,x(1)=>sig_LW,x(2)=>sig_addi,z=>RegWrt);
--ALUsrc
or_gate_map1: or_gate_3to1 port map(x(0)=>sig_LW,x(1)=>sig_SW,x(2)=>sig_addi,z=>ALUsrc);
--RegDst
or_gate_map2: or_gate port map(x=>sig_R,y=>sig_R,z=>RegDst);
--MemtoReg
or_gate_map3: or_gate port map(x=>sig_LW,y=>sig_LW,z=>MemtoReg);
--MemWrt
or_gate_map4: or_gate port map(x=>sig_SW,y=>sig_SW,z=>MemWrt);
--branch
or_gate_map5: or_gate_3to1 port map(x(0)=>sig_beq,x(1)=>sig_bne,x(2)=>sig_bgtz,z=>branch);
--jump
or_gate_map6: or_gate port map(x=>'0',y=>'0',z=>jump);
--Extop
or_gate_map7: or_gate_3to1 port map(x(0)=>sig_LW,x(1)=>sig_SW,x(2)=>sig_addi,z=>Extop);
--ALUop(2)
or_gate_map8: or_gate port map(x=>sig_R,y=>sig_R,z=>ALUop(2));
--ALUop(1)
or_gate_map9: or_gate port map(x=>'0',y=>'0',z=>ALUop(1));
--ALUop(0)
or_gate_map10: or_gate_3to1 port map(x(0)=>sig_beq,x(1)=>sig_bne,x(2)=>sig_bgtz,z=>ALUop(0));
end dataflows;











----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2020 01:34:06 AM
-- Design Name: 
-- Module Name: test_env - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;


architecture Behavioral of test_env is
signal s: std_logic_vector(15 downto 0) := "0000000000000000";
signal reset, enable, enable2: std_logic;
signal data_out, iesire_ram: std_logic_vector (15 downto 0);
--signal sw1, sw2, sw3, rezultat: std_logic_vector(15 downto 0
component ALUmips is
    Port ( IN1 : in STD_LOGIC_VECTOR (15 downto 0);
           IN2 : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           registru: in STD_LOGIC_VECTOR(2 downto 0);
           zero : out STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component InstructionFetch is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           adrBranch : in STD_LOGIC_VECTOR (15 downto 0);
           adrJump : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCsrc : in STD_LOGIC;
           adrUrm : out STD_LOGIC_VECTOR (15 downto 0);
           Instr : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component IC is
    Port ( clk : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           RegWr : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           enable: in std_logic;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           Ext_imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC);
end component;
component mpg is 
    Port ( en : out STD_LOGIC; 
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
  end component; 
  
component ssd is
    Port ( intrare : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;
component MEM is
    Port ( ALUrez : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           enable: in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           AluRezout : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component UC is
    Port ( Instr : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR(2 downto 0);
           MemWrite : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end component;

component rf is
    Port ( ra1 : in STD_LOGIC_VECTOR (2 downto 0);
           ra2: in STD_LOGIC_VECTOR (2 downto 0);
           wa: in STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           regWr : in STD_LOGIC;
           enable: in STD_LOGIC;
           rd2: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           rd1: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           wd: in STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

component EX is
    Port ( RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           AluSrc : in STD_LOGIC;
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           func : in STD_LOGIC_VECTOR (2 downto 0);
           sa : in STD_LOGIC;
           AluOp : in STD_LOGIC_VECTOR(2 downto 0);
           InstrUrm : in STD_LOGIC_VECTOR (15 downto 0);
           registru: in STD_LOGIC_VECTOR(2 downto 0);
           Zero : out STD_LOGIC;
           AdrBranch : out STD_LOGIC_VECTOR (15 downto 0);
           iesire: out STD_LOGIC_VECTOR(3 DOWNTO 0);
           rez : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component ram is
    Port ( intrare : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           regWr : in STD_LOGIC;
           iesire : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal instructiune, adresaUrm, adrjump, PC, adrbranch: std_logic_vector(15 downto 0);
signal ssdsig,ssig, r: std_logic_vector(15 downto 0);
signal sw7: std_logic_vector(2 downto 0);
signal RegDst,ExtOp,ALUSrc,Branch,JumpUC,jump,MemWrite,RegWrite, MemtoReg : STD_LOGIC;
signal wd, rd1, rd2, ext: std_logic_vector (15 downto 0);
signal sa, regWr: STD_LOGIC;
signal func,ALUOp : STD_LOGIC_VECTOR(2 downto 0);
signal ZEROex, PCSrc: STD_LOGIC;
signal iesire: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal adresabranch, rez,rezultat, aleg, iesire1,DataMEM, ALUrezultat: STD_LOGIC_VECTOR(15 DOWNTO 0);
begin
sw7 <= sw(7 downto 5);
prima : mpg port map (enable, btn(0), clk);
adoua: mpg port map (reset, btn(1), clk);


dinnou: InstructionFetch port map (clk, enable, reset, adresabranch, adrjump, Jump, PCSrc, adresaUrm, instructiune);
UCport: UC port map ( instructiune(15 downto 13), RegDst,ExtOp,ALUSrc,Branch,Jump,ALUOp,MemWrite, MemtoReg, RegWrite ); 

ICportmap: IC port map(clk, instructiune, wd, RegWrite, RegDst, ExtOp, enable, rd1, rd2, ext, func, sa);
--ghg: rf port map (instructiune(12 downto 10), instructiune (9 downto 7), instructiune (6 downto 4), clk, '1', enable, rd1, rd2,wd);
EXportmap: EX port map (rd1, rd2, ALUSrc, ext, func, sa, ALUOp, adresaUrm,instructiune(9 downto 7), ZEROex, adresabranch,iesire, rez);
--Al: ALUmips port map(rd1, rd2, sa, "0001","000", zeros, rezultat);
MEMportmap: MEM port map (rez, MemWrite,rd2, clk, enable, DataMEM, ALUrezultat);
process(MemtoReg)
begin
    case MemtoReg is 
        when '1' => wd <= DataMEM;
        when '0' => wd <= rez;
    end case;
end process;
PCSrc <= ZEROex and branch;
PC <= adresaUrm - 1;
adrjump<= PC(15 downto 13)  & instructiune(12 downto 0);
r<="000000000000000" & JumpUC;
iesire1 <= "000000000000000" & Jump;
process(sw7)
begin 
case sw7 is
    when "000" => ssdsig <= instructiune;
    when "001" => ssdsig <= adresaUrm;
    when "010" => ssdsig <= rd1;
    when "011" => ssdsig <= rd2;
    when "100" => ssdsig <= rez;
    when "101" => ssdsig <= ext;
    when "110" => ssdsig <= DataMEM;
    when "111" => ssdsig <= wd;
    when others => ssdsig <= "0000000000000000";
    
end case;
end process;
 
doua: ssd port map (ssdsig, clk, an ,cat);

end Behavioral;

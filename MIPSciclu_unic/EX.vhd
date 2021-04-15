----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2020 07:12:36 PM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
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
end EX;

architecture Behavioral of EX is

component ALUmips is
    Port ( IN1 : in STD_LOGIC_VECTOR (15 downto 0);
           IN2 : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           registru: in STD_LOGIC_VECTOR(2 downto 0);
           zero : out STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal AluCtrl: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal zeros : STD_LOGIC;
signal e, si, rezultat: STD_LOGIC_VECTOR(15 DOWNTO 0);
begin
process(ALUSrc)
begin
    case ALUSrc is
        when '0' => si <= RD2;
        when '1' => si <= Ext_Imm;
        end case;
end process;
process(AluOp, func)
begin
    if(AluOp = "000") then 
        if(func = "000") then AluCtrl <= "0000"; --ADUNARE
        elsif (func ="001") then AluCtrl <= "0001"; --SCADERE
        elsif (func ="010") then AluCtrl <= "0010"; --SHIFTARE LOGICA LA DREAPTA
        elsif (func ="011") then AluCtrl <= "0011"; --SHIFTARE LOGICA LA STANGA
        elsif(func ="100") then AluCtrl <= "0100"; --AND
        elsif (func ="101") then AluCtrl <= "0101"; --OR
        elsif( func ="110") then AluCtrl <= "0110"; --XOR
        elsif (func="111") then AluCtrl <= "0111"; --SHIFATRE LOGICA LA DREAPTA CU REGISTRU
        end if;
     elsif(AluOp = "001" ) then AluCtrl <= "0000"; --ADUNARE
     elsif(AluOp= "010" ) then AluCtrl <= "0000"; --ADUNARE
     elsif(AluOp = "011") then AluCtrl <= "0000"; --ADUNARE
     elsif(AluOp ="100") then AluCtrl <= "0001"; --SCADERE (branch);
     elsif(AluOp ="101" ) then AluCtrl <= "0101"; --OR
     elsif (AluOp="110") then AluCtrl <= "0100"; --AND
     elsif(AluOp="111") then AluCtrl <= "1000"; --JUMP
 end if;       
end process;
hgh: ALUmips port map (RD1, si, sa, AluCtrl,registru , zeros, rezultat);
iesire<=AluCtrl;
AdrBranch <= InstrUrm + Ext_Imm;
rez<=rezultat;
Zero<=zeros;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2020 02:10:44 PM
-- Design Name: 
-- Module Name: IC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IC is
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
end IC;

architecture Behavioral of IC is
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
signal  s2, s3, write: std_logic_vector(15 downto 0);
signal s1: std_logic_vector(2 downto 0);
signal aux: STD_LOGIC;
begin

process(RegDst)
begin 
case RegDst is
    when '0' => s1 <= Instr(9 downto 7);
    when '1' => s1 <= Instr (6 downto 4);
 end case;
end process; 

ggg: rf port map (Instr(12 downto 10), Instr(9 downto 7), s1, clk, RegWr, enable, RD1, RD2, wd);
sa<= Instr(3);
func <= Instr(2 downto 0);



process(Instr(6))
begin 
if Instr(6) = '1' then 
    aux <= '1';
    else 
    aux <='0';
end if;
end process;

process(ExtOp)
begin
if(ExtOp = '0' ) then 
    Ext_imm <= "000000000" & Instr(6 downto 0); --extinctie cu 0
  else --extinctie cu semn; 
    if(aux ='0') then 
    Ext_imm <= "000000000" & Instr(6 downto 0);
    elsif(aux='1') then 
    Ext_imm <= "111111111" & Instr(6 downto 0);
    end if;
end if;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2020 12:05:49 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    Port ( ALUrez : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           enable: in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           AluRezout : out STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is
component RAMmips is
    Port ( Alurez : in STD_LOGIC_VECTOR (15 downto 0);
           rd2 : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           clk: in STD_LOGIC;
           enable: in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0) );
end component;

begin
jhj: RAMmips port map (Alurez, rd2,clk, enable, MemWrite, MemData);
Alurezout <= AluRez;

end Behavioral;

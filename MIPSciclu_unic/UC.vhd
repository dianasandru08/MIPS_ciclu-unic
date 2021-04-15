----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2020 03:35:14 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
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
end UC;

architecture Behavioral of UC is

begin
process(Instr)
begin 
RegDst <= '0';
ExtOp<= '0';
ALUSrc <= '0';
Branch <= '0';
Jump<= '0';
ALUOp <= "000";
MemWrite<= '0';
MemtoReg <= '0';
RegWrite<= '0';
case Instr is
    when "000" => RegDst<='1'; RegWrite <='1'; --aici
    when "001" => ExtOp <= '1'; ALUSrc<='1';  RegWrite <='1'; AluOp<="001"; --aici
    when "010" =>  ExtOp <= '1'; ALUSrc<='1'; MemtoReg<='1'; RegWrite <='1'; AluOp <="010"; --aici
    when "011" => ExtOp<='1'; ALUSrc <='1'; MemWrite <= '1'; AluOp <= "011";
    when "100" => Branch <='1';ExtOp <='1';Jump <='0'; AluOp <= "100";
    when "101" => ExtOp <= '0'; ALUSrc <='1'; RegWrite<='1';  AluOp <= "101"; --aici
    when "110" => ExtOp <= '0'; ALUSrc <='1'; RegWrite<='1';  AluOp <= "110"; --aici
    when "111" => Jump <= '1'; AluOp <= "111";
end case;
end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2020 12:37:03 PM
-- Design Name: 
-- Module Name: mpg - Behavioral
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


entity mpg is
   Port (en: out STD_LOGIC;
         btn: in std_logic;
         clk: in std_logic);
end entity mpg;
         

architecture Behavioral of mpg is
signal Q1: STD_LOGIC ;
signal Q2: STD_LOGIC;
signal Q3 : STD_LOGIC ;
signal count_int: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";

begin

en<= Q2 and (not Q3);

process(clk)
begin
if clk'event and clk = '1' then 
count_int <= count_int + 1;
end if;
end process;

process(clk)
begin
if clk'event and clk = '1' then 
if count_int(15 downto 0) = "1111111111111111" then 
Q1<=btn;
end if;
end if;
end process;

process(clk)
begin
if clk'event and clk ='1' then
Q2<=Q1;
Q3<=Q2;
end if;
end process;



end Behavioral;

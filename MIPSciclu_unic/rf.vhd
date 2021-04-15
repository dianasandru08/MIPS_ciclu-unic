----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2020 08:04:18 PM
-- Design Name: 
-- Module Name: rf - Behavioral
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

entity rf is
    Port ( ra1 : in STD_LOGIC_VECTOR (2 downto 0);
           ra2: in STD_LOGIC_VECTOR (2 downto 0);
           wa: in STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           regWr : in STD_LOGIC;
           enable: in STD_LOGIC;
           rd2: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           rd1: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           wd: in STD_LOGIC_VECTOR(15 DOWNTO 0));
end rf;

architecture Behavioral of rf is
type mem is array(0 to 7) of std_logic_vector(15 downto 0);
signal memory : mem := (  "0000000000000001",
                          "0000000000000101",
                          "0000000000000011",
                          "0000000000001000",
                          "0000000000001001",
                          "0000000000000001",
                          "0000000000000010",
                          "0000000000000111" );

begin
process(clk, regWr, enable)
begin
    if enable ='1' then
         if clk'event and clk= '1' then 
            if regWr = '1' then 
                memory(conv_integer(wa)) <= wd;
            end if;
         end if;
    end if;
end process;

rd1 <= memory (conv_integer(ra2));
rd2 <= memory (conv_integer(ra1));



end Behavioral;

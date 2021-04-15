----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2020 11:46:39 AM
-- Design Name: 
-- Module Name: RAMmips - Behavioral
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

entity RAMmips is
    Port ( Alurez : in STD_LOGIC_VECTOR (15 downto 0);
           rd2 : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           clk: in STD_LOGIC;
           enable: in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0) );
end RAMmips;

architecture Behavioral of RAMmips is
type mem_type is array(0 to 15) of std_logic_vector(15 downto 0);
signal memory : mem_type := ("0000000000001111", "0000000011111111",
                         "0000000000000000", "0000000000000101", 
                         "0000000000000001", "0000000000000111", 
                          "0000000000000010", "0000000000001001",
                          "0000000000000001", "0000000000001101",
                          "0000000000000010", "0000000000001000",
                          "0000000000001011", "0000000000010000",
                          others => "0000000000000000" );

begin
process(clk, enable)
begin 
    if(enable ='1') then 
        if(clk='1' and clk'event) then 
         if(MemWrite ='1') then 
            memory(conv_integer(Alurez)) <= rd2;
         end if;
       end if;
     end if;          
end process;
MemData <= memory(conv_integer(ALurez));

end Behavioral;

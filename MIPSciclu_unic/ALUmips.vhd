----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2020 07:49:06 PM
-- Design Name: 
-- Module Name: ALUmips - Behavioral
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

entity ALUmips is
    Port ( IN1 : in STD_LOGIC_VECTOR (15 downto 0);
           IN2 : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           registru: in STD_LOGIC_VECTOR(2 downto 0);
           zero : out STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (15 downto 0));
end ALUmips;

architecture Behavioral of ALUmips is
signal zerosignal: std_logic;
begin

process(sel)
begin
    case sel is
        when "0000" => rez <= IN1 + IN2; 
        when "0001" => rez <= IN1 - IN2;
                        if(IN1- IN2 = 0 ) then 
                            zero <='1';
                        end if;
        when "0010" => if(sa ='1') then 
                            rez <= '0' & IN1(15 downto 1);
                       else
                            rez <= IN1;
                       end if;

        when "0011" => if(sa ='1') then 
                            rez <=  IN1(14 downto 0) & '0' ;
                       else
                            rez <= IN1;
                       end if;
        when "0100" => rez <= IN1 and IN2;
        when "0101" => rez <= IN1 or IN2;
        when "0110" => rez<= IN1 xor IN2;
        when "0111" => if(registru ="000") then rez <= IN1;
                       elsif(registru="001") then rez<= '0' & IN1(15 downto 1);
                       elsif(registru="010") then rez<= "00" & IN1(15 downto 2);
                       elsif(registru ="011") then rez <= "000" & IN1(15 downto 3);
                       elsif(registru ="100") then rez <= "0000" & IN1(15 downto 4);
                       elsif(registru="101") then rez <= "00000" & IN1(15 downto 5);
                       elsif(registru="110") then rez<="000000" & IN1(15 downto 6);
                       elsif(registru="111") then rez<="0000000" & IN1(15 downto 7);
                       end if;
       when "1000" => rez <= IN1 + IN2;
       when others => rez <= "0000000000000000";
  end case;
end process;
zero<=zerosignal;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2020 01:41:50 PM
-- Design Name: 
-- Module Name: InstructionFetch - Behavioral
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

entity InstructionFetch is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           adrBranch : in STD_LOGIC_VECTOR (15 downto 0);
           adrJump : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCsrc : in STD_LOGIC;
           adrUrm : out STD_LOGIC_VECTOR (15 downto 0);
           Instr : out STD_LOGIC_VECTOR (15 downto 0));
end InstructionFetch;

architecture Behavioral of InstructionFetch is
type rom_type is array(0 to 65535) of std_logic_vector(15 downto 0);
signal rom : rom_type := (
                          b"011_001_001_0000001", --sw $1, 1($1)
                          b"010_001_000_0000001", -- ld $0, 1($1) --RF[0]=5
                          b"000_000_101_101_0_001", -- sub $5, $0, $5 --RF[5]=4
                          b"000_101_110_111_0_100", --and $7, $5, $6 --RF[7]=0
                          b"000_001_010_100_0_101", --or $4,$1, $2 --RF[4]=7
                          b"001_000_001_0000011", --addi $1, $0, 3 --RF[1]=8
                          b"100_000_100_0000101", --beq $0, $4, 3 --if(RF[0] == RF[4]) jump instructiune 12
                          b"001_000_000_0000001", --addi $0, $0, 1 --RF[0] = RF[0]+1
                          b"000_001_000_100_1_101", --or $4, $1, $0 --RF[4]=E
                          b"000_010_011_001_1_010", --slr $1, $2, 1 --
                          b"000_001_001_010_0_011", --sll $2, $1,0
                          b"111_0_0000_0000_0110", --jump la instructiunea 6
                          b"000_001_111_101_0_110", --xor $0, $1, $7
                          others => "0000000000000000" );

signal pcin: std_logic_vector(15 downto 0);
signal pcout: std_logic_vector(15 downto 0);
signal pc1: std_logic_vector(15 downto 0);
signal pcmux1: std_logic_vector(15 downto 0);
signal rez: std_logic_vector(15 downto 0);
begin

process(clk, reset, enable)
begin
if (reset = '1') then pcout <= (others => '0');
elsif  (enable ='1') then
        if   (clk'event and clk = '1') then 
        pcout <= pcin;  
        end if;

end if;
end process;

process(PCsrc)
begin 
    case PCsrc is
    when '0' => pcmux1 <= pc1;
    when '1' => pcmux1 <=adrBranch;
    end case;
end process; 
process(Jump)
begin 
    case Jump is
    when '0' => pcin <= pcmux1;
    when '1' => pcin <= adrJump;
    end case;
end process;


pc1 <= pcout +1;
Instr <= rom(conv_integer(pcout));
adrUrm <= pc1;
end Behavioral;

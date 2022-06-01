----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/02 00:47:22
-- Design Name: 
-- Module Name: towords - Behavioral
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

entity towords is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           forword : in STD_LOGIC;
           backword : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : in STD_LOGIC;
           A_out : out STD_LOGIC;
           B_out : out STD_LOGIC;
           C_out : out STD_LOGIC;
           D_out : out STD_LOGIC);
end towords;

architecture Behavioral of towords is
signal toword, toword_next, channel:std_logic;
begin
channel <= (not forword) and backword;        -- 01
process(clk, reset)
begin
    if reset = '1' then
        toword <= '0';
    elsif rising_edge(clk) then
        toword <= toword_next;
    end if;
end process;

process(toword, toword_next, A, B, C, D, forword, backword)
begin
    toword_next <= toword;
    if forword = '1' then
        toword_next <= '0';
    end if;
    if backword = '1' then
        toword_next <= '1';
    end if;
    if toword = '1' then
        A_out <= D;
        B_out <= C;
        C_out <= B;
        D_out <= A;
    else 
        A_out <= A;
        B_out <= B;
        C_out <= C;
        D_out <= D;
    end if;
end process;

end Behavioral;

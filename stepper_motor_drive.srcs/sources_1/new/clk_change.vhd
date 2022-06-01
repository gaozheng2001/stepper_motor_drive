----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/31 20:45:50
-- Design Name: 
-- Module Name: clk_change - Behavioral
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

entity clk_change is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           upcount : in integer;
           clkout : out STD_LOGIC);
end clk_change;

architecture Behavioral of clk_change is
signal count:integer;
begin
process(clk, reset)
begin
    if reset = '1' then
        count <= 0;
        clkout <= '0';
    elsif rising_edge(clk) then
        if count = upcount then
            count <= 0;
            clkout <= '1';
        else 
            count <= count + 1;
            clkout <= '0';
        end if;
    end if;
end process;

end Behavioral;

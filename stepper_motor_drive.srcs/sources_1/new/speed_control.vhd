----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/20 14:17:00
-- Design Name: 
-- Module Name: speed_control - Behavioral
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
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity speed_control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           up_fleg : in STD_LOGIC;
           up_state : in STD_LOGIC;
           down_fleg : in STD_LOGIC;
           down_state : in STD_LOGIC;
           speed : out STD_LOGIC_VECTOR (3 downto 0));
end speed_control;

architecture Behavioral of speed_control is
signal speed_temp: std_logic_vector(3 downto 0):="1000";
signal up, down: std_logic;
function speedcount(speed_temp:std_logic_vector(3 downto 0); mode:std_logic)return std_logic_vector is
begin
    if mode = '1' then
        if speed_temp = "1111" then
            return speed_temp;
        else
            return speed_temp + '1';
        end if;
    elsif mode = '0' then
        if speed_temp = "0000" then
            return speed_temp;
        else
            return speed_temp - '1';
        end if;
    end if;
end speedcount;
begin
up <= up_fleg and (not up_state);
down <= down_fleg and (not down_state);
process(clk)
begin
    if reset = '1' then
        speed_temp <= "1000";
    elsif rising_edge(clk) then
        if up = '1' then
            speed_temp <= speedcount(speed_temp, '1') ;
        elsif down = '1' then
            speed_temp <= speedcount(speed_temp, '0');
        end if;
    end if;
end process;
speed <= speed_temp;
end Behavioral;

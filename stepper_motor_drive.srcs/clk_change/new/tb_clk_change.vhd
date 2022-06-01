----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/31 20:51:57
-- Design Name: 
-- Module Name: tb_clk_change - Behavioral
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

entity tb_clk_change is
--  Port ( );
end tb_clk_change;

architecture Behavioral of tb_clk_change is
    component clk_change
    port(
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        upcount : in integer;
        clkout : out STD_LOGIC
    );
    end component;
    
    signal clk: std_logic:='0';
    signal reset: std_logic:='0';
    signal upconut:integer:=30;
    
    signal clkout: std_logic:='0';
    
    constant per: time:= 10 ns;
    
begin
uut:clk_change 
port map(
clk => clk,
reset => reset,
upcount => upconut,
clkout => clkout
);

clk_pro: process
begin
    clk <= '1';
    wait for per/2;
    clk <= '0';
    wait for per/2;
end process;

reset_pro: process
begin
    reset <= '1';
    for i in 1 to 2 loop
        wait for per;
    end loop;
    reset <= '0';
    wait;
end process;
end Behavioral;
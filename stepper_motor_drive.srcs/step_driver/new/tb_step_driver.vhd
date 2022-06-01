----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/02 01:07:26
-- Design Name: 
-- Module Name: tb_step_driver - Behavioral
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

entity tb_step_driver is
--  Port ( );
end tb_step_driver;

architecture Behavioral of tb_step_driver is
    component step_driver is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           speed : in std_logic_vector(3 downto 0);
           forword : in STD_LOGIC;
           backword : in STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           C : out STD_LOGIC;
           D : out STD_LOGIC);
    end component;
    
    signal clk: std_logic:='0';
    signal reset: std_logic:='0';
    signal forword: std_logic:='0';
    signal backword: std_logic:='0';
    signal A, B, C, D: std_logic:='0';
    signal speed: std_logic_vector(3 downto 0):="0000";
    
    constant per: time:= 10 ns;

begin
uut: step_driver
port map(
    clk => clk,
    reset => reset,
    speed => speed,
    forword => forword,
    backword => backword,
    A => A,
    B => B,
    C => C,
    D => D
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

process
begin 
    wait for 10*per;
    backword <= '1';
    wait for per;
    backword <= '0';
    wait;
end process;

end Behavioral;

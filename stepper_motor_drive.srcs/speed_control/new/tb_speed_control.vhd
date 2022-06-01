----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/23 16:17:05
-- Design Name: 
-- Module Name: tb_speed_control - Behavioral
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

entity tb_speed_control is
--  Port ( );
end tb_speed_control;

architecture Behavioral of tb_speed_control is
    component speed_control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           up_fleg : in STD_LOGIC;
           up_state : in STD_LOGIC;
           down_fleg : in STD_LOGIC;
           down_state : in STD_LOGIC;
           speed : out STD_LOGIC_VECTOR (3 downto 0)
           );
    end component;
    
    signal clk: std_logic:='0';
    signal reset: std_logic:='0';
    signal up_fleg: std_logic:='0';
    signal up_state: std_logic:='1';
    signal down_fleg: std_logic:='0';
    signal down_state: std_logic:='1';
    
    signal speed: std_logic_vector(3 downto 0);
    
    constant per: time:= 10 ns;
    
begin
uut: speed_control
port map(
    clk => clk,
    reset => reset,
    up_fleg => up_fleg,
    up_state => up_state,
    down_fleg => down_fleg,
    down_state => down_state,
    speed => speed
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

    wait for 5*per;
    for i in 1 to 10 loop
        up_fleg <= '1';
        up_state <= '0';
        wait for per;
        up_fleg <= '0';
        wait for 100*per;
        up_state <= '1';
        wait for 100*per;
    end loop;
    wait for 5*per;
    reset <= '1';
    wait for 5*per;
    reset <= '0';

    wait for 5*per;
    for i in 1 to 10 loop
        down_fleg <= '1';
        down_state <= '0';
        wait for per;
        down_fleg <= '0';
        wait for 200*per;
        down_state <= '1';
    end loop;
end process;

end Behavioral;

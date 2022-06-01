----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/08 17:32:12
-- Design Name: 
-- Module Name: tb_key_filter - Behavioral
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

entity tb_key_filter is
--  Port ( );
end tb_key_filter;

architecture Behavioral of tb_key_filter is
    component key_filter
    port(
        clk : in STD_LOGIC;
        reset: in std_logic;
        keyin : in STD_LOGIC;
        key_fleg : out STD_LOGIC;
        key_state: out std_logic
    );
    end component;

    signal clk: std_logic:='0';
    signal reset: std_logic:='0';
    signal keyin:std_logic:='0';
    
    signal key_fleg: std_logic:='0';
    signal key_state: std_logic:='0';
    
    constant per: time:= 10 ns;
    
begin
uut: key_filter
port map(
    clk => clk,
    reset => reset,
    keyin => keyin,
    key_fleg => key_fleg,
    key_state => key_state
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

keyin_pro: process
begin
    keyin <= '1';
    wait for 3*per;
    keyin <= '0';
    wait for 3*per;
    keyin <= '1';
    wait for 2*per;
    keyin <= '0';
    wait for 3*per;
    keyin <= '1';
    wait for 2*per;
    keyin <= '0';
    wait for 3*per;
    keyin <= '1';
    wait for 2*per;
    keyin <= '0';
    wait for 800*per;
    
    keyin <= '1';
    wait for 500*per;
    keyin <= '0';
    wait for 3*per;
    keyin <= '1';
    wait for 2*per;
    keyin <= '0';
    wait for 3*per;
    keyin <= '1';
    wait for 2*per;
    keyin <= '0';
    wait for 3*per;
    keyin <= '1';
    wait for 2*per;
    keyin <= '0';
    wait for 10*per;
    
    keyin <= '1';
    wait for 100*per;
    
    keyin <= '0';
    wait for 50*per;
end process;

end Behavioral;

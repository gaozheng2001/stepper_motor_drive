----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/02 01:44:36
-- Design Name: 
-- Module Name: tb_towords - Behavioral
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

entity tb_towords is
--  Port ( );
end tb_towords;

architecture Behavioral of tb_towords is
    component towords is
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
    end component;
    
    signal clk: std_logic:='0';
    signal reset: std_logic:='0';
    signal forword: std_logic:='0';
    signal backword: std_logic:='0';
    signal A, B, C, D: std_logic:='0';
    
    signal A_out, B_out, C_out, D_out: std_logic:='0';
    
    constant per: time:= 10 ns;
    
begin
toword_pro:towords
port map(
    clk => clk,
    reset => reset,
    forword => forword,
    backword => backword,
    A => A,
    B => B,
    C => C,
    D => D,
    A_out => A_out,
    B_out => B_out,
    C_out => C_out,
    D_out => D_out
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
    A <= '1';
    B <= '0';
    C <= '0';
    D <= '0';
    wait for per;
    A <= '0';
    B <= '1';
    C <= '0';
    D <= '0';
    wait for per;
    A <= '0';
    B <= '0';
    C <= '1';
    D <= '0';
    wait for per;
    A <= '0';
    B <= '0';
    C <= '0';
    D <= '1';
    wait for per;
end process;
process
begin 
    forword <= '1';
    wait for per;
    forword <= '0';
    backword <= '0';
    wait for 7*per;
    backword <= '1';
    wait for per;
    forword <= '0';
    backword <= '0';
    wait for 7*per;
end process;

end Behavioral;

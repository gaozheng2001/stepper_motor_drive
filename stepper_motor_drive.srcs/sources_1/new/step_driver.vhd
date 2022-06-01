----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/31 20:31:19
-- Design Name: 
-- Module Name: step_driver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity step_driver is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           speed : in std_logic_vector(3 downto 0);
           forword : in STD_LOGIC;
           backword : in STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           C : out STD_LOGIC;
           D : out STD_LOGIC);
end step_driver;

architecture Behavioral of step_driver is
component clk_change is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           upcount : in integer;
           clkout : out STD_LOGIC);
end component;

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

signal dt, cnt:integer;
signal clkout, A_temp, B_temp, C_temp, D_temp: std_logic;
signal channels:std_logic_vector(1 downto 0):="00";


begin
--dt <= to_integer(unsigned(speed))*4000 + 20000;
dt <= to_integer(unsigned(speed))*40 + 20;

clk_change_pro: clk_change
port map(
    clk => clk,
    reset => reset,
    upcount => dt,
    clkout => clkout
);
process(clk, reset)
begin
    if reset = '1' then
        cnt <= 0;
    elsif rising_edge(clk) then
        if clkout = '1' then
            if cnt = dt/4 then
                cnt <= 0;
                channels <= channels + 1;
            else 
                cnt <= cnt + 1;
            end if;
        end if;
    end if;
end process;

process(channels)
begin
    A_temp <= '0';
    B_temp <= '0';
    C_temp <= '0';
    D_temp <= '0';
    case channels is
    when "00" => 
        A_temp <= '1';
    when "01" => 
        B_temp <= '1';
    when "10" => 
        C_temp <= '1';
    when "11" => 
        D_temp <= '1';
    when others => 
    end case;
end process;

toword_pro:towords
port map(
    clk => clk,
    reset => reset,
    forword => forword,
    backword => backword,
    A => A_temp,
    B => B_temp,
    C => C_temp,
    D => D_temp,
    A_out => A,
    B_out => B,
    C_out => C,
    D_out => D
);

end Behavioral;

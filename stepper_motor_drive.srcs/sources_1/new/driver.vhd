----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/02 02:19:17
-- Design Name: 
-- Module Name: driver - Behavioral
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

entity driver is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           keyup : in STD_LOGIC;
           keydown : in STD_LOGIC;
           keyfor : in STD_LOGIC;
           keyback : in STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           C : out STD_LOGIC;
           D : out STD_LOGIC);
end driver;

architecture Behavioral of driver is
    component key_towords is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           key0 : in STD_LOGIC;
           key1 : in STD_LOGIC;
           forword : out STD_LOGIC;
           backword : out STD_LOGIC);
    end component;
    
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
    
    component speed is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           keyup : in STD_LOGIC;
           keydown : in STD_LOGIC;
           speed : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal forword, backword:std_logic;
    signal speed_temp:std_logic_vector(3 downto 0);
    
begin
key_towords_pro:key_towords
port map(
    clk => CLK,
    reset => RESET,
    key0 => keyfor,
    key1 => keyback,
    forword => forword,
    backword => backword
);

speed_pro:speed
port map(
    CLK => CLK,
    RESET => RESET,
    keyup => keyup,
    keydown => keydown,
    speed => speed_temp
);

step_driver_pro: step_driver
port map(
    clk => CLK,
    reset => RESET,
    speed => speed_temp,
    forword => forword,
    backword => backword,
    A => A,
    B => B,
    C => C,
    D => D
);

end Behavioral;

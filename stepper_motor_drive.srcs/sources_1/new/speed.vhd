----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/23 16:52:58
-- Design Name: 
-- Module Name: speed - Behavioral
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

entity speed is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           keyup : in STD_LOGIC;
           keydown : in STD_LOGIC;
           speed : out STD_LOGIC_VECTOR (3 downto 0));
end speed;

architecture Behavioral of speed is
    component key_filter is
    Port ( clk : in STD_LOGIC;
           reset: in std_logic;
           keyin : in STD_LOGIC;
           key_fleg : out STD_LOGIC;
           key_state: out std_logic);
    end component;

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
    
    signal up_fleg, up_state, down_fleg, down_state:std_logic;
    
begin
up_pro: key_filter
port map(
    clk => CLK,
    reset => RESET,
    keyin => keyup,
    key_fleg => up_fleg,
    key_state => up_state
);

down_pro: key_filter
port map(
    clk => CLK,
    reset => RESET,
    keyin => keydown,
    key_fleg => down_fleg,
    key_state => down_state
);

speed_control_pro:speed_control
port map(
    clk => CLK,
    reset => RESET,
    up_fleg => up_fleg,
    up_state => up_state,
    down_fleg => down_fleg,
    down_state => down_state,
    speed => speed
);
end Behavioral;

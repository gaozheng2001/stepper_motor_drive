----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/02 02:13:33
-- Design Name: 
-- Module Name: key_towords - Behavioral
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

entity key_towords is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           key0 : in STD_LOGIC;
           key1 : in STD_LOGIC;
           forword : out STD_LOGIC;
           backword : out STD_LOGIC);
end key_towords;

architecture Behavioral of key_towords is
    component key_filter is
    Port ( clk : in STD_LOGIC;
           reset: in std_logic;
           keyin : in STD_LOGIC;
           key_fleg : out STD_LOGIC;
           key_state: out std_logic);
    end component;

    signal for_fleg, for_state, back_fleg, back_state:std_logic;

begin
forword_pro: key_filter
port map(
    clk => CLK,
    reset => RESET,
    keyin => key0,
    key_fleg => for_fleg,
    key_state => for_state
);

backword_pro: key_filter
port map(
    clk => CLK,
    reset => RESET,
    keyin => key1,
    key_fleg => back_fleg,
    key_state => back_state
);
forword <= for_fleg and (not for_state);
backword <= back_fleg and (not back_state);

end Behavioral;

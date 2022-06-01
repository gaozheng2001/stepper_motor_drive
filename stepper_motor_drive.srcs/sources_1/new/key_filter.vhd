----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/05/08 16:58:38
-- Design Name: 
-- Module Name: key_filter - Behavioral
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

entity key_filter is
    Port ( clk : in STD_LOGIC;
           reset: in std_logic;
           keyin : in STD_LOGIC;
           key_fleg : out STD_LOGIC;
           key_state: out std_logic);
end key_filter;

architecture Behavioral of key_filter is
type state_type is(idle,wait_low_20ms, low_stable, wait_high_stable);
signal state, state_next: state_type;
signal key_tem, key_pre, key_a, key_b, encount, risekey, fallkey: std_logic;
signal count: integer range 0 to 256;
signal countup: integer:=200;
begin
clk_pro: process(clk)
begin
    if reset = '1' then
        key_a <= '1';
        key_b <= '1';
        state <= idle;
        count <= 0;
    elsif rising_edge(clk) then
        state <= state_next;
        key_a <= keyin;
        key_b <= key_a;
        if encount = '1' then
            if count = countup then
                count <= 0;
            else
                count <= count + 1;
            end if;
        else
            count <= 0;
        end if;
    end if;
end process;

process(clk)
begin
    if reset = '1' then
        key_pre <= '0';
        key_tem <= '0';
    elsif rising_edge(clk) then
        key_tem <= key_b;
        key_pre <= key_tem;
    end if;
end process;

risekey <= key_tem and (not key_pre);
fallkey <= (not key_tem) and key_pre;

process(state, state_next, count, encount, risekey, fallkey)
begin
    case state is
    when idle => 
        key_fleg <= '0';
        key_state <= '1';
        if fallkey = '1' then
            encount <= '1';
            state_next <= wait_low_20ms;
        end if;
    when wait_low_20ms => 
        if count = countup then
            encount <= '0';
            state_next <= low_stable;
            key_fleg <= '1';
            key_state <= '0';
        else if risekey = '1' then
                state_next <= idle;
                encount <= '0';
            end if;
        end if;
    when low_stable => 
        key_fleg <= '0';
        if risekey = '1' then
            encount <= '1';
            state_next <= wait_high_stable;
        else
            state_next <= low_stable;
        end if;
    when wait_high_stable => 
        if count = countup then
            encount <= '0';
            state_next <= idle;
            key_fleg <= '1';
            key_state <= '1';
        elsif fallkey = '1' then
            state_next <= low_stable;
            encount <= '0';
        end if;
    end case;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2024 21:32:45
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divider is
    Port ( clk : in STD_LOGIC;
           clk_m : out STD_LOGIC; -- 10kHz
           clk_t : out STD_LOGIC); -- 100kHz
end clock_divider;

architecture Behavioral of clock_divider is

signal counter_m, counter_t : integer := 1;
signal tmp_m, tmp_t : std_logic := '0';

begin

process(clk)
begin
    if(rising_edge(clk)) then
        counter_m <= counter_m + 1;
        counter_t <= counter_t + 1;
        if(counter_m = 10000) then
            tmp_m <= NOT tmp_m;
            counter_m <= 1;
        end if;
        if(counter_t = 1000) then
            tmp_t <= NOT tmp_t;
            counter_t <= 1;
        end if;
    end if;
end process;

clk_m <= tmp_m;
clk_t <= tmp_t;

end Behavioral;

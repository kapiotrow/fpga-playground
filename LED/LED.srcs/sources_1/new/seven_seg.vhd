----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2024 17:14:24
-- Design Name: 
-- Module Name: seven_seg - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_seg is
  Port (
        clk : in std_logic;
        displayed_number: in std_logic_vector (15 downto 0);
        anode : out std_logic_vector (3 downto 0);
        segment : out std_logic_vector (6 downto 0));
end seven_seg;

architecture Behavioral of seven_seg is

signal LED_BCD: std_logic_vector (3 downto 0);
signal refresh_counter: std_logic_vector (19 downto 0);
-- counter to create a refresh period
signal part_counter: std_logic_vector (1 downto 0);
-- counter to choose between the four parts of the display
begin

-- code to display a certain number
process(LED_BCD)
begin
    case LED_BCD is
        when "0000" => segment <= "0000001";
        when "0001" => segment <= "1001111";
        when "0010" => segment <= "0010010";
        when "0011" => segment <= "0000110";
        when "0100" => segment <= "1001100";
        when "0101" => segment <= "0100100";
        when "0110" => segment <= "0100000";
        when "0111" => segment <= "0001111";
        when "1000" => segment <= "0000000";
        when "1001" => segment <= "0000100";
        when others => segment <= "1111110";
    end case;
end process;

-- code to update the refresh counter
process(clk)
begin
    if(refresh_counter >= "11111111111111111111") then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clk)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;

part_counter <= refresh_counter(19 downto 18);

-- displaying a certain part of the displayed number
-- on a certain part of the display
process(part_counter)
begin
    case part_counter is
        when "00" => 
            anode <= "0111";
            LED_BCD <= displayed_number(15 downto 12);
        when "01" =>
            anode <= "1011";
            LED_BCD <= displayed_number(11 downto 8);
        when "10" => 
            anode <= "1101";
            LED_BCD <= displayed_number(7 downto 4);
        when "11" =>
            anode <= "1110";
            LED_BCD <= displayed_number(3 downto 0);
    end case;
end process;

end Behavioral;
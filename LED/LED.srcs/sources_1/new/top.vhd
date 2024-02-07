----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.02.2024 15:53:30
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
          clk : in std_logic;
          sw : in std_logic_vector (15 downto 0);
          an : out std_logic_vector (3 downto 0);
          seg : out std_logic_vector (6 downto 0)
          );
end top;

architecture Behavioral of top is

signal displayed_number_sig : std_logic_vector (15 downto 0);

component switches
    Port (
          sw_in : in std_logic_vector (15 downto 0);
          number : out std_logic_vector (15 downto 0));
end component;

component seven_seg
    Port (
          clk : in std_logic;
          displayed_number: in std_logic_vector (15 downto 0);
          anode : out std_logic_vector (3 downto 0);
          segment : out std_logic_vector (6 downto 0));
end component;

begin
switches_module : switches Port map (sw_in => sw, number => displayed_number_sig);
seven_seg_module : seven_seg Port map (clk => clk, 
                                       displayed_number => displayed_number_sig,
                                       anode => an,
                                       segment => seg);

end Behavioral;

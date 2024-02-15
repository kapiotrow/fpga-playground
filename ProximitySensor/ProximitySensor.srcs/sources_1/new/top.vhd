----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.02.2024 16:45:07
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
    Port ( clk : in STD_LOGIC;
           JA : inout std_logic_vector (1 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

-- signal to pass the value of the distance
-- from the proximity sensor component
-- to the seven sgment display component
signal distance_to_display : std_logic_vector (15 downto 0);
signal measurement_refresh_counter : std_logic_vector (13 downto 0);
signal clk_m : std_logic;
signal clk_t : std_logic;

-- seven segment display component declaration
component seven_seg 
    Port (
          clk : in std_logic;
          displayed_number: in std_logic_vector (15 downto 0);
          anode : out std_logic_vector (3 downto 0);
          segment : out std_logic_vector (6 downto 0));
end component;

-- proximity sensor component declaration
component prox_sensor
    Port (
          clk_m : in std_logic; 
          clk_t : int std_logic;
          echo : in std_logic;
          trig : out std_logic;
          distance : out std_logic_vector (15 downto 0));
end component;

component clock_divider
    Port (
          clk: in std_logic;
          clk_m : out std_logic; -- 10kHz clock
          clk_t : out std_logic -- 100kHz clock
          );
end component;

begin

-- initialization of component instances
seven_seg_module : seven_seg Port map (clk => clk,
                                       displayed_number => distance_to_display,
                                       anode => an,
                                       segment => seg);

prox_sensor_module : prox_sensor Port map (clk_m => clk_m,
                                           clk_t => clk_t,
                                           echo => JA(1),
                                           trig => JA(0),
                                           distance => distance_to_display);

clock_divider_module : clock_divider Port map (clk => clk,
                                               clk_m => clk_m,
                                               clk_t => clk_t);
                                           
process(clk)
begin
    -- 
end process;

end Behavioral;

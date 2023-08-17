----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2023 07:36:45 PM
-- Design Name: 
-- Module Name: D_FF_7bit - Behavioral
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

entity D_FF_7bit is
    Port ( D : in STD_LOGIC_VECTOR(6 downto 0);
           Res, En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(6 downto 0));
end D_FF_7bit;

architecture Behavioral of D_FF_7bit is

begin
    process (Clk) begin
        if (rising_edge(clk)) then
            if En = '1' then
                if Res = '1' then 
                    Q <= "0000000";
                else
                    Q <= D;
                end if;
            end if;
        end if;
    end process;


end Behavioral;

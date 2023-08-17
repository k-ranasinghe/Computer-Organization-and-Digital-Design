----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2023 05:43:05 AM
-- Design Name: 
-- Module Name: AdderSubtracter - Behavioral
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

entity AdderSubtracter is
    Port ( A,B : in STD_LOGIC_VECTOR(6 downto 0);
           C_in, Ctrl : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR(6 downto 0);
           C_out, Zero, Overflow : out STD_LOGIC);
end AdderSubtracter;

architecture Behavioral of AdderSubtracter is
    component FA
        port(
        A : in std_logic;
        B : in std_logic;
        C_in : in std_logic;
        S : out std_logic;
        C_out : out std_logic);
    end component;
    
    SIGNAL FA_C, FA_S, T : std_logic_vector(6 downto 0);
    SIGNAL N : std_logic;
    
begin       
    process(Ctrl, B)
        begin             
            case Ctrl is
                when '1' => T <= NOT B;
                when '0' => T <= B;
                when others => T <= "UUUUUUU";
            end case;       
        end process; 
    
    FA_0 :FA
        PORT MAP(
            A => A(0),
            B => T(0),  
            C_in => Ctrl,
            S => FA_S(0),
            C_Out => FA_C(0));
            
    FA_1 :FA
        PORT MAP(
            A => A(1),
            B => T(1),
            C_in => FA_C(0),
            S => FA_S(1),
            C_Out => FA_C(1));
            
    FA_2 :FA
        PORT MAP(
            A => A(2),
            B => T(2),
            C_in => FA_C(1),
            S => FA_S(2),
            C_Out => FA_C(2));

    FA_3 :FA
        PORT MAP(
            A => A(3),
            B => T(3),
            C_in => FA_C(2),
            S => FA_S(3),
            C_Out => FA_C(3));

    FA_4 :FA
        PORT MAP(
            A => A(4),
            B => T(4),
            C_in => FA_C(3),
            S => FA_S(4),
            C_Out => FA_C(4));
            
    FA_5 :FA
        PORT MAP(
            A => A(5),
            B => T(5),
            C_in => FA_C(4),
            S => FA_S(5),
            C_Out => FA_C(5));

    FA_6 :FA
        PORT MAP(
            A => A(6),
            B => T(6),
            C_in => FA_C(5),
            S => FA_S(6),
            C_Out => FA_C(6));    
    S <= FA_S;
    C_out <= FA_C(6);

    N <= NOT (A(6) XOR B(6)) AND (NOT Ctrl) AND FA_C(6);      
    Overflow <= A(6) AND T(6); 
    
    process(FA_S)
            begin
                if FA_S = "0000000" AND N = '0' then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
            end process; 
end Behavioral;


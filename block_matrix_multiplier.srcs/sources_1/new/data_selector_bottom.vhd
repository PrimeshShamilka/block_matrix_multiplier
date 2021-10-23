----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/07/2021 11:22:17 PM
-- Design Name: 
-- Module Name: data_selector_bottom - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_selector_bottom is
  Port (clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        A_b, B_b: in unsigned(127 downto 0);
        A_b_b, B_b_b: out unsigned(31 downto 0);
        done: out std_logic
        );
end data_selector_bottom;

architecture Behavioral of data_selector_bottom is

type sub1 is array (0 to 3) of unsigned (7 downto 0);
type mat_type1 is array (0 to 3) of sub1;
signal mat_Ab, mat_Bb: mat_type1 := (others => (others => X"00")); 
type sub2 is array (0 to 1) of unsigned (7 downto 0);
type mat_type2 is array (0 to 1) of sub2;
signal mat_Abb, mat_Bbb: mat_type2 := (others => (others => X"00"));
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
signal state: state_type:= s0;

begin

--process(clk)
--begin
--    if rising_edge(clk) then
--        for i in 0 to 3 loop
--            for j in 0 to 3 loop
--                  mat_Ab(i)(j) <= A_b((i*4+j+1)*8-1 downto (i*4+j)*8);
--                  mat_Bb(i)(j) <= B_b((i*4+j+1)*8-1 downto (i*4+j)*8);
--            end loop;
--        end loop;
--     end if;
--end process;


FSM: process(clk, reset)
begin
  if (reset = '1') then
    state <= s0;
    mat_Ab <= (others => (others => X"00")); 
    mat_Bb <= (others => (others => X"00"));
         
    elsif rising_edge(clk) then

        case state is
            when s0 =>
                -- convert 1D array to 2D array
                for i in 0 to 3 loop
                for j in 0 to 3 loop
                        mat_Ab(i)(j) <= A_b((i*4+j+1)*8-1 downto (i*4+j)*8);
                        mat_Bb(i)(j) <= B_b((i*4+j+1)*8-1 downto (i*4+j)*8);
                end loop;
                end loop;
                state <= s1;
        
            when s1 => -- output A11, B11
                mat_Abb(0)(0) <= mat_Ab(0)(0);
                mat_Abb(0)(1) <= mat_Ab(0)(1);
                mat_Abb(1)(0) <= mat_Ab(1)(0);
                mat_Abb(1)(1) <= mat_Ab(1)(1);
            
                mat_Bbb(0)(0) <= mat_Bb(0)(0);
                mat_Bbb(0)(1) <= mat_Bb(0)(1);
                mat_Bbb(1)(0) <= mat_Bb(1)(0);
                mat_Bbb(1)(1) <= mat_Bb(1)(1);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s2;

            when s2 => -- output A12, B13
                mat_Abb(0)(0) <= mat_Ab(0)(2);
                mat_Abb(0)(1) <= mat_Ab(0)(3);
                mat_Abb(1)(0) <= mat_Ab(1)(2);
                mat_Abb(1)(1) <= mat_Ab(1)(3);
            
                mat_Bbb(0)(0) <= mat_Bb(2)(0);
                mat_Bbb(0)(1) <= mat_Bb(2)(1);
                mat_Bbb(1)(0) <= mat_Bb(3)(0);
                mat_Bbb(1)(1) <= mat_Bb(3)(1);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s3;    
            
            when s3 => -- output A11, B12
                mat_Abb(0)(0) <= mat_Ab(0)(0);
                mat_Abb(0)(1) <= mat_Ab(0)(1);
                mat_Abb(1)(0) <= mat_Ab(1)(0);
                mat_Abb(1)(1) <= mat_Ab(1)(1);
            
                mat_Bbb(0)(0) <= mat_Bb(0)(2);
                mat_Bbb(0)(1) <= mat_Bb(0)(3);
                mat_Bbb(1)(0) <= mat_Bb(1)(2);
                mat_Bbb(1)(1) <= mat_Bb(1)(3);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s4;    
                
            when s4 => -- output A12, B14
                mat_Abb(0)(0) <= mat_Ab(0)(2);
                mat_Abb(0)(1) <= mat_Ab(0)(3);
                mat_Abb(1)(0) <= mat_Ab(1)(2);
                mat_Abb(1)(1) <= mat_Ab(1)(3);
            
                mat_Bbb(0)(0) <= mat_Bb(2)(2);
                mat_Bbb(0)(1) <= mat_Bb(2)(3);
                mat_Bbb(1)(0) <= mat_Bb(3)(2);
                mat_Bbb(1)(1) <= mat_Bb(3)(3);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s5;       
                
            when s5 => -- output A13, B11
                mat_Abb(0)(0) <= mat_Ab(2)(0);
                mat_Abb(0)(1) <= mat_Ab(2)(1);
                mat_Abb(1)(0) <= mat_Ab(3)(0);
                mat_Abb(1)(1) <= mat_Ab(3)(1);
            
                mat_Bbb(0)(0) <= mat_Bb(0)(0);
                mat_Bbb(0)(1) <= mat_Bb(0)(1);
                mat_Bbb(1)(0) <= mat_Bb(1)(0);
                mat_Bbb(1)(1) <= mat_Bb(1)(1);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s6;              

            when s6 => -- output A14, B13
                mat_Abb(0)(0) <= mat_Ab(2)(2);
                mat_Abb(0)(1) <= mat_Ab(2)(3);
                mat_Abb(1)(0) <= mat_Ab(3)(2);
                mat_Abb(1)(1) <= mat_Ab(4)(3);
            
                mat_Bbb(0)(0) <= mat_Bb(2)(0);
                mat_Bbb(0)(1) <= mat_Bb(2)(1);
                mat_Bbb(1)(0) <= mat_Bb(3)(0);
                mat_Bbb(1)(1) <= mat_Bb(3)(1);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s7;
                    
            when s7 => -- output A13, B12
                mat_Abb(0)(0) <= mat_Ab(2)(0);
                mat_Abb(0)(1) <= mat_Ab(2)(1);
                mat_Abb(1)(0) <= mat_Ab(3)(0);
                mat_Abb(1)(1) <= mat_Ab(3)(1);
            
                mat_Bbb(0)(0) <= mat_Bb(0)(2);
                mat_Bbb(0)(1) <= mat_Bb(0)(3);
                mat_Bbb(1)(0) <= mat_Bb(1)(2);
                mat_Bbb(1)(1) <= mat_Bb(1)(3);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s8;      
                
            when s8 => -- output A14, B14
                mat_Abb(0)(0) <= mat_Ab(2)(2);
                mat_Abb(0)(1) <= mat_Ab(2)(3);
                mat_Abb(1)(0) <= mat_Ab(3)(2);
                mat_Abb(1)(1) <= mat_Ab(3)(3);
            
                mat_Bbb(0)(0) <= mat_Bb(2)(2);
                mat_Bbb(0)(1) <= mat_Bb(2)(3);
                mat_Bbb(1)(0) <= mat_Bb(3)(2);
                mat_Bbb(1)(1) <= mat_Bb(3)(3);

                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Abb(i)(j);
                    B_b_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bbb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s1;              
                    
            when others =>
                state <= s0;  

        end case;   
    end if;

end process;


end Behavioral;

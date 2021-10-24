----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/07/2021 11:20:27 PM
-- Design Name: 
-- Module Name: data_selector_top - Behavioral
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

entity data_selector_top is
  Port (clk: in std_logic;
      reset: in std_logic;
      enable: in std_logic;
      A, B: in unsigned(511 downto 0);
      A_b, B_b: out unsigned(127 downto 0);
      done: out std_logic
      );
end data_selector_top;

architecture Behavioral of data_selector_top is
type sub1 is array (0 to 7) of unsigned (7 downto 0);
type mat_type1 is array (0 to 7) of sub1;
signal mat_A, mat_B: mat_type1 := (others => (others => X"00")); 
type sub2 is array (0 to 3) of unsigned (7 downto 0);
type mat_type2 is array (0 to 3) of sub2;
signal mat_Ab, mat_Bb: mat_type2 := (others => (others => X"00"));
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
signal state: state_type:= s0;

begin

FSM: process(clk, reset)
begin
    if (reset = '1') then
    state <= s0;
    mat_A <= (others => (others => X"00")); 
    mat_B <= (others => (others => X"00"));
         
    elsif (enable = '1') then 
        if rising_edge(clk) then
            
            case state is
                when s0 =>
                    -- convert 1D array to 2D array
                    for i in 0 to 7 loop
                        for j in 0 to 7 loop
                            mat_A(i)(j) <= A((i*8+j+1)*8-1 downto (i*8+j)*8);
                            mat_B(i)(j) <= B((i*8+j+1)*8-1 downto (i*8+j)*8);
                        end loop;
                    end loop;
                    state <= s1;

                when s1 => -- output A1, B1
                    mat_Ab(0)(0) <= mat_A(0)(0);
                    mat_Ab(0)(1) <= mat_A(0)(1);
                    mat_Ab(0)(2) <= mat_A(0)(2);
                    mat_Ab(0)(3) <= mat_A(0)(3);
                    mat_Ab(1)(0) <= mat_A(1)(0);
                    mat_Ab(1)(1) <= mat_A(1)(1);
                    mat_Ab(1)(2) <= mat_A(1)(2);
                    mat_Ab(1)(3) <= mat_A(1)(3);
                    mat_Ab(2)(0) <= mat_A(2)(0);
                    mat_Ab(2)(1) <= mat_A(2)(1);
                    mat_Ab(2)(2) <= mat_A(2)(2);
                    mat_Ab(2)(3) <= mat_A(2)(3);
                    mat_Ab(3)(0) <= mat_A(3)(0);
                    mat_Ab(3)(1) <= mat_A(3)(1);
                    mat_Ab(3)(2) <= mat_A(3)(2);
                    mat_Ab(3)(3) <= mat_A(3)(3);
                    
                    mat_Bb(0)(0) <= mat_B(0)(0);
                    mat_Bb(0)(1) <= mat_B(0)(1);
                    mat_Bb(0)(2) <= mat_B(0)(2);
                    mat_Bb(0)(3) <= mat_B(0)(3);
                    mat_Bb(1)(0) <= mat_B(1)(0);
                    mat_Bb(1)(1) <= mat_B(1)(1);
                    mat_Bb(1)(2) <= mat_B(1)(2);
                    mat_Bb(1)(3) <= mat_B(1)(3);
                    mat_Bb(2)(0) <= mat_B(2)(0);
                    mat_Bb(2)(1) <= mat_B(2)(1);
                    mat_Bb(2)(2) <= mat_B(2)(2);
                    mat_Bb(2)(3) <= mat_B(2)(3);
                    mat_Bb(3)(0) <= mat_B(3)(0);
                    mat_Bb(3)(1) <= mat_B(3)(1);
                    mat_Bb(3)(2) <= mat_B(3)(2);
                    mat_Bb(3)(3) <= mat_B(3)(3);
                    
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    -- done <= '1';
                    state <= s2;
                    
                when s2 => -- output A2, B3
                    mat_Ab(0)(0) <= mat_A(0)(4);
                    mat_Ab(0)(1) <= mat_A(0)(5);
                    mat_Ab(0)(2) <= mat_A(0)(6);
                    mat_Ab(0)(3) <= mat_A(0)(7);
                    mat_Ab(1)(0) <= mat_A(1)(4);
                    mat_Ab(1)(1) <= mat_A(1)(5);
                    mat_Ab(1)(2) <= mat_A(1)(6);
                    mat_Ab(1)(3) <= mat_A(1)(7);
                    mat_Ab(2)(0) <= mat_A(2)(4);
                    mat_Ab(2)(1) <= mat_A(2)(5);
                    mat_Ab(2)(2) <= mat_A(2)(6);
                    mat_Ab(2)(3) <= mat_A(2)(7);
                    mat_Ab(3)(0) <= mat_A(3)(4);
                    mat_Ab(3)(1) <= mat_A(3)(5);
                    mat_Ab(3)(2) <= mat_A(3)(6);
                    mat_Ab(3)(3) <= mat_A(3)(7);
                        
                    mat_Bb(0)(0) <= mat_B(4)(0);
                    mat_Bb(0)(1) <= mat_B(4)(1);
                    mat_Bb(0)(2) <= mat_B(4)(2);
                    mat_Bb(0)(3) <= mat_B(4)(3);
                    mat_Bb(1)(0) <= mat_B(5)(0);
                    mat_Bb(1)(1) <= mat_B(5)(1);
                    mat_Bb(1)(2) <= mat_B(5)(2);
                    mat_Bb(1)(3) <= mat_B(5)(3);
                    mat_Bb(2)(0) <= mat_B(6)(0);
                    mat_Bb(2)(1) <= mat_B(6)(1);
                    mat_Bb(2)(2) <= mat_B(6)(2);
                    mat_Bb(2)(3) <= mat_B(6)(3);
                    mat_Bb(3)(0) <= mat_B(7)(0);
                    mat_Bb(3)(1) <= mat_B(7)(1);
                    mat_Bb(3)(2) <= mat_B(7)(2);
                    mat_Bb(3)(3) <= mat_B(7)(3);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s3;      
                        
                when s3 => -- output A1, B2
                    mat_Ab(0)(0) <= mat_A(0)(0);
                    mat_Ab(0)(1) <= mat_A(0)(1);
                    mat_Ab(0)(2) <= mat_A(0)(2);
                    mat_Ab(0)(3) <= mat_A(0)(3);
                    mat_Ab(1)(0) <= mat_A(1)(0);
                    mat_Ab(1)(1) <= mat_A(1)(1);
                    mat_Ab(1)(2) <= mat_A(1)(2);
                    mat_Ab(1)(3) <= mat_A(1)(3);
                    mat_Ab(2)(0) <= mat_A(2)(0);
                    mat_Ab(2)(1) <= mat_A(2)(1);
                    mat_Ab(2)(2) <= mat_A(2)(2);
                    mat_Ab(2)(3) <= mat_A(2)(3);
                    mat_Ab(3)(0) <= mat_A(3)(0);
                    mat_Ab(3)(1) <= mat_A(3)(1);
                    mat_Ab(3)(2) <= mat_A(3)(2);
                    mat_Ab(3)(3) <= mat_A(3)(3);
                        
                    mat_Bb(0)(0) <= mat_B(0)(4);
                    mat_Bb(0)(1) <= mat_B(0)(5);
                    mat_Bb(0)(2) <= mat_B(0)(6);
                    mat_Bb(0)(3) <= mat_B(0)(7);
                    mat_Bb(1)(0) <= mat_B(1)(4);
                    mat_Bb(1)(1) <= mat_B(1)(5);
                    mat_Bb(1)(2) <= mat_B(1)(6);
                    mat_Bb(1)(3) <= mat_B(1)(7);
                    mat_Bb(2)(0) <= mat_B(2)(4);
                    mat_Bb(2)(1) <= mat_B(2)(5);
                    mat_Bb(2)(2) <= mat_B(2)(6);
                    mat_Bb(2)(3) <= mat_B(2)(7);
                    mat_Bb(3)(0) <= mat_B(3)(4);
                    mat_Bb(3)(1) <= mat_B(3)(5);
                    mat_Bb(3)(2) <= mat_B(3)(6);
                    mat_Bb(3)(3) <= mat_B(3)(7);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s4;                         
                        
                when s4 => -- output A2, B4
                    mat_Ab(0)(0) <= mat_A(0)(4);
                    mat_Ab(0)(1) <= mat_A(0)(5);
                    mat_Ab(0)(2) <= mat_A(0)(6);
                    mat_Ab(0)(3) <= mat_A(0)(7);
                    mat_Ab(1)(0) <= mat_A(1)(4);
                    mat_Ab(1)(1) <= mat_A(1)(5);
                    mat_Ab(1)(2) <= mat_A(1)(6);
                    mat_Ab(1)(3) <= mat_A(1)(7);
                    mat_Ab(2)(0) <= mat_A(2)(4);
                    mat_Ab(2)(1) <= mat_A(2)(5);
                    mat_Ab(2)(2) <= mat_A(2)(6);
                    mat_Ab(2)(3) <= mat_A(2)(7);
                    mat_Ab(3)(0) <= mat_A(3)(4);
                    mat_Ab(3)(1) <= mat_A(3)(5);
                    mat_Ab(3)(2) <= mat_A(3)(6);
                    mat_Ab(3)(3) <= mat_A(3)(7);
                        
                    mat_Bb(0)(0) <= mat_B(4)(4);
                    mat_Bb(0)(1) <= mat_B(4)(5);
                    mat_Bb(0)(2) <= mat_B(4)(6);
                    mat_Bb(0)(3) <= mat_B(4)(7);
                    mat_Bb(1)(0) <= mat_B(5)(4);
                    mat_Bb(1)(1) <= mat_B(5)(5);
                    mat_Bb(1)(2) <= mat_B(5)(6);
                    mat_Bb(1)(3) <= mat_B(5)(7);
                    mat_Bb(2)(0) <= mat_B(6)(4);
                    mat_Bb(2)(1) <= mat_B(6)(5);
                    mat_Bb(2)(2) <= mat_B(6)(6);
                    mat_Bb(2)(3) <= mat_B(6)(7);
                    mat_Bb(3)(0) <= mat_B(7)(4);
                    mat_Bb(3)(1) <= mat_B(7)(5);
                    mat_Bb(3)(2) <= mat_B(7)(6);
                    mat_Bb(3)(3) <= mat_B(7)(7);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s5;
                        
                when s5 => -- output A3, B1
                    mat_Ab(0)(0) <= mat_A(4)(0);
                    mat_Ab(0)(1) <= mat_A(4)(1);
                    mat_Ab(0)(2) <= mat_A(4)(2);
                    mat_Ab(0)(3) <= mat_A(4)(3);
                    mat_Ab(1)(0) <= mat_A(5)(0);
                    mat_Ab(1)(1) <= mat_A(5)(1);
                    mat_Ab(1)(2) <= mat_A(5)(2);
                    mat_Ab(1)(3) <= mat_A(5)(3);
                    mat_Ab(2)(0) <= mat_A(6)(0);
                    mat_Ab(2)(1) <= mat_A(6)(1);
                    mat_Ab(2)(2) <= mat_A(6)(2);
                    mat_Ab(2)(3) <= mat_A(6)(3);
                    mat_Ab(3)(0) <= mat_A(7)(0);
                    mat_Ab(3)(1) <= mat_A(7)(1);
                    mat_Ab(3)(2) <= mat_A(7)(2);
                    mat_Ab(3)(3) <= mat_A(7)(3);
                        
                    mat_Bb(0)(0) <= mat_B(0)(0);
                    mat_Bb(0)(1) <= mat_B(0)(1);
                    mat_Bb(0)(2) <= mat_B(0)(2);
                    mat_Bb(0)(3) <= mat_B(0)(3);
                    mat_Bb(1)(0) <= mat_B(1)(0);
                    mat_Bb(1)(1) <= mat_B(1)(1);
                    mat_Bb(1)(2) <= mat_B(1)(2);
                    mat_Bb(1)(3) <= mat_B(1)(3);
                    mat_Bb(2)(0) <= mat_B(2)(0);
                    mat_Bb(2)(1) <= mat_B(2)(1);
                    mat_Bb(2)(2) <= mat_B(2)(2);
                    mat_Bb(2)(3) <= mat_B(2)(3);
                    mat_Bb(3)(0) <= mat_B(3)(0);
                    mat_Bb(3)(1) <= mat_B(3)(1);
                    mat_Bb(3)(2) <= mat_B(3)(2);
                    mat_Bb(3)(3) <= mat_B(3)(3);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s6;    
                        
                when s6 => -- output A4, B2
                    mat_Ab(0)(0) <= mat_A(4)(4);
                    mat_Ab(0)(1) <= mat_A(4)(5);
                    mat_Ab(0)(2) <= mat_A(4)(6);
                    mat_Ab(0)(3) <= mat_A(4)(7);
                    mat_Ab(1)(0) <= mat_A(5)(4);
                    mat_Ab(1)(1) <= mat_A(5)(5);
                    mat_Ab(1)(2) <= mat_A(5)(6);
                    mat_Ab(1)(3) <= mat_A(5)(7);
                    mat_Ab(2)(0) <= mat_A(6)(4);
                    mat_Ab(2)(1) <= mat_A(6)(5);
                    mat_Ab(2)(2) <= mat_A(6)(6);
                    mat_Ab(2)(3) <= mat_A(6)(7);
                    mat_Ab(3)(0) <= mat_A(7)(4);
                    mat_Ab(3)(1) <= mat_A(7)(5);
                    mat_Ab(3)(2) <= mat_A(7)(6);
                    mat_Ab(3)(3) <= mat_A(7)(7);
                        
                    mat_Bb(0)(0) <= mat_B(0)(4);
                    mat_Bb(0)(1) <= mat_B(0)(5);
                    mat_Bb(0)(2) <= mat_B(0)(6);
                    mat_Bb(0)(3) <= mat_B(0)(7);
                    mat_Bb(1)(0) <= mat_B(1)(4);
                    mat_Bb(1)(1) <= mat_B(1)(5);
                    mat_Bb(1)(2) <= mat_B(1)(6);
                    mat_Bb(1)(3) <= mat_B(1)(7);
                    mat_Bb(2)(0) <= mat_B(2)(4);
                    mat_Bb(2)(1) <= mat_B(2)(5);
                    mat_Bb(2)(2) <= mat_B(2)(6);
                    mat_Bb(2)(3) <= mat_B(2)(7);
                    mat_Bb(3)(0) <= mat_B(3)(4);
                    mat_Bb(3)(1) <= mat_B(3)(5);
                    mat_Bb(3)(2) <= mat_B(3)(6);
                    mat_Bb(3)(3) <= mat_B(3)(7);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s7;                            
                            
                when s7 => -- output A3, B2
                    mat_Ab(0)(0) <= mat_A(4)(0);
                    mat_Ab(0)(1) <= mat_A(4)(1);
                    mat_Ab(0)(2) <= mat_A(4)(2);
                    mat_Ab(0)(3) <= mat_A(4)(3);
                    mat_Ab(1)(0) <= mat_A(5)(0);
                    mat_Ab(1)(1) <= mat_A(5)(1);
                    mat_Ab(1)(2) <= mat_A(5)(2);
                    mat_Ab(1)(3) <= mat_A(5)(3);
                    mat_Ab(2)(0) <= mat_A(6)(0);
                    mat_Ab(2)(1) <= mat_A(6)(1);
                    mat_Ab(2)(2) <= mat_A(6)(2);
                    mat_Ab(2)(3) <= mat_A(6)(3);
                    mat_Ab(3)(0) <= mat_A(7)(0);
                    mat_Ab(3)(1) <= mat_A(7)(1);
                    mat_Ab(3)(2) <= mat_A(7)(2);
                    mat_Ab(3)(3) <= mat_A(7)(3);
                        
                    mat_Bb(0)(0) <= mat_B(0)(4);
                    mat_Bb(0)(1) <= mat_B(0)(5);
                    mat_Bb(0)(2) <= mat_B(0)(6);
                    mat_Bb(0)(3) <= mat_B(0)(7);
                    mat_Bb(1)(0) <= mat_B(1)(4);
                    mat_Bb(1)(1) <= mat_B(1)(5);
                    mat_Bb(1)(2) <= mat_B(1)(6);
                    mat_Bb(1)(3) <= mat_B(1)(7);
                    mat_Bb(2)(0) <= mat_B(2)(4);
                    mat_Bb(2)(1) <= mat_B(2)(5);
                    mat_Bb(2)(2) <= mat_B(2)(6);
                    mat_Bb(2)(3) <= mat_B(2)(7);
                    mat_Bb(3)(0) <= mat_B(3)(4);
                    mat_Bb(3)(1) <= mat_B(3)(5);
                    mat_Bb(3)(2) <= mat_B(3)(6);
                    mat_Bb(3)(3) <= mat_B(3)(7);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s8;                    
                            
                when s8 => -- output A4, B4
                    mat_Ab(0)(0) <= mat_A(4)(4);
                    mat_Ab(0)(1) <= mat_A(4)(5);
                    mat_Ab(0)(2) <= mat_A(4)(6);
                    mat_Ab(0)(3) <= mat_A(4)(7);
                    mat_Ab(1)(0) <= mat_A(5)(4);
                    mat_Ab(1)(1) <= mat_A(5)(5);
                    mat_Ab(1)(2) <= mat_A(5)(6);
                    mat_Ab(1)(3) <= mat_A(5)(7);
                    mat_Ab(2)(0) <= mat_A(6)(4);
                    mat_Ab(2)(1) <= mat_A(6)(5);
                    mat_Ab(2)(2) <= mat_A(6)(6);
                    mat_Ab(2)(3) <= mat_A(6)(7);
                    mat_Ab(3)(0) <= mat_A(7)(4);
                    mat_Ab(3)(1) <= mat_A(7)(5);
                    mat_Ab(3)(2) <= mat_A(7)(6);
                    mat_Ab(3)(3) <= mat_A(7)(7);
                        
                    mat_Bb(0)(0) <= mat_B(4)(4);
                    mat_Bb(0)(1) <= mat_B(4)(5);
                    mat_Bb(0)(2) <= mat_B(4)(6);
                    mat_Bb(0)(3) <= mat_B(4)(7);
                    mat_Bb(1)(0) <= mat_B(5)(4);
                    mat_Bb(1)(1) <= mat_B(5)(5);
                    mat_Bb(1)(2) <= mat_B(5)(6);
                    mat_Bb(1)(3) <= mat_B(5)(7);
                    mat_Bb(2)(0) <= mat_B(6)(4);
                    mat_Bb(2)(1) <= mat_B(6)(5);
                    mat_Bb(2)(2) <= mat_B(6)(6);
                    mat_Bb(2)(3) <= mat_B(6)(7);
                    mat_Bb(3)(0) <= mat_B(7)(4);
                    mat_Bb(3)(1) <= mat_B(7)(5);
                    mat_Bb(3)(2) <= mat_B(7)(6);
                    mat_Bb(3)(3) <= mat_B(7)(7);
                        
                    -- convert 2D arrays to 1D arrays
                    for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        A_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Ab(i)(j);
                        B_b((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_Bb(i)(j);
                    end loop;
                    end loop;
                    done <= '1';
                    state <= s1;                    
                                        
                when others =>
                    state <= s0;                    
            end case;                           
        end if;
    end if;
end process;

end Behavioral;

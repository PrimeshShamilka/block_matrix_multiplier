----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2021 05:44:03 PM
-- Design Name: 
-- Module Name: data_selector - Behavioral
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

entity data_selector is
  Port (clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        A, B: in unsigned(511 downto 0);
        A_b, B_b: out unsigned(31 downto 0);
        done: out std_logic
        );
end data_selector;

architecture Behavioral of data_selector is
--type mat1_type is array(0 to 7, 0 to 7) of unsigned (7 downto 0);
--type mat2_type is array(0 to 3, 0 to 3) of unsigned (7 downto 0);
--type mat3_type is array(0 to 1, 0 to 1) of unsigned (7 downto 0);
--signal mat_A, mat_B: mat1_type := (others => (others => X"00"));
type sub1 is array (0 to 7) of unsigned (7 downto 0);
type mat_type1 is array (0 to 7) of sub1;
signal mat_A, mat_B: mat_type1 := (others => (others => X"00")); 
type sub2 is array (0 to 1) of unsigned (7 downto 0);
type mat_type2 is array (0 to 1) of sub2;
signal mat_Ab, mat_Bb: mat_type2;
--signal mat_A1, mat_A2, mat_A3, mat_A4, mat_B1, mat_B2, mat_B3, mat_B4: mat2_type;
--signal mat_A11, mat_A12, mat_A13, mat_A14, mat_B11, mat_B12, mat_B13, mat_B14: mat3_type;
--signal mat_A21, mat_A22, mat_A23, mat_A24, mat_B21, mat_B22, mat_B23, mat_B24: mat3_type;
--signal mat_A31, mat_A32, mat_A33, mat_A34, mat_B31, mat_B32, mat_B33, mat_B34: mat3_type;
--signal mat_A41, mat_A42, mat_A43, mat_A44, mat_B41, mat_B42, mat_B43, mat_B44: mat3_type;
--signal mat_Ai, mat_Bi: mat2_type;
--signal mat_Aij, mat_Bij: mat3_type;
type state_type is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16);
signal state: state_type:= s1;

begin

--convert: process(clk)
--begin
--    if rising_edge(clk) then
--        -- convert 1D array to 2D array
--        for i in 0 to 7 loop
--            for j in 0 to 7 loop
----                mat_A(i, j) <= A((i*8+j+1)*8-1 downto (i*8+j)*8);
----                mat_B(i, j) <= B((i*8+j+1)*8-1 downto (i*8+j)*8);
--                  mat_A(i)(j) <= A((i*8+j+1)*8-1 downto (i*8+j)*8);
--                  mat_B(i)(j) <= B((i*8+j+1)*8-1 downto (i*8+j)*8);
--            end loop;
--        end loop;
--    end if;
--end process;

FSM: process (clk, reset)
begin
    if (reset = '1') then
        state <= s1;
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00"));
             
    elsif rising_edge(clk) then
        -- convert 1D array to 2D array
        for i in 0 to 7 loop
            for j in 0 to 7 loop
    --                mat_A(i, j) <= A((i*8+j+1)*8-1 downto (i*8+j)*8);
    --                mat_B(i, j) <= B((i*8+j+1)*8-1 downto (i*8+j)*8);
                  mat_A(i)(j) <= A((i*8+j+1)*8-1 downto (i*8+j)*8);
                  mat_B(i)(j) <= B((i*8+j+1)*8-1 downto (i*8+j)*8);
            end loop;
        end loop;
        
        case state is
            when s1 => -- output A11, B11
                mat_Ab(0)(0) <= mat_A(0)(0);
                mat_Ab(0)(1) <= mat_A(0)(1);
                mat_Ab(1)(0) <= mat_A(1)(0);
                mat_Ab(1)(1) <= mat_A(1)(1);
                
                mat_Bb(0)(0) <= mat_B(0)(0);
                mat_Bb(0)(1) <= mat_B(0)(1);
                mat_Bb(1)(0) <= mat_B(1)(0);
                mat_Bb(1)(1) <= mat_B(1)(1);
                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
                    B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s2;
                
            when s2 => -- output A12, B12
                mat_Ab(0)(0) <= mat_A(0)(2);
                mat_Ab(0)(1) <= mat_A(0)(3);
                mat_Ab(1)(0) <= mat_A(1)(2);
                mat_Ab(1)(1) <= mat_A(1)(3);
                
                mat_Bb(0)(0) <= mat_B(0)(2);
                mat_Bb(0)(1) <= mat_B(0)(3);
                mat_Bb(1)(0) <= mat_B(1)(2);
                mat_Bb(1)(1) <= mat_B(1)(3);
                -- convert 2D arrays to 1D arrays
                for i in 0 to 1 loop
                for j in 0 to 1 loop
                    A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
                    B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
                end loop;
                end loop;
                done <= '1';
                state <= s3;
          
--            when s3 => -- output A13, B13
--                mat_Ab(0)(0) <= mat_A(0)(4);
--                mat_Ab(0)(1) <= mat_A(0)(5);
--                mat_Ab(1)(0) <= mat_A(1)(4);
--                mat_Ab(1)(1) <= mat_A(1)(5);
                
--                mat_Bb(0)(0) <= mat_B(0)(4);
--                mat_Bb(0)(1) <= mat_B(0)(5);
--                mat_Bb(1)(0) <= mat_B(1)(4);
--                mat_Bb(1)(1) <= mat_B(1)(5);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s4;
                
--            when s4 => -- output A14, B14
--                mat_Ab(0)(0) <= mat_A(0)(6);
--                mat_Ab(0)(1) <= mat_A(0)(7);
--                mat_Ab(1)(0) <= mat_A(1)(6);
--                mat_Ab(1)(1) <= mat_A(1)(7);
                
--                mat_Bb(0)(0) <= mat_B(0)(6);
--                mat_Bb(0)(1) <= mat_B(0)(7);
--                mat_Bb(1)(0) <= mat_B(1)(6);
--                mat_Bb(1)(1) <= mat_B(1)(7);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s5;                    
                
--            when s5 => -- output A21, B21
--                mat_Ab(0)(0) <= mat_A(2)(0);
--                mat_Ab(0)(1) <= mat_A(2)(1);
--                mat_Ab(1)(0) <= mat_A(3)(0);
--                mat_Ab(1)(1) <= mat_A(3)(1);
                
--                mat_Bb(0)(0) <= mat_B(2)(0);
--                mat_Bb(0)(1) <= mat_B(2)(1);
--                mat_Bb(1)(0) <= mat_B(3)(0);
--                mat_Bb(1)(1) <= mat_B(3)(1);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s6;                    

--            when s6 => -- output A22, B22
--                mat_Ab(0)(0) <= mat_A(2)(2);
--                mat_Ab(0)(1) <= mat_A(2)(3);
--                mat_Ab(1)(0) <= mat_A(3)(2);
--                mat_Ab(1)(1) <= mat_A(3)(3);
                
--                mat_Bb(0)(0) <= mat_B(2)(2);
--                mat_Bb(0)(1) <= mat_B(2)(3);
--                mat_Bb(1)(0) <= mat_B(3)(2);
--                mat_Bb(1)(1) <= mat_B(3)(3);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s7;     
   
--            when s7 => -- output A23, B23
--                mat_Ab(0)(0) <= mat_A(2)(4);
--                mat_Ab(0)(1) <= mat_A(2)(5);
--                mat_Ab(1)(0) <= mat_A(3)(4);
--                mat_Ab(1)(1) <= mat_A(3)(5);
                
--                mat_Bb(0)(0) <= mat_B(2)(4);
--                mat_Bb(0)(1) <= mat_B(2)(5);
--                mat_Bb(1)(0) <= mat_B(3)(4);
--                mat_Bb(1)(1) <= mat_B(3)(5);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s8;      
   
--            when s8 => -- output A24, B24
--                mat_Ab(0)(0) <= mat_A(2)(6);
--                mat_Ab(0)(1) <= mat_A(2)(7);
--                mat_Ab(1)(0) <= mat_A(3)(6);
--                mat_Ab(1)(1) <= mat_A(3)(7);
                
--                mat_Bb(0)(0) <= mat_B(2)(6);
--                mat_Bb(0)(1) <= mat_B(2)(7);
--                mat_Bb(1)(0) <= mat_B(3)(6);
--                mat_Bb(1)(1) <= mat_B(3)(7);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s9;    
                
--            when s9 => -- output A31, B31
--                mat_Ab(0)(0) <= mat_A(4)(0);
--                mat_Ab(0)(1) <= mat_A(4)(1);
--                mat_Ab(1)(0) <= mat_A(5)(0);
--                mat_Ab(1)(1) <= mat_A(5)(1);
                
--                mat_Bb(0)(0) <= mat_B(4)(0);
--                mat_Bb(0)(1) <= mat_B(4)(1);
--                mat_Bb(1)(0) <= mat_B(5)(0);
--                mat_Bb(1)(1) <= mat_B(5)(1);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s10;   
                
--            when s10 => -- output A32, B32
--                mat_Ab(0)(0) <= mat_A(4)(2);
--                mat_Ab(0)(1) <= mat_A(4)(3);
--                mat_Ab(1)(0) <= mat_A(5)(2);
--                mat_Ab(1)(1) <= mat_A(5)(3);
                
--                mat_Bb(0)(0) <= mat_B(4)(2);
--                mat_Bb(0)(1) <= mat_B(4)(3);
--                mat_Bb(1)(0) <= mat_B(5)(2);
--                mat_Bb(1)(1) <= mat_B(5)(3);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s11;            
                
--            when s11 => -- output A33, B33
--                mat_Ab(0)(0) <= mat_A(4)(4);
--                mat_Ab(0)(1) <= mat_A(4)(5);
--                mat_Ab(1)(0) <= mat_A(5)(4);
--                mat_Ab(1)(1) <= mat_A(5)(5);
                
--                mat_Bb(0)(0) <= mat_B(4)(4);
--                mat_Bb(0)(1) <= mat_B(4)(5);
--                mat_Bb(1)(0) <= mat_B(5)(4);
--                mat_Bb(1)(1) <= mat_B(5)(5);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s12;   
                
--            when s12 => -- output A34, B34
--                mat_Ab(0)(0) <= mat_A(4)(6);
--                mat_Ab(0)(1) <= mat_A(4)(7);
--                mat_Ab(1)(0) <= mat_A(5)(6);
--                mat_Ab(1)(1) <= mat_A(5)(7);
                
--                mat_Bb(0)(0) <= mat_B(4)(6);
--                mat_Bb(0)(1) <= mat_B(4)(7);
--                mat_Bb(1)(0) <= mat_B(5)(6);
--                mat_Bb(1)(1) <= mat_B(5)(7);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s13;                                        
                                                    
--            when s13 => -- output A41, B41
--                mat_Ab(0)(0) <= mat_A(6)(0);
--                mat_Ab(0)(1) <= mat_A(6)(1);
--                mat_Ab(1)(0) <= mat_A(7)(0);
--                mat_Ab(1)(1) <= mat_A(7)(1);
                
--                mat_Bb(0)(0) <= mat_B(6)(0);
--                mat_Bb(0)(1) <= mat_B(6)(1);
--                mat_Bb(1)(0) <= mat_B(7)(0);
--                mat_Bb(1)(1) <= mat_B(7)(1);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s14;
                
--            when s14 => -- output A42, B42
--                mat_Ab(0)(0) <= mat_A(6)(2);
--                mat_Ab(0)(1) <= mat_A(6)(3);
--                mat_Ab(1)(0) <= mat_A(7)(2);
--                mat_Ab(1)(1) <= mat_A(7)(3);
                
--                mat_Bb(0)(0) <= mat_B(6)(2);
--                mat_Bb(0)(1) <= mat_B(6)(3);
--                mat_Bb(1)(0) <= mat_B(7)(2);
--                mat_Bb(1)(1) <= mat_B(7)(3);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s15;        
                
--            when s15 => -- output A43, B43
--                mat_Ab(0)(0) <= mat_A(6)(4);
--                mat_Ab(0)(1) <= mat_A(6)(5);
--                mat_Ab(1)(0) <= mat_A(7)(4);
--                mat_Ab(1)(1) <= mat_A(7)(5);
                
--                mat_Bb(0)(0) <= mat_B(6)(4);
--                mat_Bb(0)(1) <= mat_B(6)(5);
--                mat_Bb(1)(0) <= mat_B(7)(4);
--                mat_Bb(1)(1) <= mat_B(7)(5);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s16;                         
                                                     
--           when s16 => -- output A44, B44
--                mat_Ab(0)(0) <= mat_A(6)(6);
--                mat_Ab(0)(1) <= mat_A(6)(6);
--                mat_Ab(1)(0) <= mat_A(7)(6);
--                mat_Ab(1)(1) <= mat_A(7)(7);
                
--                mat_Bb(0)(0) <= mat_B(6)(6);
--                mat_Bb(0)(1) <= mat_B(6)(7);
--                mat_Bb(1)(0) <= mat_B(7)(6);
--                mat_Bb(1)(1) <= mat_B(7)(7);
--                -- convert 2D arrays to 1D arrays
--                for i in 0 to 1 loop
--                for j in 0 to 1 loop
--                 A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
--                 B_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Bb(i)(j);
--                end loop;
--                end loop;
--                done <= '1';             
--                state <= s1;   
                
            when others =>
                state <= s1;                    
        end case;
    end if;
end process;
end Behavioral;

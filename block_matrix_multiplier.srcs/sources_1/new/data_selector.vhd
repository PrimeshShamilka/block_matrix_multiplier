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
--                A_b <= unsigned(A(7 downto 0) + A((1+8) downto (0+8)));
--                B_b <= unsigned(B(1 downto 0) + B((1+8) downto (0+8)));
                  mat_Ab(0)(0) <= mat_A(0)(0);
                  mat_Ab(0)(1) <= mat_A(0)(1);
                  mat_Ab(1)(0) <= mat_A(1)(0);
                  mat_Ab(1)(1) <= mat_A(1)(1);
                  
                  -- convert 2D array to 1D array
                  for i in 0 to 1 loop
                    for j in 0 to 1 loop
                        A_b((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_Ab(i)(j);
                    end loop;
                  end loop;
                  done <= '1';
--                  A_b <= mat_A(0)(0);
--                state <= s2;
            when s2 => -- output A12, B12
                A_b <= unsigned(A(3 downto 2) + A((3+8) downto (2+8)));
                B_b <= unsigned(B(3 downto 2) + B((3+8) downto (2+8)));
                state <= s3;
            when others =>
                state <= s1;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;
            -- when s4 => -- output A14, B14
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;
            --     when s1 => -- output A11, B11
            --     A_b <= unsigned(A(1 downto 0) + A((1+8) downto (0+8)));
            --     B_b <= unsigned(B(1 downto 0) + B((1+8) downto (0+8)));
            --     state <= s2;
            -- when s2 => -- output A12, B12
            --     A_b <= unsigned(A(3 downto 2) + A((3+8) downto (2+8)));
            --     B_b <= unsigned(B(3 downto 2) + B((3+8) downto (2+8)));
            --     state <= s3;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;           
            --     when s1 => -- output A11, B11
            --     A_b <= unsigned(A(1 downto 0) + A((1+8) downto (0+8)));
            --     B_b <= unsigned(B(1 downto 0) + B((1+8) downto (0+8)));
            --     state <= s2;
            -- when s2 => -- output A12, B12
            --     A_b <= unsigned(A(3 downto 2) + A((3+8) downto (2+8)));
            --     B_b <= unsigned(B(3 downto 2) + B((3+8) downto (2+8)));
            --     state <= s3;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;
            --     when s1 => -- output A11, B11
            --     A_b <= unsigned(A(1 downto 0) + A((1+8) downto (0+8)));
            --     B_b <= unsigned(B(1 downto 0) + B((1+8) downto (0+8)));
            --     state <= s2;
            -- when s2 => -- output A12, B12
            --     A_b <= unsigned(A(3 downto 2) + A((3+8) downto (2+8)));
            --     B_b <= unsigned(B(3 downto 2) + B((3+8) downto (2+8)));
            --     state <= s3;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;
            -- when s3 => -- output A13, B13
            --     A_b <= unsigned(A(5 downto 4) + A((5+8) downto (4+8)));
            --     B_b <= unsigned(B(5 downto 4) + B((5+8) downto (4+8)));
            --     state <= s4;                        
        end case;
    end if;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2021 08:57:41 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity main is
    Port (clk: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    A, B: in unsigned(511 downto 0);
    C: out unsigned(511 downto 0);
    done: out std_logic
    );
end main;

architecture Behavioral of main is

component data_selector_top
    Port (clk: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    A, B: in unsigned(511 downto 0);
    A_b, B_b: out unsigned(127 downto 0);
    done: out std_logic
    );
end component;

component data_selector_bottom
    Port (clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        A_b, B_b: in unsigned(127 downto 0);
        A_b_b, B_b_b: out unsigned(31 downto 0);
        done: out std_logic
    );
end component;

component matrix_multiplier_2x2
    port(clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A,B: in unsigned(31 downto 0);
        C: out unsigned(31 downto 0);
        done:out std_logic
        );
end component;

component matrix_added_2x2
    port(clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(31 downto 0);
        C: out unsigned(31 downto 0);
        done:inout std_logic
        );
end component;

component matrix_buffer_4x4
    port(clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(31 downto 0);
        E: out unsigned(127 downto 0);
        done:out std_logic
        );
end component;

component matrix_adder_4x4
    port(clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(127 downto 0);
        C: out unsigned(127 downto 0);
        done:inout std_logic
        );
end component;

component matrix_buffer_8x8
end component;

-- Data selector top
signal data_selc_top_reset: std_logic:= '0';
signal data_selc_top_en: std_logic:= '0';
signal data_selc_top_done: std_logic;
signal A_b: unsigned(127 downto 0);
signal B_b: unsigned(127 downto 0);

-- Data selector bottom
signal data_selc_bottom_reset: std_logic:= '0';
signal data_selc_bottom_en: std_logic:= '0';
signal data_selc_bottom_done: std_logic;
signal A_b_b: unsigned(31 downto 0);
signal B_b_b: unsigned(31 downto 0);

-- Matrix multiplier 2x2
signal matrix_multiplier_2x2_reset: std_logic:= '0';
signal matrix_multiplier_2x2_en: std_logic:= '0';
signal matrix_multiplier_2x2_done: std_logic:= '0';
signal C_b_b_b: unsigned(31 downto 0);

-- Matrix adder 2x2
signal matrix_adder_2x2_reset: std_logic:= '0';
signal matrix_adder_2x2_en: std_logic:= '0';
signal matrix_adder_2x2_done: std_logic:= '0';
signal C_b_b: unsigned(31 downto 0);

-- Matrix buffer 4x4
signal matrix_buffer_4x4_reset: std_logic:= '0';
signal matrix_buffer_4x4_en: std_logic:= '0';
signal matrix_buffer_4x4_done: std_logic:= '0';
signal E: unsigned(127 downto 0);

-- Matrix adder 4x4
signal matrix_adder_4x4_reset: std_logic:= '0';
signal matrix_adder_4x4_en: std_logic:= '0';
signal matrix_adder_4x4_done: std_logic:= '0';
signal E_sum: unsigned(127 downto 0);

-- Matrix buffer 8x8
signal matrix_buffer_8x8_reset: std_logic:= '0';
signal matrix_buffer_8x8_en: std_logic:= '0';
signal matrix_buffer_8x8_done: std_logic:= '0';


begin
    data_selector_top_Imp: data_selector_top port map(
        clk => clk,
        reset => data_selc_top_reset,
        enable => data_selc_top_en,
        A => A,
        B => B,
        A_b => A_b,
        B_b => B_b,
        done => data_selc_top_done
    );

    data_selector_bottom_Imp: data_selector_bottom port map(
        clk => clk,
        reset => data_selc_bottom_reset,
        enable => data_selc_bottom_en,
        A_b => A_b,
        B_b => B_b,
        A_b_b => A_b_b,
        B_b_b => B_b_b,
        done => done
    );

    matrix_multiplier_2x2_Imp: matrix_multiplier_2x2 port map(
        clk => clk,
        reset => matrix_multiplier_2x2_reset,
        enable => matrix_multiplier_2x2_en,
        A => A_b_b,
        B => B_b_b,
        C => C_b_b_b,
        done => done
    );

    matrix_adder_2x2_Imp: matrix_adder_2x2 port map(
        clk => clk,
        reset => matrix_adder_2x2_reset,
        enable => matrix_adder_2x2_en,
        A => C_b_b_b,
        C => C_b_b,
        done => matrix_adder_2x2_done
    );

    matrix_buffer_4x4_Imp: matrix_buffer_4x4 port map(
        clk => clk,
        reset => matrix_buffer_4x4_reset,
        enable => matrix_buffer_4x4_en,
        A => C_b_b,
        E => E,
        done => matrix_buffer_4x4_done
    );

    matrix_adder_4x4_Imp: matrix_adder_4x4 port map(
        clk => clk,
        reset => matrix_adder_4x4_reset,
        enable => matrix_adder_4x4_en,
        A => E,
        C => E_sum,
        done => matrix_adder_4x4_done
    );

    matrix_buffer_8x8_Imp: matrix_buffer_8x8 port map(
        clk => clk,
        reset => matrix_buffer_8x8_reset,
        enable => matrix_buffer_8x8_en,
        A => E_sum,
        E => C,
        done => matrix_buffer_8x8_done
    );

    FSM: process(clk, reset)
    begin
        if rising_edge(clk) then
            data_selc_top_en <= '1';
            data_selc_bottom_en <= '1';
        end if;
    end process;

    

end Behavioral;

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
    done: out std_logic;
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

-- Data selector down
signal data_selc_bottom_reset: std_logic:= '0';
signal data_selc_bottom_en: std_logic:= '0';
signal data_selc_bottom_done: std_logic;
signal A_b_b: unsigned(31 downto 0);
signal B_b_b: unsigned(31 downto 0);

begin
    data_selector_top: data_selector_top port map(
        clk => clk,
        reset => data_selc_top_reset,
        enable => data_selc_top_en,
        A => A,
        B => B,
        A_b => A_b,
        B_b => B_b,
        done => data_selc_top_done
    );

    data_selector_bottom: data_selector_bottom port map(
        clk => clk/8,
        reset => data_selc_bottom_reset,
        enable => data_selc_bottom_en,
        A_b => A_b,
        B_b => B_b,
        A_b_b => A_b_b,
        B_b_b => B_b_b,
        done => done
    );


    FSM: process(clk, reset)
    begin
        if rising_edge(clk) then
            data_selc_top_en <= '1';
            data_selc_bottom_en <= '1';
        end if;
    end process;

    

end Behavioral;

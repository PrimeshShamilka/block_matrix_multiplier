----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2021 09:16:46 PM
-- Design Name: 
-- Module Name: data_selector_bottom_tb - Behavioral
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

entity data_selector_bottom_tb is
--  Port ( );
end data_selector_bottom_tb;

architecture Behavioral of data_selector_bottom_tb is
component data_selector_bottom
Port (clk: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    A_b, B_b: in unsigned(127 downto 0);
    A_b_b, B_b_b: out unsigned(31 downto 0);
    done: out std_logic
);
end component;

  -- Inputs
signal clk: std_logic := '0';
signal reset: std_logic := '0';
signal enable: std_logic := '0';
signal A_b, B_b: unsigned(127 downto 0);
-- Outputs
signal A_b_b, B_b_b: unsigned(31 downto 0);
signal done: std_logic;
-- Clock period definitions
constant clk_period : time := 40 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: data_selector_bottom port map(
    clk => clk,
    reset => reset,
    enable => enable,
    A_b => A_b,
    B_b => B_b,
    A_b_b => A_b_b,
    B_b_b => B_b_b,
    done => done
    );
    
-- Clock process definitions
clk_process :process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

stim_proc: process
begin 
    A_b <= X"44" & X"43" & X"42" & X"41" &
         X"34" & X"33" & X"32" & X"31" &
         X"24" & X"23" & X"22" & X"21" &
         X"14" & X"13" & X"12" & X"11";
         
    B_b <= X"44" & X"43" & X"42" & X"41" &
         X"34" & X"33" & X"32" & X"31" &
         X"24" & X"23" & X"22" & X"21" &
         X"14" & X"13" & X"12" & X"11";
    wait for 10 ns;
    wait;
end process;

end Behavioral;

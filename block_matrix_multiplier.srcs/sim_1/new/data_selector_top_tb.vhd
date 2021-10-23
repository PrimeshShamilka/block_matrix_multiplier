----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2021 12:10:56 AM
-- Design Name: 
-- Module Name: data_selector_top_tb - Behavioral
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

entity data_selector_top_tb is
--  Port ( );
end data_selector_top_tb;

architecture Behavioral of data_selector_top_tb is
component data_selector_top 
  Port (clk: in std_logic;
       reset: in std_logic;
      enable: in std_logic;
      A, B: in unsigned(511 downto 0);
      A_b, B_b: out unsigned(127 downto 0);
      done: out std_logic
      );
end component;

-- Inputs
signal clk: std_logic := '0';
signal reset: std_logic := '0';
signal enable: std_logic := '0';
signal A, B: unsigned(511 downto 0);
-- Outputs
signal A_b, B_b: unsigned(127 downto 0);
signal done: std_logic;
-- Clock period definitions
constant clk_period : time := 40 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: data_selector_top port map(
    clk => clk,
    reset => reset,
    enable => enable,
    A => A,
    B => B,
    A_b => A_b,
    B_b => B_b,
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
    A <= X"88" & X"87" & X"86" & X"85" & X"84" & X"83" & X"82" & X"81" &
         X"78" & X"77" & X"76" & X"75" & X"74" & X"73" & X"72" & X"71" &
         X"68" & X"67" & X"66" & X"65" & X"64" & X"63" & X"62" & X"61" &
         X"58" & X"57" & X"56" & X"55" & X"54" & X"53" & X"52" & X"51" &
         X"48" & X"47" & X"46" & X"45" & X"44" & X"43" & X"42" & X"41" &
         X"38" & X"37" & X"36" & X"35" & X"34" & X"33" & X"32" & X"31" &
         X"28" & X"27" & X"26" & X"25" & X"24" & X"23" & X"22" & X"21" &
         X"18" & X"17" & X"16" & X"15" & X"14" & X"13" & X"12" & X"11";
         
    B <= X"88" & X"87" & X"86" & X"85" & X"84" & X"83" & X"82" & X"81" &
         X"78" & X"77" & X"76" & X"75" & X"74" & X"73" & X"72" & X"71" &
         X"68" & X"67" & X"66" & X"65" & X"64" & X"63" & X"62" & X"61" &
         X"58" & X"57" & X"56" & X"55" & X"54" & X"53" & X"52" & X"51" &
         X"48" & X"47" & X"46" & X"45" & X"44" & X"43" & X"42" & X"41" &
         X"38" & X"37" & X"36" & X"35" & X"34" & X"33" & X"32" & X"31" &
         X"28" & X"27" & X"26" & X"25" & X"24" & X"23" & X"22" & X"21" &
         X"18" & X"17" & X"16" & X"15" & X"14" & X"13" & X"12" & X"11";
    wait;
end process;

end Behavioral;

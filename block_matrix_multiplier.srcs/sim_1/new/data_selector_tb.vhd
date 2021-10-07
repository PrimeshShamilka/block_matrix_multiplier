----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2021 09:10:23 PM
-- Design Name: 
-- Module Name: data_selector_tb - Behavioral
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

entity data_selector_tb is
--  Port ( );
end data_selector_tb;

architecture Behavioral of data_selector_tb is
component data_selector 
  Port (clk: in std_logic;
       reset: in std_logic;
      enable: in std_logic;
      A, B: in unsigned(511 downto 0);
      A_b, B_b: out unsigned(31 downto 0);
      done: out std_logic
      );
end component;

-- Inputs
signal clk: std_logic := '0';
signal reset: std_logic := '0';
signal enable: std_logic := '0';
signal A, B: unsigned(511 downto 0);
-- Outputs
signal A_b, B_b: unsigned(31 downto 0);
signal done: std_logic;
-- Clock period definitions
constant clk_period : time := 10 ns;



begin
-- Instantiate the Unit Under Test (UUT)
uut: data_selector port map(
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
    A <= X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
         X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01";
         
   B <= X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01" &
        X"08" & X"07" & X"06" & X"05" & X"04" & X"03" & X"02" & X"01";
    wait;
end process;

end Behavioral;

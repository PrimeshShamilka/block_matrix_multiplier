
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity matrix_adder_4x4_tb is
--  Port ( );
end matrix_adder_4x4_tb;

architecture Behavioral of matrix_adder_4x4_tb is
component matrix_adder_4x4
  Port (clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        A, B: in unsigned(127 downto 0);
        C: out unsigned(127 downto 0);
        done: out std_logic
      );
end component;

-- Inputs
signal clk: std_logic := '0';
signal reset: std_logic := '0';
signal enable: std_logic := '0';
signal A, B: unsigned(127 downto 0);
-- Outputs
signal C: unsigned(127 downto 0);
signal done: std_logic;
-- Clock period definitions
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: matrix_adder_4x4 port map(
    clk => clk,
    reset => reset,
    enable => enable,
    A => A,
    B => B,
    C => C,
    done => done
    );
    
-- Clock process definitions
clk  :process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

stimulus    : process
begin 
    enable<='1'
    A <= X"1" & X"1" & X"1" & X"1" & 
         X"1" & X"1" & X"1" & X"1" & 
         X"1" & X"1" & X"1" & X"1" & 
         X"1" & X"1" & X"1" & X"1" ;

    B <= X"1" & X"1" & X"1" & X"1" & 
         X"1" & X"1" & X"1" & X"1" & 
         X"1" & X"1" & X"1" & X"1" & 
         X"1" & X"1" & X"1" & X"1" ;   
    wait;
end process;

end Behavioral;

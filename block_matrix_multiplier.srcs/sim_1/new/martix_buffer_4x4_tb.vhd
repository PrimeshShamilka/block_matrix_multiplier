
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity matrix_buffer_4x4_tb is
--  Port ( );
end matrix_buffer_4x4_tb;

architecture Behavioral of matrix_buffer_4x4_tb is
component mat_buf_4x4 
  Port (clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(31 downto 0);
        E: out unsigned(127 downto 0);
        done: out std_logic
      );
end component;

-- Inputs
signal clk: std_logic := '0';
signal reset: std_logic := '0';
signal enable: std_logic := '0';
signal A: unsigned(31 downto 0);
-- Outputs
signal E: unsigned(127 downto 0);
signal done: std_logic;
-- Clock period definitions
constant clk_period : time := 40 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: mat_buf_4x4 port map(
    clk => clk,
    reset => reset,
    enable => enable,
    A => A,
    E => E,
    done => done
    );
    
-- Clock process definitions
clock  :process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

stimulus    : process
begin 
    enable<='1';
    A <= X"01" & X"01" & 
         X"01" & X"01";
    wait for clk_period*2;
    A <= X"02" & X"02" & 
         X"02" & X"02";  
    wait for clk_period*2;
    A <= X"03" & X"03" & 
         X"03" & X"03";   
    wait for clk_period*2;
    A <= X"04" & X"04" & 
         X"04" & X"04";
    wait;
end process;

end Behavioral;

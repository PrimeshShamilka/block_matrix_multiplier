
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mat_buf_2x2 is
port(   clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(31 downto 0);
        C,D: out unsigned(31 downto 0);
        done:out std_logic
        );
end mat_buf_2x2;

architecture Behavioral of mat_buf_2x2 is

begin

process(clk,reset)
begin
    if(rising_edge(clk)) then
        if(enable='0') then
            C <= A;
        else 
            D <= A;
            done <= '1';
    end if;
end process;


            
end Behavioral;

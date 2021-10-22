
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mat_add_4x4 is
port(   clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A,B: in unsigned(127 downto 0);
        C: out unsigned(127 downto 0);
        done:out std_logic
        );
end mat_add_4x4;

architecture Behavioral of mat_add_4x4 is
type row_4x4 is array (0 to 3) of unsigned (7 downto 0);
type mat_4x4 is array (0 to 3) of row_4x4;
signal mat_A,mat_B,mat_C: mat_4x4 := (others => (others => X"00"));
begin

process(clk,reset)
begin
    if(reset = '1') then
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00")); 
    elsif(rising_edge(clk)) then
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                mat_A(i)(j)<= A((i*4+j+1)*4-1 downto (i*4+j)*4);
                mat_B(i)(j)<= B((i*4+j+1)*4-1 downto (i*4+j)*4);
            end loop;
        end loop;
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                mat_C(i)(j)<= mat_A(i)(j) + mat_B(i)(j);
            end loop;
        end loop;
        for i in 0 to 127 loop
            if(i<16) then
                C(i downto (i-1)) <= mat_C(0)(15-i);
            elsif(i<32) then
                C(i downto (i-1)) <= mat_C(0)(31- (i mod 16));
            elsif(i<48) then
                C(i downto (i-1)) <= mat_C(1)(15- (i mod 16));
            else
                C(i downto (i-1)) <= mat_C(1)(31- (i mod 16));
            end if;
            if(i=127) then
                done<='1';
            end if;
        end loop;
    end if;
end process;


            
end Behavioral;

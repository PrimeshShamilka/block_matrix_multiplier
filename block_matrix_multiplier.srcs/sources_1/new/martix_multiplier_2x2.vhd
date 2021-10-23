
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mat_mul_2x2 is
port(   clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A,B: in unsigned(31 downto 0);
        C: out unsigned(31 downto 0);
        done:out std_logic
        );
end mat_mul_2x2;

architecture Behavioral of mat_mul_2x2 is
type row_2x2 is array (0 to 1) of unsigned (7 downto 0);
type mat_2x2 is array (0 to 1) of row_2x2;
signal mat_A,mat_B,mat_C: mat_2x2 := (others => (others => X"00"));
begin

process(clk,reset)
begin
    if (reset = '1') then
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00"));
    elsif(rising_edge(clk)) then
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                mat_A(i)(j)<= A(((i*2+j+1)*8-1) downto ((i*2+j)*8));
                mat_B(i)(j)<= B(((i*2+j+1)*8-1) downto ((i*2+j)*8));
            end loop;
        end loop;
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                mat_C(i)(j)<= mat_A(i)(0)*mat_B(0)(j) + mat_A(i)(1)*mat_B(1)(j);
            end loop;
        end loop;
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                C((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_C(i)(j);
                C((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_C(i)(j);
            end loop;
--            if(i=31) then
--                done<='1';
--            end if;
        end loop;
--        for i in 0 to 31 loop
--            if(i<8) then
--                C(i downto (i-1)) <= mat_C(0)(0)(7-i);
--            elsif(i<16) then
--                C(i downto (i-1)) <= mat_C(0)(15- (i mod 8));
--            elsif(i<24) then
--                C(i downto (i-1)) <= mat_C(1)(7- (i mod 8));
--            else
--                C(i downto (i-1)) <= mat_C(1)(15- (i mod 8));
--            end if;
--            if(i=31) then
--                done<='1';
--            end if;
--        end loop;
    end if;
end process;


            
end Behavioral;

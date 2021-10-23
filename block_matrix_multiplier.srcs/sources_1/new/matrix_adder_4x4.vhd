
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mat_add_4x4 is
port(   clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(127 downto 0);
        C: out unsigned(127 downto 0);
        done:inout std_logic
        );
end mat_add_4x4;

architecture Behavioral of mat_add_4x4 is
type row_4x4 is array (0 to 3) of unsigned (7 downto 0);
type mat_4x4 is array (0 to 3) of row_4x4;
signal mat_A,mat_B,mat_C: mat_4x4 := (others => (others => X"00"));
type state_type is (readA,readB,add);
signal state : state_type := readA;

begin

process(clk,reset)
begin
    
    if(reset = '1') then
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00")); 
        done <= '0';
    elsif(rising_edge(clk)) then
        case state is 
            when readA =>
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        mat_A(i)(j)<= A((i*4+j+1)*8-1 downto (i*4+j)*8);
                    end loop;
                end loop;
                state<=readB;
            when readB =>
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        mat_B(i)(j)<= A((i*4+j+1)*8-1 downto (i*4+j)*8);
                    end loop;
                end loop;
                state<=add;
           when add =>
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        mat_C(i)(j)<= to_unsigned(to_integer(mat_A(i)(j)) + to_integer(mat_B(i)(j)),8);
                    end loop;
                end loop;
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        C((i*4+j+1)*8-1 downto (i*4+j)*8) <= mat_C(i)(j);
                    end loop;
                end loop;
                done<='1';
           end case;
    end if;
end process;


            
end Behavioral;

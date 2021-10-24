
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mat_buf_8x8 is
port(   clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A: in unsigned(127 downto 0);
        E: out unsigned(511 downto 0);
        done:out std_logic
        );
end mat_buf_8x8;

architecture Behavioral of mat_buf_8x8 is
type row_4x4 is array (0 to 3) of unsigned (7 downto 0);
type mat_4x4 is array (0 to 3) of row_4x4;
signal mat_A,mat_B,mat_C,mat_D: mat_4x4 := (others => (others => X"00"));
type row_8x8 is array (0 to 7) of unsigned (7 downto 0);
type mat_8x8 is array (0 to 7) of row_8x8;
signal mat_E: mat_8x8 := (others => (others => X"00"));
type state_type is (init,readA,readB,readC,readD,combine);
signal state : state_type := init;
begin

process(clk,reset)
begin
    if(reset = '1') then
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00")); 
        mat_C <= (others => (others => X"00")); 
        mat_D <= (others => (others => X"00")); 
        done <= '0';
    elsif(rising_edge(clk)) then
        case state is 
            when init=>
                done <= '0';
                state<=readA;
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
                state<=readC;
            when readC =>
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        mat_C(i)(j)<= A((i*4+j+1)*8-1 downto (i*4+j)*8);
                    end loop;
                end loop;
                state<=readD;
            when readD =>
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        mat_D(i)(j)<= A((i*4+j+1)*8-1 downto (i*4+j)*8);
                    end loop;
                end loop;
                state<=combine;
            when combine =>
                for i in 0 to 3 loop
                    for j in 0 to 3 loop
                        mat_E(i)(j)     <= mat_A(i)(j);
                        mat_E(i)(j+4)   <= mat_B(i)(j);
                        mat_E(i+4)(j)   <= mat_C(i)(j);
                        mat_E(i+4)(j+4) <= mat_D(i)(j);
                    end loop;
                end loop;
                for i in 0 to 7 loop
                    for j in 0 to 7 loop
                        E((i*8+j+1)*8-1 downto (i*8+j)*8) <= mat_E(i)(j);
                    end loop;
                end loop;
                done<='1';
        end case;
    end if;
end process;


            
end Behavioral;
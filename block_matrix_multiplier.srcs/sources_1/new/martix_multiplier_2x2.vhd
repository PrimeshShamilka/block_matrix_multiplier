
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
type state_type is (init,do_mult);
signal state : state_type := init;

begin

process(clk,reset)
--variable temp : unsigned(7 downto 0) := (others => '0');
begin
    if (reset = '1') then
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00"));
    elsif(rising_edge(clk)) then
        case state is
            when init=>
                for i in 0 to 1 loop
                    for j in 0 to 1 loop
                        mat_A(i)(j)<= A(((i*2+j+1)*8-1) downto ((i*2+j)*8));
                        mat_B(i)(j)<= B(((i*2+j+1)*8-1) downto ((i*2+j)*8));
                    end loop;
                end loop;
                state<=do_mult;
            when do_mult=>
                
                for i in 0 to 1 loop
                    for j in 0 to 1 loop
                        mat_C(i)(j)<= to_unsigned(to_integer(mat_A(i)(0))*to_integer(mat_B(0)(j)),8)+to_unsigned(to_integer(mat_A(i)(1))*to_integer(mat_B(1)(j)),8);
--                         + mat_A(i)(1)*to_integer(mat_B(1)(j));
--                        mat_C(i)(j)<= to_unsigned(mat_B(i)(j)(7 downto 0),8)*to_unsigned(mat_A(i)(j)(7 downto 0),8);
                    end loop;
                end loop;
                for i in 0 to 1 loop
                    for j in 0 to 1 loop
                        C((i*2+j+1)*8-1 downto (i*2+j)*8) <= mat_C(i)(j);
                    end loop;
                end loop;
                done<='1';
          end case;
    end if;
end process;


            
end Behavioral;

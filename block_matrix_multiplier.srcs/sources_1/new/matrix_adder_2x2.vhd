
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mat_add_2x2 is
port(   clk: in std_logic; 
        reset: in std_logic;
        enable: in std_logic;
        A,B: in unsigned(31 downto 0);
        C: out unsigned(31 downto 0);
        done:out std_logic
        );
end mat_add_2x2;

architecture Behavioral of mat_add_2x2 is
type row_2x2 is array (0 to 1) of unsigned (7 downto 0);
type mat_2x2 is array (0 to 1) of row_2x2;
signal mat_A,mat_B,mat_C: mat_2x2 := (others => (others => X"00"))
begin

process(clk,reset)
begin
    if(reset = '1') then
        mat_A <= (others => (others => X"00")); 
        mat_B <= (others => (others => X"00")); 
        done <= '0';
    elsif(rising_edge(clk)) then
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                mat_A(i)(j)<= A((i*2+j+1)*2-1 downto (i*2+j)*2);
                mat_B(i)(j)<= B((i*2+j+1)*2-1 downto (i*2+j)*2);
            end loop;
        end loop;
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                mat_C(i)(j)<= mat_A(i)(j) + mat_B(i)(j);
            end loop;
        end loop;
        for i in 0 to 31 loop
            if(i<8) then
                C(i) = matC(0)(7-i)
            elsif(i<16) then
                C(i) = matC(0)(15- (i mod 8))
            elsif(i<24) then
                C(i) = matC(1)(7- (i mod 8))
            else
                C(i) = matC(1)(15- (i mod 8))
            end if;
            if(i==31) then
                done<=not done;
            end if;
        end loop;
    end if;
end process;


            
end Behavioral;

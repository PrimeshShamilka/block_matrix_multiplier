----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2021 04:32:07 PM
-- Design Name: 
-- Module Name: dpram - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dual_port_ram is
port(   clk: in std_logic; --clock
        wr_en : in std_logic;   --write enable for port 0
        data_in : in std_logic_vector(7 downto 0);  --Input data to port 0.
        addr_in_0 : in std_logic_vector(3 downto 0);    --address for port 0
        addr_in_1 : in std_logic_vector(3 downto 0);    --address for port 1
        port_en_0 : in std_logic;   --enable port 0.
        port_en_1 : in std_logic;   --enable port 1.
        data_out_0 : out std_logic_vector(7 downto 0);  --output data from port 0.
        data_out_1 : out std_logic_vector(7 downto 0)   --output data from port 1.
    );
end dual_port_ram;

architecture Behavioral of dual_port_ram is

--type and signal declaration for RAM.
type ram_type is array(0 to 15) of std_logic_vector(7 downto 0);
signal ram : ram_type := (others => (others => '0'));

begin

process(clk)
begin
    if(rising_edge(clk)) then
        --For port 0. Writing.
        if(port_en_0 = '1') then    --check enable signal
            if(wr_en = '1') then    --see if write enable is ON.
                ram(conv_integer(addr_in_0)) <= data_in;
            end if;
        end if;
    end if;
end process;

--always read when port is enabled.
data_out_0 <= ram(conv_integer(addr_in_0)) when (port_en_0 = '1') else
            (others => 'Z');
data_out_1 <= ram(conv_integer(addr_in_1)) when (port_en_1 = '1') else
            (others => 'Z');
            
end Behavioral;

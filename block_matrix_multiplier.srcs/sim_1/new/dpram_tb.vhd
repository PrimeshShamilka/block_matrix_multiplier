----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2021 04:34:01 PM
-- Design Name: 
-- Module Name: dpram_tb - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dpram_tb is
--  Port ( );
end dpram_tb;

architecture Behavioral of dpram_tb is
    COMPONENT dual_port_ram
PORT(
     clk : IN  std_logic;
     wr_en : IN  std_logic;
     data_in : IN  std_logic_vector(7 downto 0);
     addr_in_0 : IN  std_logic_vector(3 downto 0);
     addr_in_1 : IN  std_logic_vector(3 downto 0);
     port_en_0 : IN  std_logic;
     port_en_1 : IN  std_logic;
     data_out_0 : OUT  std_logic_vector(7 downto 0);
     data_out_1 : OUT  std_logic_vector(7 downto 0)
    );
END COMPONENT;


--Inputs
signal clk : std_logic := '0';
signal wr_en : std_logic := '0';
signal data_in : std_logic_vector(7 downto 0) := (others => '0');
signal addr_in_0 : std_logic_vector(3 downto 0) := (others => '0');
signal addr_in_1 : std_logic_vector(3 downto 0) := (others => '0');
signal port_en_0 : std_logic := '0';
signal port_en_1 : std_logic := '0';
--Outputs
signal data_out_0 : std_logic_vector(7 downto 0);
signal data_out_1 : std_logic_vector(7 downto 0);
-- Clock period definitions
constant clk_period : time := 10 ns;

BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: dual_port_ram PORT MAP (
      clk => clk,
      wr_en => wr_en,
      data_in => data_in,
      addr_in_0 => addr_in_0,
      addr_in_1 => addr_in_1,
      port_en_0 => port_en_0,
      port_en_1 => port_en_1,
      data_out_0 => data_out_0,
      data_out_1 => data_out_1
    );

-- Clock process definitions
clk_process :process
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

-- Stimulus process
stim_proc: process
begin        
    --these 4 lines shows that when port is not enabled, we cannot perform write or read operation.
    port_en_0 <= '0';
    wr_en <= '1';
    data_in <= X"FF";
    addr_in_0 <= X"1";  
    wait for 20 ns;
    --Write all the locations of RAM
    port_en_0 <= '1';   
    for i in 1 to 16 loop
        data_in <= conv_std_logic_vector(i,8);
        addr_in_0 <= conv_std_logic_vector(i-1,4);
        wait for 10 ns;
    end loop;
    wr_en <= '0';
    port_en_0 <= '0';   
    --Read from port 1, all the locations of RAM.
    port_en_1 <= '1';   
    for i in 1 to 16 loop
        addr_in_1 <= conv_std_logic_vector(i-1,4);
        wait for 10 ns;
    end loop;
    port_en_1 <= '0';   
    --Wait eternally.
  wait;
end process;


end Behavioral;

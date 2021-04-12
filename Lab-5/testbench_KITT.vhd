--testbench_KITT.vhd
library ieee;
use ieee.std_logic_1164.all;

entity testbench_KITT is
end testbench_KITT;


architecture testbench of testbench_KITT is
	
	component KITT is
	  port(
			clock : in std_logic;
			I : in std_logic_vector(9 downto 0);				--parallel inputs I9 - I0
			LEDs : out std_logic_vector(9 downto 0)
		);
	end component; --KITT
	
	constant ClockFrequency : integer := 50E6 ; --50MHz
	constant ClockPeriod : time := 1000ms / ClockFrequency;
	
	signal CLK : std_logic := '1';
	
	signal I : std_logic_vector(9 downto 0) := "0111111111" ;
	signal A : std_logic_vector(9 downto 0) ; -- := "1111111111" ;
	
	begin
		CLK <= not CLK after CLockPeriod / 2;
		
		I <="0111111111" after ClockPeriod * 3;
	
		KITT_0 : KITT port map(CLK, I, A);
end architecture testbench;
	
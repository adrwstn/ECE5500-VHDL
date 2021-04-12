--KITT.vhd
library ieee;
use ieee.std_logic_1164.all;

entity KITT is
  port(
    clock : in std_logic;
    I : in std_logic_vector(9 downto 0);				--parallel inputs I9 - I0
    LEDs : out std_logic_vector(9 downto 0)
  ) ;
end KITT ;

architecture lights of KITT is

	component UniveralShiftRegister_10bit is
		port(
			CLK	: in std_logic;							-- clock
			MD		: in std_logic_vector (1 downto 0);	-- mode of operation ( hold [00] | right-shift [01] | left-shift [10] | parallel load [11] )
			I 		: in std_logic_vector (9 downto 0);	-- parallel load inputs
			A		: out std_logic_vector (9 downto 0)	-- to LED array
		);
	end component; --UniveralShiftRegister_10bit

	component Controller is
		port(
			Observers: in std_logic_vector (9 downto 0);
			MODE : out std_logic_vector (1 downto 0)
		) ;
	end component; --Controller

	signal mode : std_logic_vector(1 downto 0) := "11";
	signal to_leds : std_logic_vector(9 downto 0) := "1111111111";
begin
	
	CU : Controller port map(I, mode);
	USR_10b : UniveralShiftRegister_10bit port map(clock, mode, I, to_leds);
	
	LEDs <= to_leds;

end architecture ; -- lights

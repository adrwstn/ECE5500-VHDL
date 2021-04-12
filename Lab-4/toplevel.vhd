-- toplevel.vhd
library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
  port (
    SW : in std_logic_vector (3 downto 0);
--    LEDR : out std_logic_vector (9 downto 0);
--	 HEX0, HEX1: out std_logic_vector (6 downto 0) 
	HEX0 : out std_logic_vector (6 downto 0) 
--	HEX1 : out std_logic_vector (6 downto 0) 
  ) ;
end entity toplevel;

architecture top of toplevel is

	component sevenSegmentDecoder
		port (
			B3, B2, B1, B0 : in std_logic;
			Segments : out std_logic_vector (6 downto 0)
		) ;
	end component;

--    signals 

begin
	display0 : sevenSegmentDecoder port map( SW(3), SW(2), SW(1), SW(0), HEX0 );
--	display1 : sevenSegmentDecoder port map( SW(7), SW(6), SW(5), SW(4), HEX1 );

end top ; -- top

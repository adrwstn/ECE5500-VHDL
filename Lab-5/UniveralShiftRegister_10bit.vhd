--UniveralShiftRegister_10bit.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;

entity UniveralShiftRegister_10bit is
	port(
			CLK	: in std_logic;							-- clock
			MD		: in std_logic_vector (1 downto 0);	-- mode of operation ( hold [00] | right-shift [01] | left-shift [10] | parallel load [11] )
			I 		: in std_logic_vector (9 downto 0);	-- parallel load inputs
			A		: out std_logic_vector (9 downto 0)	-- to LED array
		);

end entity;

architecture behaviour of UniveralShiftRegister_10bit is

	signal internal_I : std_logic_vector(9 downto 0) := I; -- used to represent 'cells' of register	
	
begin
	sequential : process( CLK )
	begin
--		if (CLK'event and CLK='1' ) then
		if rising_edge(CLK) then
			case  MD  is
				when "11" => internal_I <= I ;--load
				when "01" =>internal_I <= I; --shift-right					
						internal_I <= '1' & internal_I(9 downto 1);
				when "10" => internal_I <= I;					--left-shift
						internal_I <= internal_I(8 downto 0) & '1';
				when "00" => internal_I <= I;
								--shouldn't get here
			end case ;
		end if ;	--rising_edge(CLK)
		
	end process ; -- sequential
--	internal_I <= "1010101011"; --test
	A <= internal_I;
end behaviour;



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

	type state_type is (S0, S1, S2);
	signal state : state_type := S0;
	
	signal internal_I : std_logic_vector(9 downto 0) := I; -- used to represent 'cells' of register

	function is_all(vec : std_logic_vector; val : std_logic) return boolean is
		constant all_bits : std_logic_vector(vec'range) := (others => val);
		begin
			return vec = all_bits;
	end function; --is_all()
	
	constant state_trans_delay : time := 100 ms;
	
begin
	sequential : process( CLK )
	begin
	
		if (rising_edge(CLK)) then
			case ( state ) is
				when S0 =>
					if (is_all( internal_I,'1')) then	--if all 'cells' high i.e. all LEDs are off
						state <= S0;				--stay in state S0
						else
							state <= S1;			--move to state S1
					end if;
				
				when S1 =>
					if ( I(0) /= '0' ) then
						internal_I <= '1' & internal_I(8 downto 0) ;	--right-shift
						state <= S1;									--stay in state S1
							else					
								internal_I <= internal_I(8 downto 0) & '1';	--left-shift
								state <= S2;							--move to state S2
					end if ;
				
				when S2 =>
					if ( I(0) /= '0' ) then							--if right-most LED is on
						internal_I <= internal_I(8 downto 0) & '1';	--left-shift
						state <= S2;									--stay in state S2
							else					
								internal_I <= '1' & internal_I(8 downto 0);	--right-shift
								state <= S1;							--move to state S1
					end if ;
			end case ;
		end if ;	--rising_edge(CLK)
		A <= internal_I;
	end process ; -- sequential

end behaviour;



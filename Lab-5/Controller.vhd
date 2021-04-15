--Controller.vhd
library ieee;
use ieee.std_logic_1164.all;

entity Controller is
  port(
    Observers: in std_logic_vector (9 downto 0);
	 MODE : out std_logic_vector (1 downto 0)
  ) ;
end Controller ;

architecture behaviour of Controller is

type state_type is (S0, S1, S2); -- SO=LOAD S1=Shift-right S2=Shift-left

signal state  : state_type;

function is_all(vec : std_logic_vector; val : std_logic) return boolean is
		constant all_bits : std_logic_vector(vec'range) := (others => val);
		begin
			return vec = all_bits;
end function; --is_all()


begin
	setState : process( Observers )
  begin
    if is_all(Observers,'1') then
     state <= S0;
      elsif ( Observers(0) /= '0' )  then
        state <= S1;
			else
				state <= S2;
    end if ;

--  if state = S0 then MODE <= "11";
--	elsif state = S1 then MODE <= "01";
--		elsif state = S2 then MODE <= "10";
--  end if ;
 end process ; -- setState
	
	setMode : process(state)
	begin
		case state is
			when S0 =>
				MODE <= "11";
			when S1 =>
				MODE <= "01";
			when S2 =>
				MODE <= "10";
		end case;
	end process; --setMode
 
end architecture ; -- behaviour

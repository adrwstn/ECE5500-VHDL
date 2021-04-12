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

signal SR_Q : std_logic := '0';
signal LOAD : std_logic := '1';

begin
	setMode : process( Observers )
  begin
    if Observers = "1111111111" then
      LOAD <= '1';
      elsif ( Observers(9) = '0' )  then
        SR_Q <= '0';	-- MODE = shift-right
        LOAD <= '0';
--			elsif ( Observers(0) = '0' ) then
			else
				SR_Q <= '1';	-- MODE = shift-left
				LOAD <= '0';
    end if ;

  if LOAD = '1' then MODE <= "11";
	elsif SR_Q = '0' then MODE <= "01";
		elsif SR_Q = '1' then MODE <= "10";
  end if ;
 end process ; -- setMode

end architecture ; -- behaviour

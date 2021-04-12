-- sevenSegmentDecoder.vhd

library ieee;
use ieee.std_logic_1164.all;

entity sevenSegmentDecoder is
  port (
    B3, B2, B1, B0 : in std_logic;
    Segments : out std_logic_vector (6 downto 0)
  ) ;
end sevenSegmentDecoder ;

architecture segmentBehaviour of sevenSegmentDecoder is

begin
    Segments(6) <= ( (NOT(B3 OR B2 OR B1) ) OR ( (NOT B3) AND B2 AND B1 AND B0) ); 
    Segments(5) <= ( (NOT(B3 OR B2) AND (B1 XOR B0) ) OR ( NOT B3 AND B1 AND B0) OR (B3 AND B2 AND (NOT B1) AND B0) );
    Segments(4) <= ( (NOT B3 AND B0) OR ( (NOT B3) AND B2 AND (NOT B1) ) OR ( (NOT B2) AND (NOT B1) AND B0 ) ) ;
    Segments(3) <= ( (NOT (B3 OR B1 OR B0) AND B2) OR ((NOT B2) AND (NOT B1) AND B0) OR (B2 AND B1 AND B0) OR (B3 AND (NOT B2) AND B1 AND (NOT B0)) );
    Segments(2) <= ( ((B3 AND B2) AND NOT( NOT B1 AND B0)) OR (NOT (B3 OR B2 OR B0) AND B1) );
    Segments(1) <= ( (B3 AND B2 AND NOT B0) OR (B3 AND B1 AND B0) OR (NOT B3 AND B2 AND (B1 XOR B0)) );
    Segments(0) <= ( (B2 AND (NOT (B1 OR B0))) OR (B3 AND B2 AND (NOT B1)) OR (B3 AND (NOT B2) AND B1 AND B0) OR (NOT(B3 OR B2 OR B1) AND B0) );

end segmentBehaviour ; -- segments
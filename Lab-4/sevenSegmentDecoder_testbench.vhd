--sevenSegmentDecoder_testbench.vhd

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity testbench_7segDecoder is
end testbench_7segDecoder;

architecture testbench of testbench_7segDecoder is
	component toplevel is
		port (
			SW : in std_logic_vector (3 downto 0);
			HEX0 : out std_logic_vector (6 downto 0)  
		) ;
	end component;

	signal B3_0 : std_logic_vector (3 downto 0);
	signal segments : std_logic_vector (6 downto 0);
	
begin
	sevenSegDecode : toplevel port map (B3_0, segments);
	
	B3_0 <= "0000",	-- 0
		"0001" after 5 ns,	-- 1
		"0101" after 10 ns, -- 5
		"1011" after 15 ns, -- b
		"1111" after 20 ns; -- F
	
end;


library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Decoder is
	 port(
		 X : in STD_LOGIC_VECTOR(3 downto 0);
		 Y : out STD_LOGIC_VECTOR(6 downto 0)
	     );
	
end Decoder;

architecture Decoder of Decoder is
begin	 
	process(X)  
	begin
	case X is
		when "0000" => Y<="1110111";
		when "0001" => Y<="0100100";
		when "0010" => Y<="1011101";
		when "0011" => Y<="1101101";
		when "0100" => Y<="0101110";
		when "0101" => Y<="1101011";
		when "0110" => Y<="1111011";
		when "0111" => Y<="0100101";
		when "1000" => Y<="1111111"; 
		when "1001" => Y<="1101111";
		when others => Y<="0000000";	
	end case;
	end process;

end Decoder;
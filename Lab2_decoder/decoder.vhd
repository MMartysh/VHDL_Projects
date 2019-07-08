library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity decoder is
	port(X: in std_logic_vector(3 downto 0);
		Y: out std_logic_vector(7 downto 0));
end decoder;


architecture decoder of decoder is
begin
	process(X)
	begin 	  
		case X is
			when "0000" => Y<="11101011";
			when "0001" => Y<="01001000";
			when "0010" => Y<="10111101";
			when "0011" => Y<="11011001";
			when "0100" => Y<="11011010";
			when "0101" => Y<="11010011";
			when "0110" => Y<="11110011";
			when "0111" => Y<="01001001";
			when "1000" => Y<="11111011";
			when "1001" => Y<="11011011";
			when others => Y<="00000000";
		end case;
	end process;

end decoder;

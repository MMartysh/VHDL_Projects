	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.STD_LOGIC_UNSIGNED.all;
	entity RAM_2Kx8 is		
		port(
			A : in std_logic_vector (10 downto 0);
			I_O : inout std_logic_vector (7 downto 0);
			CS : in std_logic;
			OE : in std_logic;
			WE : in std_logic
		);
	end RAM_2Kx8;
	
	architecture RAM_2Kx8 of RAM_2Kx8 is
	type ram2Kx8 is array (2047 downto 0) of std_logic_vector (7 downto 0);	 
	signal RAM	: ram2Kx8;-- <= (others => "0000000");
	begin	   
		process (cs, a, I_O, oe, we)
		begin	   
			if (cs ='1'	or (oe = '1' and we ='1')) then
				I_O <= (others => 'Z'); 
			elsif (cs='0' and oe = '0' and we = '1') then
				I_O <= RAM (conv_integer(A));
			elsif (cs='0' and we = '0')	then
				RAM (conv_integer(A)) <=  I_O;	 
			end if;
		end process;
	end RAM_2Kx8;
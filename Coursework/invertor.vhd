	library IEEE;
	use IEEE.STD_LOGIC_1164.all;  
	entity Inv_9 is		
		port(
			X 	: in  std_logic_vector (7 downto 1);	--Input
			Y   : out std_logic_vector (7 downto 1) );	--Output
	end Inv_9;
	
	architecture Inv_9 of Inv_9 is
	begin	   
		process (X)
		begin	   
			Y<=not(X);
		end process;
	end Inv_9;
	library IEEE;
	
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.STD_LOGIC_UNSIGNED.all;
	
	entity EPROM_64Kx16b is
		port(
		A  : in  std_logic_vector (15 downto 0);
		O  : out std_logic_vector (0 to 15);
		CS : in  std_logic;
		OE : in  std_logic );
	end EPROM_64Kx16b;
	
	architecture EPROM_64Kx16b of EPROM_64Kx16b is
	--type ram2Kx8 is array (2047 downto 0) of std_logic_vector (7 downto 0); 
	--signal RAM: ram2Kx8;-- <= (others => "0000000");
--	constant EROM array  of std_logic
	begin   
		    	  
		O <=	
			"0011011111110000"	when A(3 downto 0) = "0000"	and A(4)='1' else
			"0010011111110001"	when A(3 downto 0) = "0000" and A(4)='0' else
			"0011011111110001"	when A(3 downto 0) = "0001" and A(4)='1' else
			"0001011011110010"	when A(3 downto 0) = "0001" and A(4)='0' else
			"0001001011110011"	when A(3 downto 0) = "0010" else 
			"0001011011110100"	when A(3 downto 0) = "0011" else
			"0011111111110101"	when A(3 downto 0) = "0100" else
			"0011011111110001"	when A(3 downto 0) = "0101" and A(6)='0'else
			"0010011111110110"	when A(3 downto 0) = "0101" and A(6)='1'else
			"0011010111010111"	when A(3 downto 0) = "0110" else 
			"0011010110011000"	when A(3 downto 0) = "0111" else 
			"0011010111011001"	when A(3 downto 0) = "1000" else 
			"0011110111011010"	when A(3 downto 0) = "1001" else 
			"0011011111111011"	when A(3 downto 0) = "1010" else 
			"0011011101111011"	when A(3 downto 0) = "1011" and A(5)='1'else
			"0011011101101100"	when A(3 downto 0) = "1011" and A(5)='0'else
			"0011011110111101"	when A(3 downto 0) = "1100" and A(5)='1'else
			"0011011101101100"	when A(3 downto 0) = "1100" and A(5)='0'else
			"0011011111111110"	when A(3 downto 0) = "1101" else
			"0011111111111111"	when A(3 downto 0) = "1110" else
			"0011010111011010"	when A(3 downto 0) = "1111" and A(6)='0'else
			"0011011111110000"	when A(3 downto 0) = "1111" and A(6)='1'else
			"0011011111110000";	   
	end EPROM_64Kx16b;	   
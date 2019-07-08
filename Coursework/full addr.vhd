	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.STD_LOGIC_UNSIGNED.all;
	entity FULL_ADDR_4 is		   
		port(				 
			Cin  : in  std_logic;
			A 	 : in  std_logic_vector (3 downto 0);
			B 	 : in  std_logic_vector (3 downto 0);
			Cout : out std_logic;
			S	 : out std_logic_vector(3 downto 0));
	end FULL_ADDR_4;
	
	architecture FULL_ADDR_4 of FULL_ADDR_4 is
	signal valS	: std_logic_vector (4 downto 0);-- <= (others => "0000000");
	signal valA	: std_logic_vector (4 downto 0);
	signal valB	: std_logic_vector (4 downto 0);
	begin	  
		process (Cin, A, B)
		begin
			valA <= '0'&A;
			valB <= '0'&B; 
		end process;
		process (Cin, valA, valB)
		begin  
			valS <= valA + valB + Cin;
		end process;			  
		process (valS)
		begin 		 
			S	 <= valS(3 downto 0);
			Cout <=	valS(4);
		end process;
	end FULL_ADDR_4;
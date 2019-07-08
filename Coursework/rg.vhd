	library IEEE;
	use IEEE.STD_LOGIC_1164.all;  
	entity RG_8 is		
		port(
			MR  : in  std_logic; --reset
			CLK : in  std_logic; --clock
			SEL : in  std_logic; --load
			D 	: in  std_logic_vector (7 downto 0);	--Input
			Q   : out std_logic_vector (7 downto 0) );	--Output
	end RG_8;
	
	architecture RG_8 of RG_8 is 
	begin	   
		process (CLK,D)
		begin	   
			if rising_edge(clk) then
				if(MR = '1') then Q <= (others => '0');
				elsif SEL='0' then Q <=D;
		end if;
		end if;
		end process;
	--	process (clk)
	--	begin
	--		Q <=val;
	--	end process;
	end RG_8;
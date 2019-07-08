	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.STD_LOGIC_UNSIGNED.all;
	entity COUNTER_4B is		   
		port(				 
			CLR  : in  std_logic;
			LOAD : in  std_logic;
			ENP  : in  std_logic;
			ENT  : in  std_logic;
			CLK  : in  std_logic;
			D	 : in  std_logic_vector(3 downto 0);
			RCO  : out std_logic;
			Q	 : out std_logic_vector(3 downto 0));
	end COUNTER_4B;
	
	architecture COUNTER_4B of COUNTER_4B is
	signal val	: std_logic_vector (3 downto 0);-- <= (others => "0000000");
	begin	  
		process (clk,clr,load,enp,ent,d)
		begin
			if (clr = '0') then val <="0000";
			elsif (clk'event  and clk = '1') then								 
				if(ENP = '1' and ENT ='1') then val<=val+'1';  
				end if;								  
			elsif (LOAD = '0') then val <= D;
			end if;
		end process;			  
		process (val)
		begin 		 
			Q <= val;
			if (val = "1111") then RCO <= '1';
			else RCO <= '0';				
			end if;
		end process;
		
	end COUNTER_4B;
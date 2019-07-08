library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity p1 is
	 port(
		 Bout : out STD_LOGIC;
		 Ainout : inout STD_LOGIC
	     );
end p1;


architecture p1 of p1 is 
signal CLK: STd_logic:='0';
begin	  
	Pr_CLK: process
	begin	
		wait for 15 ns;
		CLK<= not CLK; 
	  end process Pr_CLK;	
	   
        Pr_A: process
		begin			   
			wait on CLK;
			wait for 20 ns;
		  Ainout<=CLK; 	
        end process Pr_A;  
		
        Pr_B: process
		begin			  		
			wait for 7ns;   
			wait until Ainout'event;
		  Bout<= not Ainout;	
        end process Pr_B;

end p1;



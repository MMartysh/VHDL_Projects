library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftReg is
	 port(
		 CLK : in STD_LOGIC;
		 WE : in STD_LOGIC;
		 RE : in STD_LOGIC;
		 DATA_IN : in STD_LOGIC;
		 DATA_OUT : out STD_LOGIC_VECTOR(0 to 6)
	     );
end ShiftReg;
											
architecture ShiftReg of ShiftReg is 
begin
	
process
variable data: std_logic_vector(0 to 6);
begin	
	
	if WE='1' and RE='0'
		then for i in 6 downto 1 loop
			data(i):=data(i-1);
		end loop;					  				
		data(0):=DATA_IN;
	elsif WE='0' and RE='1' and (data(6)='1' or data(6)='0')
		then  DATA_OUT<=data;	 
	else DATA_OUT<="ZZZZZZZ";
	end if;	
	wait on CLK; 
end process;

end ShiftReg;
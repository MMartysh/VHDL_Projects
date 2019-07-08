library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ParallelReg is
	 port(
		 CLK : in STD_LOGIC;
		 WE : in STD_LOGIC;
		 RE : in STD_LOGIC;
		 DATA_IN : in STD_LOGIC_VECTOR(0 to 9);
		 DATA_OUT : out STD_LOGIC_VECTOR(0 to 9)
	     );
end ParallelReg;
											
architecture ParallelReg of ParallelReg is 
begin
process
variable data: std_logic_vector(0 to 9);
begin			
	if WE='1' and RE='0'
		then data:=DATA_IN; 
	elsif WE='0' and RE='1'
		then  DATA_OUT<=data;
	else DATA_OUT<="ZZZZZZZZZZ";
		end if;
		  wait on CLK; 
end process;

end ParallelReg;
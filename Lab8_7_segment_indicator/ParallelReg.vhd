library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ParallelReg is
	generic (Width:Integer:=31);
	 port(
		 CLK : in STD_LOGIC;
		 RE : in STD_LOGIC;
		 WE : in STD_LOGIC;
		 DATA_IN : in STD_LOGIC_VECTOR(Width downto 0);
		 DATA_OUT : out STD_LOGIC_VECTOR(Width downto 0)
	     );
end ParallelReg;


architecture ParallelReg of ParallelReg is
begin
	process
    variable DATA: STD_LOGIC_VECTOR(Width downto 0); 			   
    begin
            if WE = '1' and RE = '0' then	
                DATA := DATA_IN;	
            elsif WE = '0' and RE = '1' then
                DATA_OUT <= DATA;
            else
                DATA_OUT <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
            end if;
		wait on CLK;
    end process;
end ParallelReg;

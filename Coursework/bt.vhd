	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.STD_LOGIC_UNSIGNED.all;
	entity BT_8 is		
		port(
			A   : inout std_logic_vector (7 downto 0):="ZZZZZZZZ";
			B   : inout std_logic_vector (7 downto 0);
			OE  : in std_logic:='1';
			DIR : in std_logic );
	end BT_8;
	
	architecture BT_8 of BT_8 is
	begin	   
		process (OE, DIR,A,B)
		begin	   
			if (OE = '1') then A <= (others =>'Z');	B <= "ZZZZZZZZ";
			elsif (oe='0' and DIR = '1') then A <=B;
			elsif (oe='0' and dir='0') then B <= A;
			end if;
		end process;
	end BT_8;
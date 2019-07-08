library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX is
	 port(
		 CLK : in STD_LOGIC;
		 X : in STD_LOGIC_VECTOR(31 downto 0);
		 Y7 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y6 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y5 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y4 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y3 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y2 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y1 : out STD_LOGIC_VECTOR(3 downto 0);
		 Y0 : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end MUX;

architecture MUX of MUX is
begin
	 process (X)
	begin
	Y0<=X(3 downto 0);
	Y1<=X(7 downto 4);
	Y2<=X(11 downto 8);
	Y3<=X(15 downto 12);
	Y4<=X(19 downto 16);
	Y5<=X(23 downto 20);
	Y6<=X(27 downto 24);
	Y7<=X(31 downto 28);
	end process;

end MUX;
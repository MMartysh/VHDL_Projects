library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ROM is
	 port(
		 CEO : in STD_LOGIC;
		 Addr : in STD_LOGIC_VECTOR(4 downto 0);
		 Dout : out STD_LOGIC_VECTOR(2 downto 0)
	     );
end ROM;

--}} End of automatically maintained section

architecture ROM of ROM is
begin
	process (Addr)
		type ROM_array is array (31 downto 0) of STD_LOGIC_VECTOR(2 downto 0);
		constant rom_mem:ROM_array := ("000","001","010","011","100","101","110","111",
									   "000","001","010","011","100","101","110","111",
									   "000","001","010","011","100","101","110","111",
									   "000","001","010","011","000","001","010","011"
									   ); 
	begin
		if CEO = '1' then
       		Dout <= rom_mem(Conv_Integer(Addr));
		end if;	
	end process;
	 -- enter your statements here --

end ROM;

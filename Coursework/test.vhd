	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
	use IEEE.STD_LOGIC_UNSIGNED.all;  
	use IEEE.NUMERIC_STD.all; 	
	
	
	entity testbench is
	end entity testbench;
	
	architecture testbench of testbench is
	----------------------------	
	component top_design is 
	port(	
		CLK : in STD_LOGIC;
		RA : in STD_LOGIC;
		WR : in STD_LOGIC;
		RR : out STD_LOGIC;
		WA : out STD_LOGIC;
		DATA_BUS : inout STD_LOGIC_VECTOR (7 downto 0)  );
	end component;
	signal count1,count2 :  integer :=0;
	signal WR,WA,RR,RA, CLK : std_logic:='1';
	signal io : std_logic_vector (7 downto 0):=(others =>'Z');
	signal data : std_logic_vector (7 downto 0):="11110000";  
	type ram32x8 is array (32 downto 0) of std_logic_vector (7 downto 0);
	type ram16x8 is array (10 downto 0) of std_logic_vector (7 downto 0);
	signal calc_val	: ram16x8:=(others =>"00000000");
	signal inpt_val	: ram16x8:=(others =>"00000000");
	type ramx8 is array (26 downto 0) of integer ;
	signal tmp  : ramx8:=(others =>0);

	begin		 
		process
		begin
			wait for 10 ns;
			clk<=not clk;
		end process;
		comp_syst : top_design
		port map(
			CLK=> CLK,
			RR=>RR,
			RA=>RA,
			WR=>WR,	
			WA=>WA,
			DATA_BUS=>IO);
		process	
		begin
			if count1 = 0 then
				wait for 100ns;	
			end if;
			wait for 100ns;
			if(count1<12) 	then
				WR <= '0';
				wait on wa;
				if wa = '0' then
					io <= data - count1*3;
					tmp(count1) <= to_integer(unsigned(data - count1*3));
					count1<=count1 +1;
					wait on wa;
					if wa='1' then 
						io <=(others=>'Z'); 
						wr <='1';
					end if;
				end if;
			end if;
			if(count1 = 12 and count2 <11) then									  
				calc_val(count2)  <= std_logic_vector(to_signed((tmp(count2))/4 - tmp(count2+1)/4 - (tmp(count2+1)/2),8));
				    wait on rr;
				    if rr='0' then
					ra <='0';		 
					wait on io;
					inpt_val(count2) <= io;
					wait on clk;
					wait on clk;
					wait on clk;
					wait on clk;
					ra<='1';
					count2<=count2+1;
				end if;
			end if;
			end process;
	end testbench;
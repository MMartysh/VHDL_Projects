	library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		
	entity top_design is 
	port(	
		CLK : in STD_LOGIC;
		RA : in STD_LOGIC;
		WR : in STD_LOGIC;
		RR : out STD_LOGIC;
		WA : out STD_LOGIC;
		DATA_BUS : inout STD_LOGIC_VECTOR (7 downto 0)	  );
	end entity top_design;
	
	architecture top_design of top_design is
	signal cntrl_signals : std_logic_vector (15 downto 0);
	signal i_o_b 		 : std_logic_vector (7 downto 0);
	signal sram_b		 : std_logic_vector (7 downto 0):="ZZZZZZZZ";
	signal xi1_b		 : std_logic_vector (7 downto 0);
	signal xi_rg_b		 : std_logic_vector (7 downto 0);
	signal xi_sum		 : std_logic_vector (7 downto 0);
	signal xi_s_b		 : std_logic_vector (16 downto 0);
	signal result_b		 : std_logic_vector (7 downto 0);
	signal sram_adr_b	 : std_logic_vector (10 downto 0):="00000000000";
	signal cur_state_b	 : std_logic_vector (15 downto 0):="0000000000000000";
	signal xi1_5_b		 : std_logic_vector (8 downto 0);
	signal xi_crr		 : std_logic;
	signal res_crr		 : std_logic;
	signal RCO			 : std_logic;
	signal inv_clk		 : std_logic;
	constant vcc		 : std_logic :='1';
	constant gnd		 : std_logic :='0';
	signal ggnd 		 : std_logic;
	signal start_reset	 : std_logic :='0';	
	------------------------------------ 
	signal rg_input		 : std_logic_vector (7 downto 0);
	signal Xi1_AddH_A	 : std_logic_vector (3 downto 0);
	signal Xi1_AddH_B	 : std_logic_vector (3 downto 0);
	signal Res_addH		 : std_logic_vector (3 downto 0);
	------------------------------------ 
	component EPROM_64Kx16b is
	  port(
	       	A  : in  std_logic_vector (15 downto 0);
			O  : out std_logic_vector (0 to 15);
			CS : in  std_logic;
			OE : in  std_logic 
		);
	end component;
	------------------------------------
	component BT_8
	  port (
	       DIR : in STD_LOGIC;
	       OE : in STD_LOGIC;
	       A : inout STD_LOGIC_VECTOR(7 downto 0);
	       B : inout STD_LOGIC_VECTOR(7 downto 0)
	  );
	end component;
	------------------------------------
	component COUNTER_4B
	  port (
	       CLK : in STD_LOGIC;
	       CLR : in STD_LOGIC;
	       D : in STD_LOGIC_VECTOR(3 downto 0);
	       ENP : in STD_LOGIC;
	       ENT : in STD_LOGIC;
	       LOAD : in STD_LOGIC;
	       Q : out STD_LOGIC_VECTOR(3 downto 0);
	       RCO : out STD_LOGIC
	  );
	end component;
	------------------------------------
	component FULL_ADDR_4
	  port (
	       A : in STD_LOGIC_VECTOR(3 downto 0);
	       B : in STD_LOGIC_VECTOR(3 downto 0);
	       Cin : in STD_LOGIC;
	       Cout : out STD_LOGIC;
	       S : out STD_LOGIC_VECTOR(3 downto 0)
	  );
	end component;
	------------------------------------
	component Inv_9
	  port (
	       X : in STD_LOGIC_VECTOR(7 downto 1);
	       Y : out STD_LOGIC_VECTOR(7 downto 1)
	  );
	end component;
	------------------------------------
	component RAM_2Kx8
	  port (
	       A : in STD_LOGIC_VECTOR(10 downto 0);
	       CS : in STD_LOGIC;
	       OE : in STD_LOGIC;
	       WE : in STD_LOGIC;
	       I_O : inout STD_LOGIC_VECTOR(7 downto 0)
	  );
	end component;
	------------------------------------
	component RG_8
	  port (
	       CLK : in STD_LOGIC;
	       D : in STD_LOGIC_VECTOR(7 downto 0);
	       MR : in STD_LOGIC;
	       SEL : in STD_LOGIC;
	       Q : out STD_LOGIC_VECTOR(7 downto 0)
	  );
	end component;															   
	--***********************************************************************--
	begin																												  	
	-------------------------------------------------- 
--	process(clk)
--	begin
--		if not(start_reset = '1') then
--			cur_state_b<=(others =>'0');
--			start_reset <='1';
--		end if;
--	end	process;	
	-------------------------------------------------- 
	process (clk)
	begin
		inv_clk <=not clk;
	end process;		  
	-------------------------------------------------- 
	process (cntrl_signals)
	begin
		WA<=cntrl_signals(8);
		RR<=cntrl_signals(7);
	end process;
	-------------------------------------------------- 
	process (RCO , RA , WR , cntrl_signals (3 downto 0))
	begin			
		rg_input <=	('0' & RCO & RA & WR & cntrl_signals (3 downto 0));
	end process;
	DD1_st_reg : rg_8
	port map(
		CLK => CLK,
		D	=> rg_input,  
		MR  => GND,
		SEL	=> GND,
		Q 	=> cur_state_b (7 downto 0));
	--------------------------------------------------
	DD2_eprom : EPROM_64Kx16b
	port map(
		A  => cur_state_b,
		O  => cntrl_signals,
		cs => gnd,
		oe => gnd);
	--------------------------------------------------
	DD3_adr_counter :  COUNTER_4B
	port map(
		CLK  => cntrl_signals(11),
		CLR  => VCC,
		D    => "0011",
		ENP  => VCC,
		ENT  => VCC,
		LOAD => cntrl_signals(12),
		Q 	 =>	sram_adr_b(3 downto 0),
		RCO  =>	RCO);
	--------------------------------------------------
	DD4_sram : RAM_2Kx8
	port map(
		A 	=> sram_adr_b,
		CS 	=> GND,
		OE  => cntrl_signals(9),
		WE  => cntrl_signals(10),
		I_O => sram_b);
	--------------------------------------------------
	DD5_bt_inp : BT_8
	port map(
		DIR => GND,
		OE  => cntrl_signals(13),
		A 	=> data_bus,
		B 	=> sram_b);
	--------------------------------------------------
	DD6_Xi1_reg : RG_8
	port map(
		CLK => inv_clk,
		D 	=> sram_b,
		MR 	=> GND,
		SEL => cntrl_signals(5),
		Q 	=> xi1_b);
	--------------------------------------------------
	DD7_Xi_reg : RG_8
	port map(
		CLK => inv_clk,
		D 	=> xi1_b,
		MR 	=> GND,
		SEL => cntrl_signals(6),
		Q 	=> xi_rg_b);						 
		-------------------------------------------------- 
	DD8_inv : Inv_9
	port map(
		X(7 downto 1) => xi1_b(7 downto 1),		 
		Y(7 downto 1) => xi_sum (7 downto 1));
	--------------------------------------------------
	DD9_Xi_addL : FULL_ADDR_4
	port map(
		A 	 => xi_rg_b(5 downto 2),
		B 	 => xi_sum(4 downto 1),
		Cin	 => VCC,
		Cout => xi_crr,
		S	 => xi_s_b(3 downto 0));
	-------------------------------------------------- 
	DD10_Xi_addH : FULL_ADDR_4
	port map(
		A(3) => '0',
		A(2) => '0',
		A(1) => xi_rg_b(7),
		A(0) => xi_rg_b(6),
		B(3) => '1',
		B(2) => xi_sum(7),
		B(1) => xi_sum(6),
		B(0) => xi_sum(5),	
		Cin  => xi_crr,
		Cout => ggnd,
		S 	 => xi_s_b(7 downto 4));
	--------------------------------------------------
	DD11_Res_addL : FULL_ADDR_4
	port map(
		A 	 => xi_s_b(3 downto 0),
		B 	 => xi_sum(5 downto 2),
		Cin	 => VCC,
		Cout => res_crr,
		S	 => result_b(3 downto 0));
	--------------------------------------------------
	process (xi_rg_b)
	begin		
		Res_addH<="000" & xi_rg_b(7);
	end process;
	--------------------------------------------------
	DD12_Res_addH : FULL_ADDR_4
	port map(
		A    => xi_s_b(7 downto 4),
		B(3) => '1',
		B(2) => '1',
		B(1) => xi_sum(7),
		B(0) => xi_sum(6),
		Cin  => res_crr,
		Cout => ggnd,
		S 	 => result_b(7 downto 4));
	--------------------------------------------------
	DD13_bt_out : BT_8
	port map(
		DIR => GND,
		OE  => cntrl_signals(4),
		A 	=> result_b,
		B 	=> data_bus);
	--------------------------------------------------
	end architecture top_design; 
	
	
	
	
	
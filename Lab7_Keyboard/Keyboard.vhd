	  -------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : lab7
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\lab7\lab7\compile\Keyboard.vhd
-- Generated   : 04/19/18 10:48:57
-- From        : c:\My_Designs\lab7\lab7\src\Keyboard.asf
-- By          : FSM2VHDL ver. 5.0.7.2
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Keyboard is 
	port (
		CLK: in STD_LOGIC;
		ret: in STD_LOGIC_VECTOR (3 downto 0);
		KeyCode: out STD_LOGIC_VECTOR (7 downto 0);
		Strobe: out STD_LOGIC;
		Scan: inout STD_LOGIC_VECTOR (3 downto 0));
end Keyboard;

architecture Keyboard of Keyboard is

-- diagram signals declarations
signal Cond: STD_LOGIC;

-- SYMBOLIC ENCODED state machine: Sreg0
type Sreg0_type is (
    S1, S2, S3, S4, S5, S0
);
-- attribute enum_encoding of Sreg0_type: type is ... -- enum_encoding attribute is not supported for symbolic encoding

signal Sreg0: Sreg0_type;

begin


----------------------------------------------------------------------
-- Machine: Sreg0
----------------------------------------------------------------------
Sreg0_machine: process (CLK)
begin
	if CLK'event and CLK = '1' then
		-- Set default values for outputs, signals and variables
		Cond <= (Ret(0) or Ret(1) or Ret(2) or Ret(3));
		case Sreg0 is
			when S1 =>
				Scan <= "0001";
				if Cond = '0' then	
					Sreg0 <= S2;
				elsif Cond = '1' then	
					Sreg0 <= S5;
				end if;
			when S2 =>
				Scan <= "0010";
				if Cond = '0' then	
					Sreg0 <= S3;
				elsif Cond = '1' then	
					Sreg0 <= S5;
				end if;
			when S3 =>
				Scan <= "0100";
				if Cond = '0' then	
					Sreg0 <= S4;
				elsif Cond = '1' then	
					Sreg0 <= S5;
				end if;
			when S4 =>
				Scan <= "1000";
				if Cond = '1' then	
					Sreg0 <= S5;
				elsif Cond = '0' then	
					Sreg0 <= S0;
				end if;
			when S5 =>
				Strobe <= '1';
				if Cond = '0' then	
					Sreg0 <= S0;
				elsif Cond = '1' then	
					Sreg0 <= S5;
				end if;
			when S0 =>
				Scan <= "1111";
				Strobe <= '0';
				if Cond='0' then	
					Sreg0 <= S0;
				elsif Cond = '1' then	
					Sreg0 <= S1;
				end if;
--vhdl_cover_off
			when others =>
				null;
--vhdl_cover_on
		end case;
	end if;
end process;

-- signal assignment statements for combinatorial outputs
KeyCode_assignment:
KeyCode <= Ret&Scan when (Sreg0 = S5) else
           "00000000" when (Sreg0 = S0) else
           "00000000";

end Keyboard;

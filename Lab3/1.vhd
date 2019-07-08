-------------------------------------------------------------------------------
--
-- Title       : \1\
-- Design      : l3
-- Author      : 007
-- Company     : AA
--
-------------------------------------------------------------------------------
--
-- File        : 1.vhd
-- Generated   : Tue Mar  6 14:38:27 2018
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {\1\} architecture {\1\}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity \1\ is  
port( X: in std_logic_vector(2 downto 0);
Y: out std_logic);
end \1\;

--}} End of automatically maintained section

architecture \1\ of \1\ is
signal a: std_logic;
signal b: std_logic;
signal c:std_logic;
signal d: std_logic;
signal e: std_logic;
signal f:std_logic;
signal Y1: std_logic;
begin
process(X)
begin			
	a<=transport not(X(0)) after 5ns;
	b<=transport a or X(1) after 10ns;
	c<=transport a nor X(2) after 10ns;
	d<=transport b and c after 10ns;
	e<=transport c xnor X(2) after 10ns;
	f<=transport b xor d after 10ns;
	Y1<=transport e nand f after 10ns;
end process;
Y<=Y1;
end \1\;

-- PB - PIN144
-- LEDs - PIN3, PIN7, PIN9

-- attribute altera_chip_pin_lc : string; 
-- attribute altera_chip_pin_lc of <port name> : signal is "@<pin number(s)>"

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY PB IS
	PORT
	(
		PB1	: IN	STD_LOGIC;
		LED1	: OUT	STD_LOGIC;
		LED2	: OUT	STD_LOGIC;
		LED3	: OUT STD_LOGIC;
--		DEBUG : OUT STD_LOGIC;
		CLK   : IN STD_LOGIC
	);
END PB;

ARCHITECTURE behavioral OF PB IS
signal DPB1 : STD_LOGIC;
signal COUNT : STD_LOGIC_VECTOR(25 DOWNTO 0) := (others=>'0');
signal CLK_FAST : STD_LOGIC;
BEGIN
	PLL_INSTANCE: entity work.pll port map(CLK, CLK_FAST);
	DEBOUNCE_PB1: entity work.debounce port map(clock=>CLK, button=>PB1, result=>DPB1);
	LED1 <= NOT COUNT(23);
	LED2 <= NOT COUNT(24);
	LED3 <= NOT COUNT(25);
	-- DEBUG <= DPB1;
	process(CLK_FAST)
	begin 
		if(CLK_FAST'Event and CLK_FAST = '0') then
			COUNT <= COUNT + 1;
			if (DPB1 = '0') then
				COUNT <= COUNT + 3;
			end if;
		end if;
	end process;
END behavioral;

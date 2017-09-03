LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;
use ieee.std_logic_unsigned.all;

ENTITY debounce IS
  GENERIC( clock_rate 	   : REAL := 50000000.0;
			  debounce_period : REAL := 0.020 );
  PORT( clock  : IN  STD_LOGIC; 
        button : IN  STD_LOGIC;
        result : OUT STD_LOGIC );
END debounce;

ARCHITECTURE behavioral OF debounce IS
  SIGNAL   prev : STD_LOGIC;
  CONSTANT num_bits_counter : NATURAL := 1+natural(ceil(log2( clock_rate * debounce_period) ));
  SIGNAL   count : STD_LOGIC_VECTOR(num_bits_counter-1 downto 0) := (others=>'0');
BEGIN
  PROCESS(clock)
  BEGIN
    IF(rising_edge(clock)) THEN
      IF(prev/=button) THEN
        count <= (others=>'0');
		  prev <= button;
      ELSIF(std_logic_vector(count)(count'length-1) = '0') THEN
        count <= count + 1;
      ELSE
        result <= prev;
      END IF;    
    END IF;
  END PROCESS;
END behavioral;

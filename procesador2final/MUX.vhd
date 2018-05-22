
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX is
    Port ( CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           outSEU : in  STD_LOGIC_VECTOR (31 downto 0);
           I : in  STD_LOGIC;
           outMUX : out  STD_LOGIC_VECTOR(31 downto 0));
end MUX;

architecture Behavioral of MUX is

begin

PROCESS (CRS2, outSEU, I) IS
       BEGIN
         if(I = '0')then 
				outMux <= CRS2;
				else 
				outMux <= outSEU;
			end if;
		end process;

end Behavioral;

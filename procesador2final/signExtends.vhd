
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity signExtends is
    Port ( entrada13 : in  STD_LOGIC_VECTOR (12 downto 0);
           salida32 : out  STD_LOGIC_VECTOR (31 downto 0));
end signExtends;

architecture Behavioral of signExtends is

begin
process(entrada13)
	begin
		if(entrada13(12) = '1')then
			salida32(12 downto 0) <= entrada13;
			salida32(31 downto 13) <= (others=>'1');
		else
			salida32(12 downto 0) <= entrada13;
			salida32(31 downto 13) <= (others=>'0');
		end if;
	end process;

end Behavioral;
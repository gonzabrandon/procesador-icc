library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ALU is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 DOWNTO 0);
           CRS1 : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           CRS2 : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  C : in STD_LOGIC;
           DWR : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
end ALU;

architecture Behavioral of ALU is

begin

PROCESS (ALUOP,CRS1,CRS2) IS
	BEGIN 
		CASE ALUOP IS
			WHEN "000001" => DWR <= CRS1 AND CRS2;				--AND
			WHEN "000101" => DWR <= CRS1 AND NOT CRS2;		--ANDN
			WHEN "000010" => DWR <= CRS1 OR CRS2;				--OR
			WHEN "000110" => DWR <= CRS1 OR NOT CRS2;			--ORN
			WHEN "000011" => DWR <= CRS1 XOR CRS2;				--XOR	
			WHEN "000111" => DWR <= NOT(CRS1 XOR CRS2);		--XNOR
			WHEN "000000" => DWR <= CRS1 + CRS2;        		--ADD
			WHEN "000100" => DWR <= CRS1 - CRS2;         	--SUB
			WHEN "010000" => DWR <= CRS1 + CRS2;         	--ADDcc
			WHEN "011000" => DWR <= CRS1 + CRS2 + C;			--ADDXcc
			WHEN "010100" => DWR <= CRS1 - CRS2;         	--SUBcc
			WHEN "011100" => DWR <= CRS1 - CRS2 - C;       	--SUBXcc
			WHEN "111100" => DWR <= CRS1 + CRS2;         	--SAVE
			WHEN "111101" => DWR <= CRS1 + CRS2;         	--RESTORE
			WHEN "010101" => DWR <= CRS1 AND NOT CRS2;		--ANDNcc
			WHEN "010010" => DWR <= CRS1 OR CRS2;				--ORcc
			WHEN "010110" => DWR <= CRS1 OR NOT CRS2;			--ORNcc
			WHEN "010011" => DWR <= CRS1 XOR CRS2;				--XORcc
			WHEN "010111" => DWR <= NOT(CRS1 XOR CRS2);		--XNORcc
						
			WHEN OTHERS   => DWR <= (OTHERS => '0');			
		END CASE;
END PROCESS;

	
end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           RESULT : in  STD_LOGIC_VECTOR (31 downto 0);
           RS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0) := "0000");
end PSRModifier;

architecture Behavioral of PSRModifier is

begin
process(ALUOP,RESULT,RS1,RS2)
	begin
		
		--logicas con cc	
	IF (ALUOP = "010001" OR 
		 ALUOP = "010101" OR
		 ALUOP = "010010" OR
		 ALUOP = "010110" OR
		 ALUOP = "010011" OR
		 ALUOP = "010111" ) THEN
		 
		 NZVC(3) <= Result(31);
		 NZVC(1 DOWNTO 0) <= "00";
	END IF;
		
		IF(ALUOP = "010000" OR ALUOP = "011000") then -- para  addcc y addxcc
			NZVC(3) <= RESULT(31);
			IF RESULT = "00000000000000000000000000000000" THEN
				NZVC(2) <= '1';
			ELSE 
				NZVC(2) <= '0';
			END IF;
			NZVC(1) <= (RS1(31) AND RS2(31) AND (NOT RESULT(31))) OR (RS1(31) AND (NOT RS2(31)) AND RESULT(31));
			NZVC(0) <= (RS1(31) AND RS2(31)) OR ((NOT RESULT(31)) AND (RS1(31) OR RS2(31)));
		END IF;
		
		IF( ALUOP = "010100" OR ALUOP = "011100") THEN -- para subcc y subxcc
			NZVC(3) <= RESULT(31);
			--nzvc <= "1000";
			IF RESULT = "00000000000000000000000000000000" THEN
				NZVC(2) <= '1';
			ELSE 
				NZVC(2) <= '0';
			END IF;
			NZVC(1) <= (RS1(31) AND (NOT RS2(31)) AND (NOT RESULT(31))) OR ((NOT RS1(31)) AND RS2(31) AND RESULT(31));
			NZVC(0) <= ((not RS1(31)) and RS2(31)) or (RESULT(31) and ((not RS1(31)) or RS2(31)));

			
		END IF;
		
		if(ALUOP = "010001" OR ALUOP = "010101" OR ALUOP = "010010" OR ALUOP = "010110" OR ALUOP = "010011" OR ALUOP = "010111") THEN --PARA LAS OPERACIONES LOGICAS ANDCC, ANDNCC, ORCC, ORNCC, XORCC, XNORCC
			
			NZVC(3) <= RESULT(31);
			IF RESULT = "00000000000000000000000000000000" THEN
				NZVC(2) <= '1';
			ELSE 
				NZVC(2) <= '0';
			END IF;
				NZVC(1) <= '0';
				NZVC(0) <= '0';
			
		END IF;
	end process;

end Behavioral;

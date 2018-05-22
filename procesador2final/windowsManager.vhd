library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity windowsManager is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (4 downto 0);
           nCWP : out  STD_LOGIC_VECTOR (4 downto 0):="00000";
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRD : out  STD_LOGIC_VECTOR (5 downto 0));
end windowsManager;

architecture Behavioral of windowsManager is
	signal RS1Temp,RS2Temp,RDTemp: integer range 0 to 39:=0;
	signal auxRegistroO7 : std_logic_vector(6 downto 0);
	signal aux_nCWP : std_logic_vector(4 downto 0);
begin

	process(RS1,RS2,RD,CWP,OP,OP3)
	begin
	
	if((OP = "10" and OP3 = "111100")and (CWP = "00001"))then--SAVE
				nCWP <= CWP - "00001";
				aux_nCWP <= CWP - "00001";
			elsif(OP = "10" and OP3 = "111101")and(CWP = "00000")then--RESTORE
					nCWP <= CWP + "00001";
					aux_nCWP <= CWP + "00001";
			end if;
		
	
	if(RS1>="00000" and RS1<="00111") then --0a7 Globales
			RS1Temp <= conv_integer(RS1);
		else
			if(RS1>="11000" and RS1<="11111") then --24a31 ins
				RS1Temp <= conv_integer(RS1)-(conv_integer(CWP)*16);
			else
				if(RS1>="10000" and RS1<="10111") then --16a23 Locales
					RS1Temp <= conv_integer(RS1)+(conv_integer(CWP)*16);
				else
						if(RS1>="01000" and RS1<="01111") then --8a15 OUTs
							RS1Temp <= conv_integer(RS1)+ (conv_integer(CWP)*16);
						end if;
				end if;
			end if;
		end if;
		
		
	
		if(RS2>="00000" and RS2<="00111") then
			RS2Temp <= conv_integer(RS2);
		else
			if(RS2>="11000" and RS2<="11111") then
				RS2Temp <= conv_integer(RS2) - (conv_integer(CWP)*16);
			else
				if(RS2>="10000" and RS2<="10111") then
					RS2Temp <= conv_integer(RS2)+ (conv_integer(CWP)*16);
				else
					if(RS2>="01000" and RS2<="01111") then
						RS2Temp <= conv_integer(RS2)+ (conv_integer(CWP)*16);
						end if;
					end if;
				end if;
			end if;
		

		
		if(RD>="00000" and RD<="00111") then
			RDTemp <= conv_integer(RD);
		else
			if(RD>="11000" and RD<="11111") then
				RDTemp <= conv_integer(RD)  - (conv_integer(aux_nCWP)*16);
			else
				if(RD>="10000" and RD<="10111") then
					RDTemp <= conv_integer(RD)+ (conv_integer(aux_nCWP)*16);
				else
					if(RD>="01000" and RD<="01111") then
						RDTemp <= conv_integer(RD)+ (conv_integer(aux_nCWP)*16);
					end if;
				end if;
			end if;
		end if;
		
					--nCWP <= CWP;
	
	end process;
	
	nRS1 <= conv_std_logic_vector(RS1Temp, 6);
	nRS2<= conv_std_logic_vector(RS2Temp, 6);
	nRD <= conv_std_logic_vector(RDTemp, 6);			
			

end Behavioral;

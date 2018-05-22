library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR is
    Port (clock : in STD_LOGIC;
			 reset : in  STD_LOGIC;
          nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
          nCWP : in  STD_LOGIC_VECTOR (4 downto 0);
          CWP : out  STD_LOGIC_VECTOR (4 downto 0);
			 carry : out  STD_LOGIC);
           
			  
end PSR;

architecture psrArquitecture of PSR is

signal PSRegistro: STD_LOGIC_VECTOR (31 DOWNTO 0) := "00000000000000000000000000000000";
begin	
	process(clock,reset,nzvc)
		begin		
			if(reset = '1') then
				PSRegistro <="00000000000000000000000000000000";
				
			elsif (rising_edge(clock))then
				PSRegistro(26 downto 23) <= nzvc;
				PSRegistro(4 downto 0) <= ncwp;
				carry <= PSRegistro(23);
				CWP <= PSRegistro(4 downto 0);
		end if;
		end process;	

end psrArquitecture;

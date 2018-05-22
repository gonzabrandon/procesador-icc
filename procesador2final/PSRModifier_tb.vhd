LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PSRModifier_tb IS
END PSRModifier_tb;
 
ARCHITECTURE behavior OF PSRModifier_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSRModifier
    PORT(
      ALUOP : IN  std_logic_vector(5 downto 0);
         RESULT : IN  std_logic_vector(31 downto 0);
         RS1 : IN  std_logic_vector(31 downto 0);
         RS2 : IN  std_logic_vector(31 downto 0);
         NZVC : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
      signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');
   signal RESULT : std_logic_vector(31 downto 0) := (others => '0');
   signal RS1 : std_logic_vector(31 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(31 downto 0) := (others => '0');
 	--Outputs
    signal NZVC : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSRModifier PORT MAP (
          ALUOP => ALUOP,
          RESULT => RESULT,
          RS1 => RS1,
          RS2 => RS2,
          NZVC => NZVC
        );



   -- Stimulus process
   stim_proc: process
   begin	
		
	ALUOP <= "010000" ; -- addcc
		RESULT <=  "11111111111111111111111111111110" ;
		RS1 <= 	  "11111111111111111111111111111111"  ;
		RS2 <=  	  "11111111111111111111111111111111" ;
	
		wait for 10 ns;
		ALUOP <= "010000" ; -- addcc
		RESULT <=  "00000000000000000000000001001001" ;
		RS1 <=     "10000000000000000000000000111011"  ;
		RS2 <=     "10000000000000000000000000001110" ;
		
		wait for 10 ns;
		ALUOP <= "010100" ; --SUBCC
		RESULT <=  "00000000000000000000000000000000" ;
		RS1 <=  	  "01111111111111111111111111111111" ;
		RS2 <=     "01111111111111111111111111111111";
		

      wait;
   end process;

END;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY windowsManager_tb IS
END windowsManager_tb;
 
ARCHITECTURE behavior OF windowsManager_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT windowsManager
    PORT(
         RS1 : IN  std_logic_vector(4 downto 0);
         RS2 : IN  std_logic_vector(4 downto 0);
         RD : IN  std_logic_vector(4 downto 0);
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         CWP : IN  std_logic_vector(4 downto 0);
         nCWP : OUT  std_logic_vector(4 downto 0);
         nRS1 : INOUT  std_logic_vector(5 downto 0);
         nRS2 : OUT  std_logic_vector(5 downto 0);
         nRD : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RS1 : std_logic_vector(4 downto 0) := (others => '0');
   signal RS2 : std_logic_vector(4 downto 0) := (others => '0');
   signal RD : std_logic_vector(4 downto 0) := (others => '0');
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');
   signal CWP : std_logic_vector(4 downto 0) := (others => '0');

	--BiDirs
   signal nRS1 : std_logic_vector(5 downto 0);

 	--Outputs
   signal nCWP : std_logic_vector(4 downto 0);
   signal nRS2 : std_logic_vector(5 downto 0);
   signal nRD : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: windowsManager PORT MAP (
          RS1 => RS1,
          RS2 => RS2,
          RD => RD,
          OP => OP,
          OP3 => OP3,
          CWP => CWP,
          nCWP => nCWP,
          nRS1 => nRS1,
          nRS2 => nRS2,
          nRD => nRD
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      

   	cwp <= "00001";
		op <= "10";
		op3 <= "101101";
		rs1 <= "00011";
		rs2 <= "10001";
		rd <= "10010";
		
--	   wait for 10 ns;	
--
--   	cwp <= "00001";
--		op <= "10";
--		op3 <= "111100";
--		RS1 <= "00011";
--		RS2 <= "10001";
--		RD <= "10010";	
--		
--		wait for 10 ns;
--		
--		cwp <= "00000";
--		op <= "10";
--		op3 <= "111100";
--		RS1 <= "10011";
--		RS2 <= "10001";
--		RD <= "10010";
--		
--	   wait for 10 ns;	
--
--   	cwp <= "00001";
--		op <= "10";
--		op3 <= "111100";
--		RS1 <= "00011";
--		RS2 <= "10001";
--		RD <= "10010";	
--				
--
--      -- insert stimulus here 

      wait;
   end process;

END;

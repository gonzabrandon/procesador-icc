LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Procesador_tb IS
END Procesador_tb;
 
ARCHITECTURE behavior OF Procesador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProcesadorICC
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Resultado : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Resultado : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProcesadorICC PORT MAP (
          clk => clk,
          rst => rst,
          Resultado => Resultado
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.	
		rst <= '1';
		wait for 10 ns;	
		rst <= '0';

      wait for 1000 ns;
   end process;

END;

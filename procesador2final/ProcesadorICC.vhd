
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ProcesadorICC is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcesadorICC;

architecture Behavioral of ProcesadorICC is

COMPONENT PC
	PORT(
		PCAddr : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		CLK : IN std_logic;          
		PCout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT sumador
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		S : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT signExtends
	PORT(
		entrada13 : IN std_logic_vector(12 downto 0);
		salida32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT rf
	PORT(
		--clk : IN std_logic;
		rst : IN std_logic;
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		DWR : IN std_logic_vector(31 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT UC
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUX 
	PORT(
		CRS2 : IN std_logic_vector(31 downto 0);
		outSEU : IN std_logic_vector(31 downto 0);
		I : IN std_logic;
		outMUX : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		CRS1 : IN std_logic_vector(31 downto 0);
		CRS2 : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);
		C : IN std_logic;
		DWR : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR
	PORT (clock : in STD_LOGIC;
			reset : in  STD_LOGIC;
         nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
         nCWP : in  STD_LOGIC_VECTOR (4 downto 0);
         CWP : out  STD_LOGIC_VECTOR (4 downto 0);
			carry : out  STD_LOGIC
			);
	END COMPONENT;
	
	COMPONENT PSRModifier
	PORT ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
          RESULT : in  STD_LOGIC_VECTOR (31 downto 0);
          RS1 : in  STD_LOGIC_VECTOR (31 downto 0);
          RS2 : in  STD_LOGIC_VECTOR (31 downto 0);
          NZVC : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
	END COMPONENT;
	
	COMPONENT windowsManager
	PORT ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
          RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
          RD : in  STD_LOGIC_VECTOR (4 downto 0);
          OP : in  STD_LOGIC_VECTOR (1 downto 0);
          OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
          CWP : in  STD_LOGIC_VECTOR (4 downto 0);
          nCWP : out  STD_LOGIC_VECTOR (4 downto 0):="00000";
          nRS1 : inout  STD_LOGIC_VECTOR (5 downto 0);
          nRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
          nRD : out  STD_LOGIC_VECTOR (5 downto 0)
			 );
	END COMPONENT;
	
	
	

-- datapath signals
	signal out_adder: std_logic_vector(31 downto 0):=(others=>'0');
	signal aux_npcout: std_logic_vector(31 downto 0):=(others=>'0');
	signal aux_pcout: std_logic_vector(31 downto 0):=(others=>'0');
	-- im signals
	signal im_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
	-- seu signals
	signal aux_seuout: std_logic_vector(31 downto 0):=(others=>'0');
	-- rf signals
	signal aux_crs1: std_logic_vector(31 downto 0):=(others=>'0');
	signal aux_crs2: std_logic_vector(31 downto 0):=(others=>'0');
	-- uc signals
	signal aux_aluop: std_logic_vector(5 downto 0):=(others=>'0');
	-- mux signals
	signal aux_muxout: std_logic_vector(31 downto 0):=(others=>'0');
	-- alu signals
	signal aux_aluout: std_logic_vector(31 downto 0):=(others=>'0');
	-- windowsManager signal
	signal aux_CWP: std_logic_vector(4 downto 0):=(others=>'0');
	signal aux_nCWP: std_logic_vector(4 downto 0):=(others=>'0');
	signal aux_nRS1: std_logic_vector(5 downto 0):=(others=>'0');
	signal aux_nRS2: std_logic_vector(5 downto 0):=(others=>'0');
	signal aux_nRD: std_logic_vector(5 downto 0):=(others=>'0');
	--psr signals
	signal aux_nzvc: std_logic_vector(3 downto 0):=(others=>'0');
	signal aux_c: std_logic;

begin
inst_adder: sumador PORT MAP(
		A => "00000000000000000000000000000001",
		B => aux_npcout,
		S => out_adder
		);
		
	inst_npc: PC PORT MAP(
		PCAddr => out_adder,
		rst => rst,
		CLK => CLK,
		PCout => aux_npcout
		);
		
	inst_pc: PC PORT MAP(
		PCAddr => aux_npcout,
		rst => rst,
		clk => CLK,
		PCout => aux_pcout
		);
	
	inst_im: instructionMemory PORT MAP(
		--clk => CLK,
		reset => rst,
		address => aux_pcout,
		outInstruction => im_out
	);
	
	inst_seu: signExtends PORT MAP(
		entrada13 => im_out(12 downto 0),
		salida32 => aux_seuout
		);
		
	inst_WindowsManager: WindowsManager PORT MAP(
		RS1 => im_out(18 downto 14),
      RS2 => im_out(4 downto 0),
      RD => im_out(29 downto 25),
		OP => im_out(31 downto 30),
      OP3 => im_out(24 downto 19),
      CWP => aux_CWP,
      nCWP => aux_nCWP,
      nRS1 => aux_nRS1,
      nRS2 => aux_nRS2,
      nRD => aux_nRD
		);
		
	inst_rf: RF PORT MAP(
		rst => rst,
		rs1 => aux_nRS1,
      rs2 => aux_nRS2,
      rd => aux_nRD,
      dwr => aux_aluout,
      crs1 => aux_cRS1,
      crs2 => aux_cRS2
		);
		
	inst_psr: PSR PORT MAP(
		clock => CLK,
		reset => rst,
      nzvc => aux_nzvc,
      nCWP => aux_nCWP,
      CWP => aux_CWP,
		carry => aux_c
		);
		
	inst_uc: UC PORT MAP(
		OP => im_out(31 downto 30),
		OP3 => im_out(24 downto 19),
		ALUOP => aux_aluop
		);
		
	inst_mux: MUX PORT MAP(
		CRS2 => aux_crs2,
		outSEU => aux_seuout,
		I => im_out(13),
		outMUX => aux_muxout
		);
		
	ints_psrModifier: PSRModifier PORT MAP(
		ALUOP => aux_aluop,
      RESULT => aux_aluout,
      RS1 => aux_cRS1,
      RS2 => aux_muxout,
      NZVC => aux_nzvc
		);
		
	int_alu: ALU PORT MAP(
		ALUOP => aux_aluop,
      CRS1 => aux_cRS1,
      CRS2 => aux_muxout,
		C => aux_c,
      DWR => aux_aluout
		);
	
		
	Resultado <= aux_aluout;
	
end Behavioral;


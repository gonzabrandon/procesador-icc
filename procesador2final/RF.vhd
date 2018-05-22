
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RF is
    Port ( --clk : in STD_LOGIC;
			  rst : in  STD_LOGIC;
			  rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is

type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
signal rf: ram_type := (others => x"00000000");

begin

	process(rst,rs1,rs2,rd,dwr,RF)--clkFPGA,writeEnable)


	begin
			if(rst = '1')then
				crs1 <= (others=>'0');
				crs2 <= (others=>'0');



				rf <= (others => x"00000000");
			else
				crs1 <= rf(conv_integer(rs1));
				crs2 <= rf(conv_integer(rs2));
				IF rd /= "000000" THEN 
						rf(conv_integer(rd)) <= dwr;
				end if;
			end if;
		
	end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity UC is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end UC;

architecture Behavioral of UC is

begin
PROCESS (OP3) is
	begin 
		case OP3 is 
				WHEN "000001" => ALUOP <= "000001"; --and
				WHEN "000101" => ALUOP <= "000101"; --andn
				WHEN "000010" => ALUOP <= "000010"; --or
				WHEN "000110" => ALUOP <= "000110"; --orn
				WHEN "000011" => ALUOP <= "000011"; --xor
				WHEN "000111" => ALUOP <= "000111"; --xnor
				WHEN "000000" => ALUOP <= "000000"; --add
				WHEN "000100" => ALUOP <= "000100"; --sub
				WHEN "010000" => ALUOP <= "010000"; --addcc
				WHEN "011000" => ALUOP <= "011000"; --addxcc
				WHEN "010100" => ALUOP <= "010100"; --subcc
				WHEN "011100" => ALUOP <= "011100"; --subxcc
				WHEN "111100" => ALUOP <= "111100"; --save
				WHEN "111101" => ALUOP <= "111101"; --restore
				WHEN "001000" => ALUOP <= "001000"; --addx
				WHEN "001100" => ALUOP <= "001100"; --subx
				WHEN "010101" => ALUOP <= "010101"; --andncc
				WHEN "010010" => ALUOP <= "010010"; --orcc
				WHEN "010110" => ALUOP <= "010110"; --orncc
				WHEN "010011" => ALUOP <= "010011"; --xorcc
				WHEN "010111" => ALUOP <= "010111"; --xnorcc
				
				WHEN  OTHERS  =>    ALUOP <= "000000"; --nada 
		end case;
end process;
	

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity t_ff is
port(
    Enable: in std_logic;
    Clk: in std_logic;
    Clear: in std_logic;
    Q: out std_logic
);
end t_ff;

architecture Behavioral of t_ff is

	signal tmp: std_logic;
	
begin
	process(Enable, Clk, Clear)
	--variable tmp: std_logic;
	begin
	if (Clear='1') then
		--tmp:='0';
		tmp <= '0';
	else
		if (rising_edge(Clk)) then
			if(Enable='1') then
				--tmp:= NOT tmp;
				tmp <= not tmp;
			else
				tmp <= tmp;
			end if;
		end if;
	end if;
	--Q<=tmp;
	end process;
	Q<=tmp;
end Behavioral;

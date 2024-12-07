library ieee;
use ieee. std_logic_1164.all;
 
entity FF_T is port
(
	T : in std_logic;
	clk : in std_logic;
	clear: in std_logic;
	Q: out std_logic

);
end FF_T;

architecture behavioral of FF_T is
signal Q_interno : std_logic :='0';

begin

process(clk, clear)
    begin
        if clear = '1' then
            Q_interno <= '0';
        elsif rising_edge(clk) then
            if T = '1' then
                Q_interno <= NOT Q_interno;
            end if;
        end if;
    end process;

	 Q <= Q_interno;
	 
end behavioral;
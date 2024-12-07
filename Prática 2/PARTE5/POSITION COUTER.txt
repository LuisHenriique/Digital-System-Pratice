library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity position_counter is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        pos    : out STD_LOGIC_VECTOR(2 downto 0)  -- 3 bits
    );
end position_counter;

architecture Behavioral of position_counter is
    signal count : unsigned(2 downto 0) := (others => '0');  -- 3 bits
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
					 if count = "101" then
						count <= "000";
					 else
						count <= count + 1;
					 end if;
				end if;
        end if;
    end process;

    pos <= std_logic_vector(count);
end Behavioral;

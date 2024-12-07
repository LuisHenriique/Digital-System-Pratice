library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        pulse : out STD_LOGIC
    );
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter : unsigned(25 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            pulse <= '0';
        elsif rising_edge(clk) then
            if counter = 49999999 then
                counter <= (others => '0');
                pulse <= '1';
            else
                counter <= counter + 1;
                pulse <= '0';
            end if;
        end if;
    end process;
end Behavioral;
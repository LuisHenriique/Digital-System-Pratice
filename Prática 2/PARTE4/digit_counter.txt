library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digit_counter is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable: in  STD_LOGIC;
        digit : out STD_LOGIC_VECTOR(3 downto 0)
    );
end digit_counter;

architecture Behavioral of digit_counter is
    signal count : unsigned(3 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                if count = 9 then
                    count <= (others => '0');
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    digit <= std_logic_vector(count);
end Behavioral;

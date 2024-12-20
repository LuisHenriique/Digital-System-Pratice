library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clock_Divider_1s is
    Port (
        clk_in   : in  STD_LOGIC;
        clk_out  : out STD_LOGIC
    );
end Clock_Divider_1s;

architecture Behavioral of Clock_Divider_1s is
    signal count : integer := 0;
    signal dado  : std_logic := '0';
    constant COUNT_MAX : integer := 25000000 - 1; -- 50 milhões de ciclos
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if count = COUNT_MAX then
                dado <= not dado;   -- Inverte o valor de dado a cada 50 milhões de ciclos
                count <= 0;         -- Reseta o contador
            else
                count <= count + 1; -- Incrementa o contador
            end if;
        end if;
    end process;

    clk_out <= dado; -- Atualiza clk_out com o valor de dado

end Behavioral;

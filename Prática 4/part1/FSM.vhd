library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port (
        clk     : in  STD_LOGIC;     -- Clock
        reset   : in  STD_LOGIC;     -- Reset
        w       : in  STD_LOGIC;     -- Entrada de controle
        state   : out STD_LOGIC_VECTOR(8 downto 0); -- Estado atual (saída)
        z       : out STD_LOGIC      -- Saída z, acende em E e I
    );
end FSM;

architecture Behavioral of FSM is
    signal current_state : STD_LOGIC_VECTOR(8 downto 0);
    signal next_state : STD_LOGIC_VECTOR(8 downto 0);
begin

    -- Instanciação dos Flip-Flops D para armazenar o estado atual
    process (clk, reset)
    begin
        if reset = '1' then
            current_state <= "000000001"; -- Estado inicial (A)
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Lógica de transição de estado
    process (current_state, w)
    begin
        -- Inicializar o próximo estado
        next_state <= "000000000";
        
        case current_state is
            when "000000001" => -- Estado A
                if w = '0' then
                    next_state <= "000000010"; -- Ir para B
                else
                    next_state <= "000100000"; -- Ir para F
                end if;
                
            when "000000010" => -- Estado B
                if w = '0' then
                    next_state <= "000000100"; -- Ir para C
                else
                    next_state <= "000100000"; -- Ir para F
                end if;

            when "000000100" => -- Estado C
                if w = '0' then
                    next_state <= "000001000"; -- Ir para D
                else
                    next_state <= "000100000"; -- Ir para F
                end if;

            when "000001000" => -- Estado D
                if w = '0' then
                    next_state <= "000010000"; -- Ir para E
                else
                    next_state <= "000100000"; -- Ir para F
                end if;

            when "000010000" => -- Estado E
                if w = '0' then
                    next_state <= "000010000"; -- Manter em E
                else
                    next_state <= "000100000"; -- Ir para F
                end if;

            when "000100000" => -- Estado F
                if w = '0' then
                    next_state <= "000000010"; -- Ir para B
                else
                    next_state <= "001000000"; -- Ir para G
                end if;

            when "001000000" => -- Estado G
                if w = '0' then
                    next_state <= "000000010"; -- Ir para B
                else
                    next_state <= "010000000"; -- Ir para H
                end if;

            when "010000000" => -- Estado H
                if w = '0' then
                    next_state <= "000000010"; -- Ir para B
                else
                    next_state <= "100000000"; -- Ir para I
                end if;

            when "100000000" => -- Estado I
                if w = '0' then
                    next_state <= "000000010"; -- Ir para B
                else
                    next_state <= "100000000"; -- Manter em I
                end if;

            when others =>
                next_state <= "000000001"; -- Voltar para o estado inicial (A)
        end case;
    end process;

    -- Lógica de saída z
    process (current_state)
    begin
		    state <= current_state;

        if current_state = "000010000" or current_state = "100000000" then
            z <= '1'; -- z acende nos estados E e I
        else
            z <= '0';
        end if;
    end process;

    -- Saída do estado atual

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Importar o pacote para operações aritméticas

entity part3 is
    Port (
        clk    : in  STD_LOGIC;  -- Clock de 50 MHz
        enable : in  STD_LOGIC;  -- Habilitar a contagem
        clear  : in  STD_LOGIC;  -- Sinal para resetar o contador
        seg1   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 1
        seg2   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 2
        seg3   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 3
        seg4   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 4
        led    : out STD_LOGIC   -- LED de saída
    );
end part3;

architecture Behavioral of part3 is
    -- Declaração dos componentes
    component Clock_Divider_1s is
        Port (
            clk_in   : in  STD_LOGIC;
            clk_out  : out STD_LOGIC
        );
    end component;

    component display is
        Port (
            bin   : in  STD_LOGIC_VECTOR(3 downto 0);
            seg   : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    -- Sinais internos
    signal Q       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  -- Contador de 16 bits
    signal nibble1 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble2 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble3 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble4 : STD_LOGIC_VECTOR(3 downto 0);
    signal clk_1s  : STD_LOGIC;  -- Sinal de clock de 1 segundo gerado pelo divisor

begin
    -- Instanciar o divisor de clock para gerar o pulso de 1 segundo
    U1: Clock_Divider_1s port map (
        clk_in   => clk,
        clk_out  => clk_1s
    );

    -- Processo de contagem, agora usando o clock de 1 segundo
    process(clk_1s, clear)
    begin
        if clear = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk_1s) then
            if enable = '1' then
                Q <= std_logic_vector(unsigned(Q) + 1); -- Incrementa o contador
            end if;
        end if;
    end process;

    -- Divida o valor de 16 bits em 4 nibbles de 4 bits cada
    nibble1 <= Q(3 downto 0);    -- Menos significativo
    nibble2 <= Q(7 downto 4);
    nibble3 <= Q(11 downto 8);
    nibble4 <= Q(15 downto 12);  -- Mais significativo

    -- Instanciar e conectar os decodificadores de display de 7 segmentos
    U2: display port map (bin => nibble1, seg => seg1);
    U3: display port map (bin => nibble2, seg => seg2);
    U4: display port map (bin => nibble3, seg => seg3);
    U5: display port map (bin => nibble4, seg => seg4);

    -- Lógica para o LED
    process(Q)
    begin
        if unsigned(Q) = 4 then
            led <= '1';  -- Acende o LED se o contador for 30
        else
            led <= '0';  -- Apaga o LED caso contrário
        end if;
    end process;

end Behavioral;

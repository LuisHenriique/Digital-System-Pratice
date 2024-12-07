library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Importar o pacote para operações aritméticas

entity part2 is
    Port (
        clk    : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        clear  : in  STD_LOGIC;
        seg1   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 1
        seg2   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 2
        seg3   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 3
        seg4   : out STD_LOGIC_VECTOR(6 downto 0)  -- Display 4
    );
end part2;

architecture Behavioral of part2 is
    -- Declaração do componente 'display'
    component display
        Port (
            bin   : in  STD_LOGIC_VECTOR(3 downto 0);
            seg   : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    -- Sinais internos
    signal Q       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal nibble1 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble2 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble3 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble4 : STD_LOGIC_VECTOR(3 downto 0);

begin
    process(clk, clear)
    begin
        if clear = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                Q <= std_logic_vector(unsigned(Q) + 1); -- Converte para unsigned, realiza a adição e converte de volta para std_logic_vector
            end if;
        end if;
    end process;

    -- Divida o valor de 16 bits em 4 nibbles de 4 bits cada
    nibble1 <= Q(3 downto 0);
    nibble2 <= Q(7 downto 4);
    nibble3 <= Q(11 downto 8);
    nibble4 <= Q(15 downto 12);

    -- Instanciar e conectar os decodificadores de display de 7 segmentos
    U1: display port map (bin => nibble1, seg => seg1);
    U2: display port map (bin => nibble2, seg => seg2);
    U3: display port map (bin => nibble3, seg => seg3);
    U4: display port map (bin => nibble4, seg => seg4);

end Behavioral;

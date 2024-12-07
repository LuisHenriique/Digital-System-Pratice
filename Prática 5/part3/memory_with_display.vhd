library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory_with_display is
    port (
        SW : in std_logic_vector(9 downto 0);  -- Switches de entrada
        KEY : in std_logic_vector(1 downto 0); -- Botões
        HEX0 : out std_logic_vector(6 downto 0);  -- Saídas do display de 7 segmentos
		      HEX1 : out std_logic_vector(6 downto 0);  -- Saídas do display de 7 segmentos
				    HEX2 : out std_logic_vector(6 downto 0);  -- Saídas do display de 7 segmentos
					     HEX3 : out std_logic_vector(6 downto 0)  -- Saídas do display de 7 segmentos
    );
end entity memory_with_display;

architecture Behavioral of memory_with_display is
    type mem is array(0 to 31) of std_logic_vector(3 downto 0); -- Declara a memória
    signal memory_array : mem := (others => (others => '0')); -- Inicializa a memória
    signal address : std_logic_vector(4 downto 0);
    signal data_in : std_logic_vector(3 downto 0);
    signal data_out : std_logic_vector(3 downto 0);
    signal write_enable : std_logic;

begin
    -- Atribuição dos sinais a partir dos switches
    address <= SW(8 downto 4);  -- Endereço dos switches 8 a 4
    data_in <= SW(3 downto 0);   -- Dados dos switches 3 a 0
    write_enable <= SW(9);       -- Sinal de escrita no switch 9

    -- Processo para escrever e ler da memória
    process(KEY)
    begin
        if rising_edge(KEY(0)) then  -- Usando KEY0 como clock
            if write_enable = '1' then
                memory_array(to_integer(unsigned(address))) <= data_in; -- Escreve na memória
            end if;
            data_out <= memory_array(to_integer(unsigned(address))); -- Lê da memória
        end if;
    end process;

    -- Instância do display para mostrar dados
    display_inst0 : entity work.display
        port map (
            bin => data_out,
            seg => HEX0 -- HEX0 mostra os dados lidos da memória
        );

    display_inst1 : entity work.display
        port map (
            bin => data_in,
            seg => HEX1 -- HEX2 mostra os dados de entrada
        );

    -- Instâncias para os displays do endereço
    display_inst4 : entity work.display
        port map (
            bin => address(4 downto 1), -- Parte alta do endereço
            seg => HEX2 -- HEX4
        );

    display_inst5 : entity work.display
        port map (
            bin => address(3 downto 0), -- Parte baixa do endereço
            seg => HEX3 -- HEX5
        );

end architecture Behavioral;

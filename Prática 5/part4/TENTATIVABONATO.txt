library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity part4 is
    port (
        CLOCK_50   : in  std_logic;                 -- Clock de 50 MHz
        KEY0       : in  std_logic;                 -- Reset
        SW         : in  std_logic_vector(9 downto 0); -- Switches para endereço e dados
        HEX0       : out std_logic_vector(6 downto 0); -- Display de 7 segmentos para dados
        HEX1       : out std_logic_vector(6 downto 0); -- Display de 7 segmentos para dados de escrita
        HEX2       : out std_logic_vector(6 downto 0); -- Display de 7 segmentos para endereço
        HEX3       : out std_logic_vector(6 downto 0); -- Display de 7 segmentos para endereço
        HEX4       : out std_logic_vector(6 downto 0); -- Display de 7 segmentos para endereço de escrita
        HEX5       : out std_logic_vector(6 downto 0)  -- Display de 7 segmentos para endereço de escrita
    );
end part4;

architecture behavior of part4 is

    signal wraddress   : std_logic_vector(4 downto 0);
    signal rdaddress   : std_logic_vector(4 downto 0);
    signal wren        : std_logic := '0';
    signal data        : std_logic_vector(3 downto 0);
    signal q           : std_logic_vector(3 downto 0);
    signal counter     : integer := 0;             -- Contador para o endereço de leitura
    signal clk_div     : integer := 0;             -- Divisor de clock
    signal display_data : integer;                 -- Dados a serem exibidos

			 FUNCTION convert_to_7seg (seg : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
			 VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);  -- Variable for storing the result
		BEGIN
			 CASE seg IS
				  WHEN "0000" => result := "1000000"; -- 0
				  WHEN "0001" => result := "1111001"; -- 1
				  WHEN "0010" => result := "0100100"; -- 2
				  WHEN "0011" => result := "0110000"; -- 3
				  WHEN "0100" => result := "0011001"; -- 4
				  WHEN "0101" => result := "0010010"; -- 5
				  WHEN "0110" => result := "0000010"; -- 6
				  WHEN "0111" => result := "1111000"; -- 7
				  WHEN "1000" => result := "0000000"; -- 8
				  WHEN "1001" => result := "0010000"; -- 9
				  WHEN "1010" => result := "0001000"; -- A
				  WHEN "1011" => result := "0000011"; -- b
				  WHEN "1100" => result := "1000110"; -- C
				  WHEN "1101" => result := "0100001"; -- d
				  WHEN "1110" => result := "0000110"; -- E
				  WHEN "1111" => result := "0001110"; -- F
				  WHEN OTHERS => result := "1111111"; -- Default case
			 END CASE;
			 RETURN result;  -- Return the result
		END FUNCTION;
	 
	 component ram32x4
        port (
            clock       : in  std_logic;
            data        : in  std_logic_vector(3 downto 0);
            rdaddress    : in  std_logic_vector(4 downto 0);
            wraddress    : in  std_logic_vector(4 downto 0);
            wren        : in  std_logic;
            q           : out std_logic_vector(3 downto 0)
        );
    end component;

    component display
        port (
            bin : in std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0) -- Segments a to g
        );
    end component;

begin

    -- Instância da memória RAM
    RAM_INST : ram32x4
        port map (
            clock => CLOCK_50,
            data => data,
            rdaddress => rdaddress,
            wraddress => wraddress,
            wren => wren,
            q => q
        );

    -- Lógica para controle do contador e escrita
    process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            if KEY0 = '0' then  -- Reset
                counter <= 0;
                rdaddress <= (others => '0');
                wren <= '0';
            else
                clk_div <= clk_div + 1;
                if clk_div = 50000000 then  -- Aproximadamente 1 segundo
                    clk_div <= 0;
                    counter <= (counter + 1) mod 32;  -- Looping através dos endereços
                end if;

                rdaddress <= std_logic_vector(to_unsigned(counter, 5)); 
                wraddress <= SW(8 downto 4);
					 
					 HEX2 <= convert_to_7seg(rdaddress(3 DOWNTO 0));

					  -- Decoding for the second display (MSD)
					  IF rdaddress(4) = '0' THEN
							HEX3 <= convert_to_7seg("0000"); -- 0
					  ELSE
							HEX3 <= convert_to_7seg("0001"); -- 1
					  END IF;
					  
					  HEX4 <= convert_to_7seg(wraddress(3 DOWNTO 0));

					  -- Decoding for the second display (MSD)
					  IF wraddress(4) = '0' THEN
							HEX5 <= convert_to_7seg("0000"); -- 0
					  ELSE
							HEX5 <= convert_to_7seg("0001"); -- 1
					  END IF;
					 
					 wren <= SW(9); 
					 display_data <= to_integer(unsigned(q));
					 data <= SW(3 downto 0);
					 
					 --TENTAR OS DISPLAYS MANUALMENTE
            end if;
        end if;
    end process;

    -- Instâncias do display de 7 segmentos
    HEX0_inst: display
        port map (
            bin => q(3 downto 0),
            seg => HEX0
        );

    HEX1_inst: display
        port map (
            bin => data,
            seg => HEX1
        );


end behavior;

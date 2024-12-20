LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;  -- For arithmetic operations on std_logic_vector

ENTITY part1 IS
	PORT (
		-- Input signals
		SW		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);  -- SW0-SW3 for data, SW4-SW8 for address, SW9 for write signal
		KEY0	: IN STD_LOGIC;                       -- Clock input
		-- Output signals
		HEX0	: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);  -- 7-segment display for output data
		HEX2	: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);  -- 7-segment display for input data
		HEX4	: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);  -- 7-segment display for address
		HEX5	: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)   -- 7-segment display for address
	);
END part1;

ARCHITECTURE behavior OF part1 IS

	-- Internal signals
	SIGNAL address	: STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL data		: STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL wren		: STD_LOGIC;
	SIGNAL q			: STD_LOGIC_VECTOR (3 DOWNTO 0);

	-- Instantiate the RAM module
	COMPONENT ram32x4
		PORT (
			address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			clock		: IN STD_LOGIC;
			data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			wren		: IN STD_LOGIC;
			q			: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
	END COMPONENT;
	
	FUNCTION convert_to_7seg (seg : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);  -- Variável para armazenar o resultado
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
    RETURN result;  -- Retorna o resultado
END FUNCTION;


BEGIN
	
	
	PROCESS(KEY0)
    BEGIN
        IF rising_edge(KEY0) THEN
            -- Connect inputs from switches
            address <= SW(8 DOWNTO 4);  -- Address input from switches SW8-SW4
            data <= SW(3 DOWNTO 0);      -- Data input from switches SW3-SW0
            wren <= SW(9);                -- Write enable from switch SW9
        END IF;
    END PROCESS;

	-- Instantiate RAM
	ram_instance : ram32x4
		PORT MAP (
			address => address,
			clock => KEY0,
			data => data,
			wren => wren,
			q => q
		);
	
	-- Display output data on HEX0
	HEX0 <= convert_to_7seg(q);
	-- Display input data on HEX2
	HEX2 <= convert_to_7seg(data);
	-- Display address on HEX4 and HEX5
	
	PROCESS(address)
    BEGIN
        -- Decodificação para o primeiro display (LSD)
        HEX4 <= convert_to_7seg(address(3 DOWNTO 0));

        -- Decodificação para o segundo display (MSD)
        IF address(4) = '0' THEN
            HEX5 <= convert_to_7seg("0000"); -- 0
        ELSE
            HEX5 <= convert_to_7seg("0001"); -- 1
        END IF;
    END PROCESS;
	
	 
END behavior;

-- Function to convert std_logic_vector to 7-segment display encoding


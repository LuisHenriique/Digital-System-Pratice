library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity part5 is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        seg5   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 5
        seg4   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 4
        seg3   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 3
        seg2   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 2
        seg1   : out STD_LOGIC_VECTOR(6 downto 0); -- Display 1
        seg0   : out STD_LOGIC_VECTOR(6 downto 0) -- Display 0
    );
end part5;

architecture Behavioral of part5 is
    signal pulse_1s : STD_LOGIC;
    signal pos      : STD_LOGIC_VECTOR(2 downto 0);
    signal char0, char1, chard, chare: STD_LOGIC_VECTOR(3 downto 0);
	 signal charnulo : STD_LOGIC_VECTOR(6 downto 0);

    component clock_divider
        Port (
            clk   : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            pulse : out STD_LOGIC
        );
    end component;

    component position_counter
        Port (
            clk    : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            enable : in  STD_LOGIC;
            pos    : out STD_LOGIC_VECTOR(2 downto 0)  -- 3 bits
        );
    end component;

    component display
        Port (
            bin : in  STD_LOGIC_VECTOR(3 downto 0);
            seg : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    function get_segment_value(char : STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is
        variable seg : STD_LOGIC_VECTOR(6 downto 0);
    begin
        case char is
            when "0000" => seg := "1000000"; -- 0
            when "0001" => seg := "1111001"; -- 1
            when "0010" => seg := "0100100"; -- 2
            when "0011" => seg := "0110000"; -- 3
            when "0100" => seg := "0011001"; -- 4
            when "0101" => seg := "0010010"; -- 5
            when "0110" => seg := "0000010"; -- 6
            when "0111" => seg := "1111000"; -- 7
            when "1000" => seg := "0000000"; -- 8
            when "1001" => seg := "0010000"; -- 9
            when "1010" => seg := "0001000"; -- A
            when "1011" => seg := "0000011"; -- b
            when "1100" => seg := "1000110"; -- C
            when "1101" => seg := "0100001"; -- d
            when "1110" => seg := "0000110"; -- E
            when "1111" => seg := "0001110"; -- F
            when others => seg := "1111111"; -- Default case
        end case;
        return seg;
    end function;

begin
    -- Instanciar o divisor de clock
    U1: clock_divider port map (
        clk   => clk,
        reset => reset,
        pulse => pulse_1s
    );

    -- Instanciar o contador de posições
    U2: position_counter port map (
        clk   => clk,
        reset => reset,
        enable=> pulse_1s,
        pos   => pos
    );

    -- Definir os caracteres da palavra "dE0"
    chard <= "1101"; -- d
    char1 <= "0001"; -- 1
    chare <= "1110";----E
    char0 <= "0000"; -- 0
    charnulo <= "1111111";

    -- Lógica para rotação dos caracteres com base na posição
    process(pos)
    begin
        case pos is
            when "000" =>
                seg0 <= get_segment_value(char0);
                seg1 <= get_segment_value(char1);
                seg2 <= get_segment_value(chare);
                seg3 <= get_segment_value(chard); -- Blank
                seg4 <= charnulo; -- Blank
                seg5 <= charnulo; -- Blank
            when "001" =>
                seg0 <= charnulo;
                seg1 <= get_segment_value(char0);
                seg2 <= get_segment_value(char1); -- 
                seg3 <= get_segment_value(chare); -- 
                seg4 <= get_segment_value(chard); -- 
                seg5 <= charnulo;
            when "010" =>
                seg0 <= charnulo;
                seg1 <= charnulo;  -- Blank
                seg2 <= get_segment_value(char0); -- Blank
                seg3 <= get_segment_value(char1); -- Blank
                seg4 <= get_segment_value(chare);
                seg5 <= get_segment_value(chard);
            when "011" =>
                seg0 <= get_segment_value(chard); -- Blank
                seg1 <= charnulo;  -- Blank
                seg2 <= charnulo;  -- Blank
                seg3 <= get_segment_value(char0);
                seg4 <= get_segment_value(char1);
                seg5 <= get_segment_value(chare);
            when "100" =>
                seg0 <= get_segment_value(chare); -- Blank
                seg1 <= get_segment_value(chard); -- Blank
                seg2 <= charnulo;
                seg3 <= charnulo; 
                seg4 <= get_segment_value(char0);
                seg5 <= get_segment_value(char1); -- Blank
            when "101" =>
                seg0 <= get_segment_value(char1); -- Blank
                seg1 <= get_segment_value(chare);
                seg2 <= get_segment_value(chard);
                seg3 <= charnulo; 
                seg4 <= charnulo;  -- Blank
                seg5 <= get_segment_value(char0); -- Blank
           
            when others =>
                seg0 <= "1111111"; -- Default case
                seg1 <= "1111111";
                seg2 <= "1111111";
                seg3 <= "1111111";
                seg4 <= "1111111";
                seg5 <= "1111111";
        end case;
    end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity part4 is
    Port (
        clk     : in  STD_LOGIC;       -- System clock
        reset   : in  STD_LOGIC;       -- Asynchronous reset (KEY0)
        key0    : in  STD_LOGIC;       -- Start button (KEY1)
        sw0     : in  STD_LOGIC;       -- Letter selection (SW2-0)
        sw1     : in  STD_LOGIC;
        sw2     : in  STD_LOGIC;
        led     : out STD_LOGIC;        -- LED output
        hex0    : out STD_LOGIC_VECTOR(6 downto 0)
    );
end part4;

architecture Behavioral of part4 is

    type state_type is (IDLE, DOT, DASH, PAUSE, FIND_FIRST_ONE);
    signal state, next_state : state_type;

    signal run : std_logic := '0';
    signal dot_duration   : INTEGER := 5000000; -- 0.5 seconds for 50MHz clock
    signal dash_duration  : INTEGER := 150000000; -- 1.5 seconds for 50MHz clock
    signal pause_duration : INTEGER := 100000000; -- 1 second pause

    signal count : INTEGER := 0;
    signal current_time : INTEGER := 0;
    signal morse_code : STD_LOGIC_VECTOR(7 downto 0);
    signal select1 : STD_LOGIC_VECTOR(2 downto 0);
    signal first_one_found : BOOLEAN := false;

    function bin_to_7seg (digit : STD_LOGIC_VECTOR(2 downto 0)) return STD_LOGIC_VECTOR is
    begin
        case digit is
            when "000" => return "0001000";  -- A
            when "001" => return "0000011";  -- B
            when "010" => return "1000110";  -- C
            when "011" => return "0100001";  -- D
            when "100" => return "0000110";  -- E
            when "101" => return "0001110";  -- F
            when "110" => return "0000010";  -- G
            when "111" => return "0001001";  -- H
            when others => return "1111111";  -- Display off
        end case;
    end function;

begin
    select1 <= sw2 & sw1 & sw0;

    -- Morse code definitions for A-H
    process (select1)
    begin
        hex0 <= bin_to_7seg(select1);

        case select1 is
            when "000" => morse_code <= "10100000"; -- A: .-
            when "001" => morse_code <= "00011000"; -- B: -...
            when "010" => morse_code <= "01011000"; -- C: -.-.
            when "011" => morse_code <= "00110000"; -- D: -..
            when "100" => morse_code <= "01000000"; -- E: .
            when "101" => morse_code <= "01001000"; -- F: ..-.
            when "110" => morse_code <= "01110000"; -- G: --.
            when "111" => morse_code <= "00001000"; -- H: ....
            when others => morse_code <= "00000000"; -- Default
        end case;
    end process;

    -- State machine process
    process (clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            led <= '0';
            count <= 0;
            current_time <= 0;
            first_one_found <= false;
            run <= '0';  -- Stop running on reset
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    led <= '0';
                    current_time <= 0;
                    count <= 0;
                    first_one_found <= false;
                    if key0 = '0' then
                        run <= '1';  -- Start the run sequence
                        state <= FIND_FIRST_ONE;  -- Start searching for the first 1
                    end if;

                when FIND_FIRST_ONE =>
                    if count < 8 then
                        if morse_code(count) = '1' then
                            first_one_found <= true;
                            count <= count + 1; -- Move to the next element
                            state <= PAUSE;
                        else
                            count <= count + 1; -- Increment count
                            state <= FIND_FIRST_ONE;
                        end if;
                    else
                        state <= IDLE; -- Restart after full message
                        count <= 0;
                    end if;

                when DOT =>
                    led <= '1';
                    current_time <= current_time + 1;
                    if current_time >= dot_duration then
                        led <= '0';
                        state <= PAUSE;
                        current_time <= 0;
                    end if;

                when DASH =>
                    led <= '1';
                    current_time <= current_time + 1;
                    if current_time >= dash_duration then
                        led <= '0';
                        state <= PAUSE;
                        current_time <= 0;
                    end if;

                when PAUSE =>
                    current_time <= current_time + 1;
                    if current_time >= pause_duration then
                        if count < 8 then
                            if morse_code(count) = '1' then
                                state <= DASH;
                            else
                                state <= DOT;
                            end if;
                            count <= count + 1; -- Move to the next bit
                        else
                            state <= IDLE; -- Restart after full message
                            count <= 0;
                        end if;
                        current_time <= 0;
                    end if;
            end case;
        end if;
    end process;

end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY part3 IS
PORT (
    Clk, D : IN STD_LOGIC;
    Q : OUT STD_LOGIC
);
END part3;

ARCHITECTURE Structural OF part3 IS
    SIGNAL Qa, Qb : STD_LOGIC;
BEGIN
    PROCESS (Clk)
    BEGIN
        IF (Clk = '1') THEN
            Qa <= D;
        END IF;
    END PROCESS;
    
    Q <= Qa;
END Structural;


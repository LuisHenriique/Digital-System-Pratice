LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part2 IS
PORT ( Clk, D : IN STD_LOGIC;
Q, nQ : OUT STD_LOGIC);
END part2;
ARCHITECTURE Structural OF part2 IS
SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
R_g <= NOT(NOT(D) AND Clk);
S_g <= NOT(D AND Clk);
Qa <= NOT (S_g AND Qb);
Qb <= NOT (R_g AND Qa);
Q <= Qa;
nQ <= Qb;
END Structural;
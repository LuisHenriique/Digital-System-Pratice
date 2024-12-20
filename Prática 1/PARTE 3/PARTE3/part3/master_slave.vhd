
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY master_slave_ff IS
PORT (
    D, Clk : IN STD_LOGIC;
    Q : OUT STD_LOGIC
);
END master_slave_ff;

ARCHITECTURE behavior OF master_slave_ff IS
    SIGNAL Q_master : STD_LOGIC;
    SIGNAL Clk_inv : STD_LOGIC;
BEGIN
    -- Generate the inverted clock signal
    Clk_inv <= NOT Clk;

    -- Instantiate the master gated D latch
    master_latch: ENTITY work.part3
    PORT MAP (
        D => D,
        Clk => Clk,
        Q => Q_master
    );

    -- Instantiate the slave gated D latch
    slave_latch: ENTITY work.part3
    PORT MAP (
        D => Q_master,
        Clk => Clk_inv,
        Q => Q
    );
END behavior;


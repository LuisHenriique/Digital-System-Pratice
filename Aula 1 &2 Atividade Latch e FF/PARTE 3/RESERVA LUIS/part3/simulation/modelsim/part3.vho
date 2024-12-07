-- Copyright (C) 2021  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"

-- DATE "08/27/2024 16:05:18"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	master_slave_ff IS
    PORT (
	D : IN std_logic;
	Clk : IN std_logic;
	Q : OUT std_logic
	);
END master_slave_ff;

-- Design Ports Information
-- Q	=>  Location: PIN_AA2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Clk	=>  Location: PIN_V13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D	=>  Location: PIN_U13,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF master_slave_ff IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_D : std_logic;
SIGNAL ww_Clk : std_logic;
SIGNAL ww_Q : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \Clk~input_o\ : std_logic;
SIGNAL \Clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \D~input_o\ : std_logic;
SIGNAL \master_latch|Qa~feeder_combout\ : std_logic;
SIGNAL \master_latch|Qa~q\ : std_logic;
SIGNAL \slave_latch|Qa~feeder_combout\ : std_logic;
SIGNAL \slave_latch|Qa~q\ : std_logic;
SIGNAL \ALT_INV_Clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \ALT_INV_D~input_o\ : std_logic;
SIGNAL \master_latch|ALT_INV_Qa~q\ : std_logic;

BEGIN

ww_D <= D;
ww_Clk <= Clk;
Q <= ww_Q;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_Clk~inputCLKENA0_outclk\ <= NOT \Clk~inputCLKENA0_outclk\;
\ALT_INV_D~input_o\ <= NOT \D~input_o\;
\master_latch|ALT_INV_Qa~q\ <= NOT \master_latch|Qa~q\;

-- Location: IOOBUF_X0_Y18_N79
\Q~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \slave_latch|Qa~q\,
	devoe => ww_devoe,
	o => ww_Q);

-- Location: IOIBUF_X33_Y0_N58
\Clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Clk,
	o => \Clk~input_o\);

-- Location: CLKCTRL_G4
\Clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \Clk~input_o\,
	outclk => \Clk~inputCLKENA0_outclk\);

-- Location: IOIBUF_X33_Y0_N41
\D~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D,
	o => \D~input_o\);

-- Location: LABCELL_X10_Y4_N42
\master_latch|Qa~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \master_latch|Qa~feeder_combout\ = ( \D~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_D~input_o\,
	combout => \master_latch|Qa~feeder_combout\);

-- Location: FF_X10_Y4_N44
\master_latch|Qa\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputCLKENA0_outclk\,
	d => \master_latch|Qa~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \master_latch|Qa~q\);

-- Location: LABCELL_X10_Y4_N12
\slave_latch|Qa~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \slave_latch|Qa~feeder_combout\ = ( \master_latch|Qa~q\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \master_latch|ALT_INV_Qa~q\,
	combout => \slave_latch|Qa~feeder_combout\);

-- Location: FF_X10_Y4_N13
\slave_latch|Qa\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_Clk~inputCLKENA0_outclk\,
	d => \slave_latch|Qa~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \slave_latch|Qa~q\);

-- Location: MLABCELL_X49_Y16_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;



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

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"
-- CREATED		"Tue Aug 27 15:21:09 2024"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY parte4blck IS 
	PORT
	(
		pin_name1 :  IN  STD_LOGIC;
		pin_name2 :  IN  STD_LOGIC;
		qa :  OUT  STD_LOGIC;
		nqa :  OUT  STD_LOGIC;
		qb :  OUT  STD_LOGIC;
		nqb :  OUT  STD_LOGIC;
		qc :  OUT  STD_LOGIC;
		nqc :  OUT  STD_LOGIC
	);
END parte4blck;

ARCHITECTURE bdf_type OF parte4blck IS 

COMPONENT part4
	PORT(D : IN STD_LOGIC;
		 Clk : IN STD_LOGIC;
		 Q : OUT STD_LOGIC;
		 nQ : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT fpd
	PORT(D1 : IN STD_LOGIC;
		 Clk1 : IN STD_LOGIC;
		 Q1 : OUT STD_LOGIC;
		 nQ1 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT fpcd
	PORT(D2 : IN STD_LOGIC;
		 Clk2 : IN STD_LOGIC;
		 Q2 : OUT STD_LOGIC;
		 nQ2 : OUT STD_LOGIC
	);
END COMPONENT;



BEGIN 



b2v_inst : part4
PORT MAP(D => pin_name1,
		 Clk => pin_name2,
		 Q => qa,
		 nQ => nqa);


b2v_inst2 : fpd
PORT MAP(D1 => pin_name1,
		 Clk1 => pin_name2,
		 Q1 => qb,
		 nQ1 => nqb);


b2v_inst3 : fpcd
PORT MAP(D2 => pin_name1,
		 Clk2 => pin_name2,
		 Q2 => qc,
		 nQ2 => nqc);


END bdf_type;
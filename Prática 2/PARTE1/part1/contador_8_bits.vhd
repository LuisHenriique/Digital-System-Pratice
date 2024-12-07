library IEEE;
use IEEE.std_logic_1164.all;

entity contador_8_bits is
    port (
        Entry : in std_logic;
        Clock : in std_logic;
        Clear_all : in std_logic;
        -- Outputs for the 7-segment displays
        seg_a1 : out std_logic;
        seg_b1 : out std_logic;
        seg_c1 : out std_logic;
        seg_d1 : out std_logic;
        seg_e1 : out std_logic;
        seg_f1 : out std_logic;
        seg_g1 : out std_logic;
        seg_a2 : out std_logic;
        seg_b2 : out std_logic;
        seg_c2 : out std_logic;
        seg_d2 : out std_logic;
        seg_e2 : out std_logic;
        seg_f2 : out std_logic;
        seg_g2 : out std_logic
    );
end entity contador_8_bits;

architecture Behaviour of contador_8_bits is
    signal out0 : std_logic;
    signal and0 : std_logic;

    signal out1 : std_logic;
    signal and1 : std_logic;

    signal out2 : std_logic;
    signal and2 : std_logic;

    signal out3 : std_logic;
    signal and3 : std_logic;

    signal out4 : std_logic;
    signal and4 : std_logic;

    signal out5 : std_logic;
    signal and5 : std_logic;

    signal out6 : std_logic;
    signal and6 : std_logic;

    signal out7 : std_logic;

    -- Signals for binary to 7-segment decoding
    signal high_nibble : std_logic_vector(3 downto 0);
    signal low_nibble  : std_logic_vector(3 downto 0);

    signal segs1 : std_logic_vector(6 downto 0);
    signal segs2 : std_logic_vector(6 downto 0);

    component t_ff is
        port (
            Enable : in std_logic;
            Clk : in std_logic;
            Clear : in std_logic;
            Q : out std_logic
        );
    end component;

    component decoder_7seg is
        port (
            binary_input : in std_logic_vector(3 downto 0);
            segments     : out std_logic_vector(6 downto 0)
        );
    end component;

begin

    -- Instantiating the flip-flops for the 8-bit counter
    t0 : t_ff port map(
        Enable => Entry,
        Clk => Clock,
        Clear => Clear_all,
        Q => out0
    );

    and0 <= out0 and Entry;

    t1 : t_ff port map(
        Enable => and0,
        Clk => Clock,
        Clear => Clear_all,
        Q => out1
    );

    and1 <= out1 and and0;

    t2 : t_ff port map(
        Enable => and1,
        Clk => Clock,
        Clear => Clear_all,
        Q => out2
    );

    and2 <= out2 and and1;

    t3 : t_ff port map(
        Enable => and2,
        Clk => Clock,
        Clear => Clear_all,
        Q => out3
    );

    and3 <= out3 and and2;

    t4 : t_ff port map(
        Enable => and3,
        Clk => Clock,
        Clear => Clear_all,
        Q => out4
    );

    and4 <= out4 and and3;

    t5 : t_ff port map(
        Enable => and4,
        Clk => Clock,
        Clear => Clear_all,
        Q => out5
    );

    and5 <= out5 and and4;

    t6 : t_ff port map(
        Enable => and5,
        Clk => Clock,
        Clear => Clear_all,
        Q => out6
    );

    and6 <= out6 and and5;

    t7 : t_ff port map(
        Enable => and6,
        Clk => Clock,
        Clear => Clear_all,
        Q => out7
    );

    -- Divide the 8-bit counter output into high and low nibbles
    high_nibble <= out7 & out6 & out5 & out4;  -- High nibble
    low_nibble  <= out3 & out2 & out1 & out0;  -- Low nibble

    -- Instantiate the decoders for both nibbles
    decoder1 : decoder_7seg port map(
        binary_input => high_nibble,
        segments     => segs1
    );

    decoder2 : decoder_7seg port map(
        binary_input => low_nibble,
        segments     => segs2
    );

    -- Map the segments of the first display
    seg_a1 <= segs2(0);
    seg_b1 <= segs2(1);
    seg_c1 <= segs2(2);
    seg_d1 <= segs2(3);
    seg_e1 <= segs2(4);
    seg_f1 <= segs2(5);
    seg_g1 <= segs2(6);

    -- Map the segments of the second display
    seg_a2 <= segs1(0);
    seg_b2 <= segs1(1);
    seg_c2 <= segs1(2);
    seg_d2 <= segs1(3);
    seg_e2 <= segs1(4);
    seg_f2 <= segs1(5);
    seg_g2 <= segs1(6);

end architecture Behaviour;

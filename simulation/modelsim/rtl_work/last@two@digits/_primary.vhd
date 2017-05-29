library verilog;
use verilog.vl_types.all;
entity lastTwoDigits is
    port(
        s0              : in     vl_logic;
        s1              : in     vl_logic;
        s2              : in     vl_logic;
        s3              : in     vl_logic;
        s4              : in     vl_logic;
        s5              : in     vl_logic;
        s6              : in     vl_logic;
        s7              : in     vl_logic;
        firstOutput     : out    vl_logic;
        lastOutput      : out    vl_logic;
        combinedOutput  : out    vl_logic
    );
end lastTwoDigits;

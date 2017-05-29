module lab8 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
input logic CLOCK_50; // 50MHz clock.
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed
input logic [9:0] SW;
//turn off other hex

assign HEX2 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
logic [31:0] clk;
parameter whichClock = 23;
clock_divider cdiv (CLOCK_50, clk);
// Hook up FSM inputs and outputs.
logic reset, isOpen, isClose ;
logic [1:0] up;
logic [5:0] requestF,desF, currentF;
logic [6:0] in;

assign reset = ~KEY[0]; // Reset when KEY[0] is pressed.

	// request floor
	 checkInput i1(.clk(CLOCK_50), .reset, .in(SW[0]), .out(in[0]));  userIn u1(.clk(CLOCK_50), .reset, .in(in[0]),  .currentF,.thisF(6'b000001), .out(requestF[0]));
	 checkInput i2(.clk(CLOCK_50), .reset, .in(SW[1]), .out(in[1]));	userIn u2(.clk(CLOCK_50), .reset, .in(in[1]),  .currentF,.thisF(6'b000010), .out(requestF[1]));
	 checkInput i3(.clk(CLOCK_50), .reset, .in(SW[2]), .out(in[2]));	userIn u3(.clk(CLOCK_50), .reset, .in(in[2]),  .currentF,.thisF(6'b000100), .out(requestF[2]));
	 checkInput i4(.clk(CLOCK_50), .reset, .in(SW[3]), .out(in[3]));	userIn u4(.clk(CLOCK_50), .reset, .in(in[3]),  .currentF,.thisF(6'b001000), .out(requestF[3]));
	 checkInput i5(.clk(CLOCK_50), .reset, .in(SW[4]), .out(in[4]));	userIn u5(.clk(CLOCK_50), .reset, .in(in[4]),  .currentF,.thisF(6'b010000), .out(requestF[4]));
	 checkInput i6(.clk(CLOCK_50), .reset, .in(SW[5]), .out(in[5]));	userIn u6(.clk(CLOCK_50), .reset, .in(in[5]),  .currentF,.thisF(6'b100000), .out(requestF[5]));
	//close the door
	checkInput i7(.clk(CLOCK_50), .reset, .in(~KEY[1]), .out(in[6]));  
	closed c1 (.reset, .clk(CLOCK_50), .in(in[6]), .isOpen, .out(isClose)) ;
	//direction
	 direction d1 ( .clk(CLOCK_50), .reset, .desF, .currentF, .up);
	//keep moving until see the destination floor, indicate the destination floor
	destinationF d2 (.clk(CLOCK_50), .reset,.currentF, .requestF, .up, .desF);
	
	//open the door reach the destination
	door d3( .clk(CLOCK_50), .reset,.isClose, .currentF, .west(LEDR[9]), .east(LEDR[8]));
	// moving the floor
	floor f1(.clk(CLOCK_50), .reset, .desF,.requestF, .isClose, .up,.currentF, .isOpen);
	display d4(.clk(CLOCK_50), .reset, .currentF, .out1(HEX1),.out0(HEX0));
	
//assign led
	assign LEDR[5:0] = requestF[5:0];
	
	assign LEDR [7:6] = up;
endmodule

module clock_divider (clock, divided_clocks);
input logic clock;
output logic [31:0] divided_clocks;
initial
divided_clocks = 0;
always_ff @(posedge clock)
divided_clocks = divided_clocks + 1;
endmodule


module lab8_testbench();
logic clk;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic [3:0] KEY;
logic [9:0] SW;
// Set up the clock.
parameter CLOCK_PERIOD=100;
initial begin
clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk;
end
lab8 dut (.CLOCK_50(clk),.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);
// Set up the inputs to the design. Each line is a clock cycle.
initial begin
	KEY[0]<=0;KEY[1]<=1;SW[5:0]<=6'b111110;@(posedge clk);
	KEY[0]<=1;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	SW<=6'b000001;@(posedge clk);
	KEY[1]<=0;@(posedge clk);
	KEY[1]<=1;@(posedge clk);
	
$stop; // End the simulation.
end
endmodule
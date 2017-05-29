//** Check input that only accept when in one click**/

module checkInput(clk, reset, in,  out);
	input logic clk, reset,in;
	output logic out;
	logic ps,ns;
	parameter A = 1'b1, B =1'b0;



	always_comb
	case(ps)
	A: if(in) ns = A;
	else ns =B;
	B: if(in) ns=A;
	else ns = B; 
	endcase	
	assign out = ~ps*in;
	// DFFs
	always_ff @(posedge clk) 
	if (reset)
	ps <= B;
	else
	ps <= ns;
endmodule 
//do matastability 
//module stability (clk, reset, in,out);
//	input logic   clk, reset,in;
//	output logic out;	
//// DFFs
//	always_ff @(posedge clk) 
//	if (reset)
//	out <= 0;
//	else 
//	out <= in;
//endmodule

module checkInput_testbench();
 logic clk, reset,in;
 logic out;
checkInput dut (.clk, .reset,.in, .out);
 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
in<=0;reset<=1; @(posedge clk);
reset<=0;@(posedge clk);
in<=1;@(posedge clk);
in<=0;@(posedge clk);@(posedge clk);
in<=1;@(posedge clk);@(posedge clk);@(posedge clk);@(posedge clk);
$stop;
end
endmodule 
/** close the door**/
module closed (reset, clk, in, isOpen, out) ;
input logic clk, reset, in, isOpen;

output logic out;
parameter A=1'b0, B =1'b1;
logic ps,ns;
always_comb 
case(ps) 
A:  if(in) ns = B;
			else ns = A;
			
B:  if(in==0 && isOpen == 1)ns =A;
			else ns=B;
			
endcase

assign out = in +(ps*~isOpen);
always_ff @(posedge clk)
if (reset)ps<=A;
//else if (isOpen) ps <=A;
else ps<=ns;
endmodule

module closed_testbench();
 logic clk, reset,in,isOpen;
 logic out;
closed dut (.clk, .reset,.in,.isOpen, .out);
 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
in<=0;isOpen<=0;reset<=1; @(posedge clk);
reset<=0;@(posedge clk);
in<=1;@(posedge clk);
in<=0;@(posedge clk);@(posedge clk);
@(posedge clk);
isOpen<=1;@(posedge clk);@(posedge clk);@(posedge clk);
isOpen<=0;@(posedge clk);@(posedge clk);@(posedge clk);
$stop ;
end
endmodule 
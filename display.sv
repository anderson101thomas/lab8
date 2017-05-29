module display(clk, reset , currentF, out1, out0);
input logic clk, reset;
input logic [5:0]currentF;
output logic [0:6] out1,out0;

parameter F1 = 6'b000001, F2 = 6'b000010 , F2M = 6'b000100, F3 = 6'b001000, F3M = 6'b010000, F4 = 6'b100000;	
always_ff @(posedge clk)
if (reset) begin out1  <= 7'b1111001;
						out0 <=7'b1111111; end
else begin
if (currentF == F1) begin out1 <= 7'b1111001; // 1
									out0<= 7'b1111111;end
else if(currentF ==F2)  begin out1 <=7'b0100100; // 2
										out0<= 7'b1111111;end
else if(currentF ==F2M)  begin out1 <=7'b0110000; // 2M
										out0<= 7'b0111111;end
else if (currentF == F3)begin out1 <= 7'b0110000; // 3
								out0<= 7'b1111111;end
else if (currentF == F3M)begin out1 <= 7'b0011001; // 3M
								out0<= 7'b0111111;end

else begin out1 <= 7'b0011001; // 4
out0<= 7'b1111111;end
end

endmodule

module display_testbench();
 logic clk, reset;
 logic [5:0]currentF;
 logic [0:6] out1,out0;
 parameter F1 = 6'b000001, F2 = 6'b000010 , F2M = 6'b000100, F3 = 6'b001000, F3M = 6'b010000, F4 = 6'b100000;	
display dut(clk, reset , currentF, out1, out0);
 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
currentF<=F1;reset<=1; @(posedge clk);
reset<=0;@(posedge clk);
currentF<=F2;@(posedge clk);@(posedge clk);
currentF<=F3;@(posedge clk);@(posedge clk);
$stop;
end
endmodule 
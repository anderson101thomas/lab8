module door ( clk, reset,isClose, currentF, west, east);

input logic clk, isClose, reset;
input logic [5:0] currentF;
output logic west, east;
parameter F1 = 6'b000001, F2 = 6'b000010 , F2M = 6'b000100, F3 = 6'b001000, F3M = 6'b010000, F4 = 6'b100000;	
always_ff @(posedge clk) begin
if (reset ) begin
						west <= 1;
						east <= 1;
						end
else if (isClose ) begin
						west <= 0;
						east <= 0;
						end
else
	if(currentF == F1) begin	west <= 1;
						east <= 1;
				end
	else if(currentF == F2) begin 	west <=0;
							east <=1;
					end
	else if(currentF == F2M) begin 	west <=1;
							east <=0;
					end
	else if(currentF == F3) begin 	west <=1;
							east <=0;
					end
	else if(currentF == F3M) begin 	west <=0;
							east <=1;
					end
	else if(currentF ==F4) begin 	west <=1;
							east <=1;
					end
	else begin west <= 1'bx;
					east <= 1'bx;
			end
end

endmodule


module door_testbench();
 logic clk, isClose, reset;
 logic [5:0] currentF;
 logic west, east;
 parameter F1 = 6'b000001, F2 = 6'b000010 , F2M = 6'b000100, F3 = 6'b001000, F3M = 6'b010000, F4 = 6'b100000;	
door dut( clk, reset,isClose, currentF, west, east);

 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
currentF<=F1;isClose<=1;reset<=1; @(posedge clk);
reset<=0;@(posedge clk);
@(posedge clk);@(posedge clk);
isClose<=0;@(posedge clk);@(posedge clk);
currentF<=F2;@(posedge clk);@(posedge clk);
$stop;
end
endmodule 

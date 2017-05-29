/* indicate the final floor*/
module destinationF (clk, reset,currentF, requestF, up, desF);
input logic clk, reset;
input logic [1:0] up;
input logic [5:0] requestF, currentF;
output logic [5:0]desF;
// if up is true, the highest floor will take piority, otherwise.
always_ff @ (posedge clk) begin
if (reset) desF <= currentF;
else begin
if (up[1]) begin
	if(requestF[5]) desF <= 6'b100000;
	else if (requestF [4]) desF <= 6'b010000;
	else if (requestF [3]) desF <= 6'b001000;
	else if (requestF [2]) desF <= 6'b000100;
	else if (requestF [1]) desF <= 6'b000010;
	else if (requestF [0]) desF <= 6'b000001;
	else desF <= currentF;
	end 
	else if(up[0]) begin
	if (requestF [0]) desF <= 6'b000001;
	else if (requestF [1]) desF <= 6'b000010;
	else if (requestF[2]) desF <= 6'b000100;
	else if (requestF [3]) desF <= 6'b001000;
	else if (requestF [4]) desF <= 6'b010000;
	else if (requestF[5]) desF <= 6'b100000;
	else desF <= currentF;
	end
	else 
	begin
	if (requestF [0]) desF <= 6'b000001;
	else if (requestF [1]) desF <= 6'b000010;
	else if (requestF[2]) desF <= 6'b000100;
	else if (requestF [3]) desF <= 6'b001000;
	else if (requestF [4]) desF <= 6'b010000;
	else if (requestF[5]) desF <= 6'b100000;
	else desF <= currentF;
	
end
end

end	
endmodule 
module destinationF_testbench();
 logic clk, reset;
 logic [1:0] up;
 logic [5:0] requestF, currentF;
 logic [5:0]desF;
destinationF dut(clk, reset,currentF, requestF, up, desF);
 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
currentF<=6'b0;up<=2'b0;reset<=1; @(posedge clk);
reset<=0;@(posedge clk);
up[0]<=1; requestF[5]=1;@(posedge clk);
up[0]<=0;up[1]<=1;requestF[3]=1;@(posedge clk);
@(posedge clk);
$stop;
end
endmodule 
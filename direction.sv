/* up or down dir*/
module direction( clk, reset, desF, currentF, up);
input logic clk, reset;
input logic [5:0] desF, currentF;
output logic [1:0]up;

always_ff @ (posedge clk) begin
if (reset) up <= 2'b00;
// change direction depend on final floor
else begin
if (desF > currentF ) up <=2'b10;
else if (desF == currentF) up<= 2'b00;
else up<= 2'b01;
end
end
endmodule

module direction_testbench();
 logic clk, reset;
 logic [5:0] desF, currentF;
 logic [1:0]up;
direction dut( clk, reset, desF, currentF, up);
 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
currentF<=6'b0;desF<=6'b1;reset<=1; @(posedge clk);
reset<=0;@(posedge clk);
@(posedge clk);@(posedge clk);
currentF<=6'b1;@(posedge clk);@(posedge clk);
currentF<=2;@(posedge clk);@(posedge clk);
$stop;
end
endmodule 

/** move the floor to the destination. Keep moving up/ down depend on the location of the destination floor**/
module floor (clk, reset, desF,requestF, isClose, up,currentF, isOpen);
	input logic clk, reset, isClose;
	input logic [1:0] up;
	input logic [5:0] desF,requestF;
	output logic [5:0] currentF;
	output logic isOpen;
	logic[5:0] thisF, nextF;
	logic nextOpen, open; 
	parameter F1 = 6'b000001, F2 = 6'b000010 , F2M = 6'b000100, F3 = 6'b001000, F3M = 6'b010000, F4 = 6'b100000;	
	always_comb
	case (nextF)
		F1: begin
				if (requestF[0]) begin  thisF = F1;
												open = 1;
									  end
				else begin
				
						if(requestF != 6'b0)begin if (isClose) begin 
														thisF = F2;
														open = 0;
														end
													
															else begin thisF = F1;
															open = 1;
														end
													end
						else begin if (isClose) begin 
														thisF = F1;
														open = 0;
														end
													
														else begin thisF = F1;
														open = 1;
														end
													end
															
				end
				
			end
			
		F2: begin 
				
				if (requestF[1]) begin thisF = F2;
												open = 1;
										end
				
				else if (currentF == desF) begin thisF =  F2; if (isClose) open = 0;
												else open = 1;
					 end
				else   begin if(isClose) begin open = 0; if(up[1]) thisF = F2M;
											  else thisF = F1;
											  end
								else begin open = 1; thisF=F2; end
						end
													
				end
				
		F2M:begin 
				
				if (requestF[2]) begin thisF = F2M;
												open = 1;
										end
				else if (currentF == desF) begin thisF =  F2M; if (isClose) open = 0;
												else open = 1;
					 end
				else   begin if(isClose) begin open = 0; if(up[1]) thisF = F3;
											  else thisF = F2;
											  end
								else begin open = 1; thisF=F2M; end
						end
												
													
				end
				

		F3: begin 
				
				if (requestF[3]) begin thisF = F3;
												open = 1;
										end
				else if (currentF == desF) begin thisF =  F3; if (isClose) open = 0;
												else open = 1;
					 end
				else   begin if(isClose) begin open = 0; if(up[1]) thisF = F3M;
											  else thisF = F2M;
											  end
								else begin open = 1; thisF=F3; end
						end
																					
				end

		F3M: begin 
	 
				
				if (requestF[4]) begin thisF = F3M;
												open = 1;
										end
				else if (currentF == desF) begin thisF =  F3M; if (isClose) open = 0;
												else open = 1;
					 end
				else   begin if(isClose) begin open = 0; if(up[1]) thisF = F4;
											  else thisF = F3;
											  end
								else begin open = 1; thisF=F3M;end
						end
																									
				end

		F4: begin
				if (requestF[5]) begin  thisF = F4;
												open = 1;
									  end
				else begin
				
						if(requestF != 6'b0)begin if (isClose) begin 
														thisF = F3M;
														open = 0;
														end
													
															else begin thisF = F4;
															open = 1;
														end
													end
						else begin if (isClose) begin 
														thisF = F4;
														open = 0;
														end
													
														else begin thisF = F4;
														open = 1;
														end
													end
															
				end
				
			end
		default: begin thisF = 6'bx;
							open = 1'bx;
							end
	endcase
	assign currentF = nextF;
	assign isOpen = nextOpen;
	always_ff @ (posedge clk) begin
	if (reset) begin nextF <= 6'b000001;
							nextOpen <= 1 ;
					end
	else begin
		nextF <= thisF;
		nextOpen <= open;
		end
end
	
endmodule

module floor_testbench();
	 logic clk, reset, isClose;
	 logic [1:0] up;
	 logic [5:0] desF,requestF;
	 logic [5:0] currentF;
	 logic isOpen;
	 parameter F1 = 6'b000001, F2 = 6'b000010 , F2M = 6'b000100, F3 = 6'b001000, F3M = 6'b010000, F4 = 6'b100000;	
floor dut(.clk, .reset, .desF,.requestF, .isClose, .up,.currentF, .isOpen);
 // Set up the clk.
 parameter clk_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(clk_PERIOD/2) clk <= ~clk;
 end
 // Set up the inputs to the design. Each line is a clk cycle.
 initial begin
reset<=1; isClose<=0;up<=2'b0;requestF<=6'b0;desF<=F1;@(posedge clk);
reset<=0;@(posedge clk); @(posedge clk);
isClose<=1; @(posedge clk);
up<=2'b10; @(posedge clk);requestF[3]<=1;@(posedge clk);requestF[3]<=0;
@(posedge clk);requestF[2]<=1;@(posedge clk);@(posedge clk);@(posedge clk);
$stop;
end
endmodule 
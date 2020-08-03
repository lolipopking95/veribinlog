module flipflop (
    input wire reset,
    input wire clk,
    input wire set,
    input wire enable,
	input wire d,
    output reg q
);
always @ (posedge clk or posedge reset)
    if (reset)
       q <= 1'b0;
    else
    if(set)
	   q <= 1'b1;
	else 
	if (enable)
	   q <= d;
endmodule


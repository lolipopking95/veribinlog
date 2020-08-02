module mux(
    input wire a,
    input wire b,
	input wire sel,
    output  reg q);
always @*
begin
  case(sel)
    2'b00: q = a;
    2'b01: q = b;
  default:
      q = 0; 
  endcase
end


endmodule


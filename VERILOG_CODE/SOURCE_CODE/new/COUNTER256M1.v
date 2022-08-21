`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module COUNTER256M1(inp_add,
                  done256,
                  clk,
                  rst,
                  en_256,
                  rst_256);
output[7:0] inp_add;
output done256;
input clk,
      rst,
      en_256,
      rst_256;

reg[7:0] count;
wire[7:0] wire_in;
wire[8:0] wire_out;

always @(posedge clk)
 begin
  if(rst)
   count<= #3 8'b0;
  else if(rst_256)
   count<= #3 8'b0; 
  else if(en_256)
   count<= #3 wire_out[7:0]; 
 end   
 
assign  wire_out=wire_in+1;
assign wire_in=count;

// output declaration 
assign inp_add=count;
assign done256=wire_out[8];
                
endmodule

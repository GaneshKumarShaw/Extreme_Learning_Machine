`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module SPIPO(data_out,
             clk,
             data_in,
             load,
             rst,
             Srst);
parameter n=16, // multiplicand width size 
          m=16; // mulitplier width size 
output reg[m-1:0] data_out;
input[m-1:0] data_in;
input clk,
      rst,
      load,
      Srst;           
always @(posedge clk)
begin
 if(rst)
  data_out<=16'b0;
 else if(Srst)
  data_out<=16'b0;
 else if(load)
  data_out<=data_in;
 else
  data_out<=data_out;
end          
endmodule

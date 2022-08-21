`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module PIPOPM1(data_out,
             clk,
             data_in,
             rst,
             load);
             
parameter acc_width=16;  // width of accumulator 

output reg[acc_width-1:0] data_out;
input[acc_width-1:0] data_in;  
input clk,
      rst,
      load;
always @(posedge clk)
begin
 if(rst)
  data_out<= #3 16'b0;
 else if(load)
  data_out<= #3 data_in; 
end                       
endmodule

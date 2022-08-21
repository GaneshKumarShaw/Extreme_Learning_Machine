`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module PIPOAM3(data_out,
             clk,
             data_in,
             rst,
             load,
             RST);
             
parameter acc_width=32;  // width of accumulator 

output reg[acc_width-1:0] data_out;
input[acc_width-1:0] data_in;  
input clk,
      rst,
      load,
      RST;
always @(posedge clk)
begin
 if(rst)
  data_out<= #3 0;
 else if(RST)
  data_out<= #3 0;
 else if(load)
  data_out<= #3 data_in; 
end                       
endmodule

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module PISO( data_out,
             clk,
             data_in,
              load,
             shift_data,
             shift,
             rst);
parameter n=16, // multiplicand width size 
          m=16; // mulitplier width size 
output reg[m-1:0] data_out;
input[m-1:0] data_in;
input clk,
      load,
      shift_data,
      shift,
      rst;     
always @(posedge clk)
begin
 if(rst)
  data_out<=16'b0;
 else if(load)
  data_out<=data_in;
 else if(shift)
  data_out<={shift_data,data_out[m-1:1]};
 else
  data_out<=data_out;  
end  
    
endmodule

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module PIPO(data_out,
            clk,
            data_in,
            load,
            rst);
parameter n=16, // multiplicand width size 
          m=16; // mulitplier width size  
output reg[n-1:0] data_out;
input[n-1:0] data_in;
input clk,
      rst,
      load;

always @(posedge clk)
begin
 if(rst)
  data_out<=16'b0;
 else if(load)
  data_out<=data_in;
 else
  data_out<=data_out;
end      
                  
endmodule

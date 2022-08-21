`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module COMP2S(data_out,
              data_in);
parameter n=16, // multiplicand width size 
          m=16; // mulitplier width size 
output[n-1:0] data_out;
input[n-1:0] data_in;
wire[n:0] comp;
assign comp=17'b1000_0000_0000_00000-{data_in[n-1],data_in};
assign data_out=comp[n-1:0];        
endmodule

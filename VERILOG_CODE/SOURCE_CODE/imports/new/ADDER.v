`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module ADDER(sum,
             dataL,
             dataR);
parameter n=16, // multiplicand width size 
          m=16; // mulitplier width size 
          
output[n:0] sum;
input[n-1:0] dataL,
             dataR;
wire[n-1:0] S;
assign S=dataL+dataR;
assign sum={S[n-1],S};            
endmodule

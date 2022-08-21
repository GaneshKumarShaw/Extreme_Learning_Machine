`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module ADDERM1(out,
               dataL,
               dataR);
parameter acc_width=16; // accumulator width 
output[acc_width-1:0] out;
input[acc_width-1:0] dataL,
                     dataR;
assign out=dataL+dataR;               
endmodule

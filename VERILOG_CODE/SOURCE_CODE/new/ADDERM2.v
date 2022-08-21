`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module ADDERM2(out,
               dataU,
               dataD);
parameter P_width=13;
output[P_width-1:0] out;
input[P_width-1:0] dataU,
                   dataD;   
assign out=dataU+dataD;                               
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module SADDERM2(out,
                dataL,
                dataR);
output[31:0] out;
input[31:0] dataL,
            dataR;
assign out=dataL+dataR;                            
endmodule

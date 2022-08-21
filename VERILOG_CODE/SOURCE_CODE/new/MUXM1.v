`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module MUXM1(out,
             data0,
             data1,
             sel);
parameter acc_width=16;
output[acc_width-1:0] out;
input[acc_width-1:0] data0,
                     data1;
input sel;

assign out=sel?data1:data0;               
endmodule

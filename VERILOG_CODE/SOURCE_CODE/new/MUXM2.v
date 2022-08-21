`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module MUXM2(out,
             data0,
             data1,
             sel);
output[3:0] out;
input[3:0] data0,
           data1; 
input sel;

assign out=sel?data1:data0;                       
endmodule

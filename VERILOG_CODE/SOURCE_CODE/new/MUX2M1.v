`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module MUX2M1(out,
             data0,
             data1,
             sel);
parameter lfsr_width=8;
output[lfsr_width-1:0] out;
input[lfsr_width-1:0] data0,
                     data1;
input sel;

assign out=sel?data1:data0;               
endmodule

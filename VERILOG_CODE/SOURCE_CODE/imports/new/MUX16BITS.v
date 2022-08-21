`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module MUX16BITS(data_out,
                 data0,
                 data1,
                 sel);
parameter n=16, // multiplicand width size 
          m=16; // mulitplier width size 
output[n-1:0] data_out;
input[n-1:0] data0,
             data1;
input sel;             
assign data_out=sel?data1:data0;                          
endmodule

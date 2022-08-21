`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module COMPARATORM3(out,
                    leq,
                    gt,
                    dataL,
                    dataR);
output[31:0] out;
output leq,
       gt;
input[31:0] dataL,
            dataR;
assign out=(dataL>dataR)?dataL:dataR;
assign gt=(dataL>dataR)?1'b1:1'b0;
not(leq,gt);                  
endmodule

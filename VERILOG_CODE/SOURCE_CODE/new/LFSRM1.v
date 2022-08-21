`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module LFSRM1(out,
              clk,
              rst,
              en_lfsr,
              rst_lfsr);
output reg[7:0] out;
input clk,
      rst,
      en_lfsr,
      rst_lfsr;
wire Q;

always @(posedge clk)
begin
 if(rst)
  out<= #3 8'b0;
 else if(rst_lfsr)
  out<= #3 8'b0;
 else if(en_lfsr)
  out<= #3 {Q,out[7:1]};  
end  


xnor(Q,out[4],out[3],out[2],out[0]);            

endmodule

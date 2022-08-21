`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module COUNTER9M3(count,
                  count9,
                  clk,
                  rst,
                  en_counter,
                  rst_counter);
output reg[3:0] count;
output reg count9;
input clk,
      rst,
      en_counter,
      rst_counter;
always @(posedge clk)
if(rst || rst_counter)
 begin
  count<= #3 0;
  count9<= #3 0;
 end
else if(en_counter)
 begin
  count<= #3 count+1;
  count9<= #3 count[3];
 end 
else 
 begin
  count<= #3 count;
  count9<= #3 count[3];
 end                            
endmodule

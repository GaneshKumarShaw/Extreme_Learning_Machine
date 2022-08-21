`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module COUNTER10M2(count,
                   count10,
                   clk,
                   rst,
                   en_ct,
                   rst_ct);
output[3:0] count;
output reg count10;
input clk,
      rst,
      en_ct,
      rst_ct;
reg[3:0] counter;
wire[3:0] wire_in,
          wire_out;
wire t;          
assign wire_out=wire_in+1;
assign wire_in=counter;
and(t,wire_out[3],counter[3]);                    
always @(posedge clk)
begin
 if(rst)
  counter<=4'b0;
 else if(rst_ct)
  counter<=4'b0;
 else if(en_ct)
  counter<=wire_out; 
end  

// output declaration 
assign count=counter;

always @(posedge clk)
if(rst)
 count10<=1'b0;
else if(rst_ct)
 count10<=1'b0;
else
 count10=t;                
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module COUNTER16(count16done, // one bit output
                 clk,
                 count16set,  // one bit input
                 count16reset,
                 rst);
output  count16done;  
input count16set,
      count16reset,
      rst,
      clk;

reg[3:0] count;
wire[3:0] wire_in;
wire[4:0] wire_out;

assign wire_out={1'b0,wire_in}+1;
assign wire_in=count;
always @(posedge clk)
begin
 if(rst)
  count<=#3 4'b0000;
 else if(count16reset) 
  count<=#3 4'b0000;
 else if(count16set)
  count<=#3 wire_out[3:0];
end  
// output declaration 
assign count16done=wire_out[4];
             
endmodule
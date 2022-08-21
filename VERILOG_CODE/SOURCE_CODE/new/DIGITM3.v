`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module DIGITM3(digit,
               clk,
               rst,
               en_digit,
               rst_digit,
               count_data);
output reg[9:0] digit;
input clk,
      rst,
      en_digit,
      rst_digit;
input[3:0] count_data;
reg[3:0] decode;
// decoder 
always @(posedge clk)
begin
case(count_data)
4'b0000:decode=10'b0000_0000_01;
4'b0001:decode=10'b0000_0000_10;
4'b0010:decode=10'b0000_0001_00;
4'b0011:decode=10'b0000_0010_00;
4'b0100:decode=10'b0000_0100_01;
4'b0101:decode=10'b0000_1000_10;
4'b0110:decode=10'b0001_0001_00;
4'b0111:decode=10'b0010_0010_00;
4'b1000:decode=10'b0100_0000_00;
4'b1001:decode=10'b1000_0000_00;
default:decode=10'b0000_0000_00;
endcase
end

always @(posedge clk)
if(rst || rst_digit)
digit<=10'b0;
else
digit<=decode;
endmodule

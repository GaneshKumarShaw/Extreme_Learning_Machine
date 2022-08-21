`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module tb_W21LUT;
wire[15:0] tb_out;
reg[12:0] tb_addr;
W21LUT w21lut(.out(tb_out),
              .addr(tb_addr));

integer i;
initial
begin
 $monitor($time,"tb_out=%b",tb_out);
 for(i=1;i<=5000;i=i+1)
 #20 tb_addr=($random)%5000;

end
endmodule

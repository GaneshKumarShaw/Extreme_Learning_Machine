`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module tb_LFSRM1;
wire [7:0] tb_out;
reg tb_clk,
      tb_rst,
      tb_en_lfsr,
      tb_rst_lfsr;
 LFSRM1 lfsrm1(.out(tb_out),
              .clk(tb_clk),
              .rst(tb_rst),
              .en_lfsr(tb_en_lfsr),
              .rst_lfsr(tb_rst_lfsr));
initial tb_clk=1'b0;
always #10 tb_clk=~tb_clk;  

initial 
begin
 $monitor($time,"tb_out=%b",tb_out);
 tb_rst=1'b1; tb_en_lfsr=1'b0; tb_rst_lfsr=1'b0;
 #25 tb_rst=1'b0; tb_en_lfsr=1'b1; tb_rst_lfsr=1'b0;
 #1000 tb_rst=1'b0; tb_en_lfsr=1'b0; tb_rst_lfsr=1'b1;
 #250 tb_rst=1'b0; tb_en_lfsr=1'b1; tb_rst_lfsr=1'b0;
 #250 tb_rst=1'b0; tb_en_lfsr=1'b0; tb_rst_lfsr=1'b0;
 
 #100 $finish;
end 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module tb_COUNTER9M3;
wire[3:0] tb_count;
wire tb_count9;
reg tb_clk,
    tb_rst,
    tb_en_counter,
    tb_rst_counter;
COUNTER9M3 ctM3(.count(tb_count),
                  .count9(tb_count9),
                  .clk(tb_clk),
                  .rst(tb_rst),
                  .en_counter(tb_en_counter),
                  .rst_counter(tb_rst_counter)); 

initial tb_clk=1'b0;
always #10 tb_clk=~tb_clk;

initial 
begin
 $monitor($time,"tb_count=%b",tb_count);
 tb_rst=1'b1; tb_en_counter=1'b0;tb_rst_counter=1'b0;
#25 tb_rst=1'b0; tb_en_counter=1'b0;tb_rst_counter=1'b1;
#25 tb_rst=1'b0; tb_en_counter=1'b0;tb_rst_counter=1'b0;
#25 tb_rst=1'b0; tb_en_counter=1'b1;tb_rst_counter=1'b0;
#200 tb_rst=1'b0; tb_en_counter=1'b0;tb_rst_counter=1'b0;
#20  $finish;
end
                  
endmodule

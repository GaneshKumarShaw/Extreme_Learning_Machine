`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_COUNTERPM1;
wire[8:0] tb_P_index;
wire tb_stop;
reg tb_clk,
     tb_rst,
     tb_en_P,
     tb_rst_P;
COUNTERPM1 counter_p(.P_index(tb_P_index),
                  .stop(tb_stop),
                  .clk(tb_clk),
                  .rst(tb_rst),
                  .en_P(tb_en_P),
                  .rst_P(tb_rst_P));
                  
initial tb_clk=1'b0;
always #10 tb_clk=~tb_clk;  

initial 
begin
 $monitor($time,"tb_P_index=%b",tb_P_index);
 tb_rst=1'b1; tb_en_P=1'b0; tb_rst_P=1'b0;
 #125 tb_rst=1'b0; tb_en_P=1'b1; tb_rst_P=1'b0;
 #11000 tb_rst=1'b0; tb_en_P=1'b1; tb_rst_P=1'b0;
 #100 tb_rst=1'b0; tb_en_P=1'b0; tb_rst_P=1'b1;
 #300 tb_rst=1'b0; tb_en_P=1'b1; tb_rst_P=1'b0;
 #500 tb_rst=1'b0; tb_en_P=1'b0; tb_rst_P=1'b0;
 
#100 $finish;
end                
                  
                  
endmodule

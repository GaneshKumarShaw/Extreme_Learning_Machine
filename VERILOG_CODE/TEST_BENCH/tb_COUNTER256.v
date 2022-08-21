`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_COUNTER256M1;
wire[7:0] tb_inp_add;
wire tb_done256;
reg tb_clk,
     tb_rst,
     tb_en_256,
     tb_rst_256;
COUNTER256M1 counter256(.inp_add(tb_inp_add),
                  .done256(tb_done256),
                  .clk(tb_clk),
                  .rst(tb_rst),
                  .en_256(tb_en_256),
                  .rst_256(tb_rst_256));
                  
initial tb_clk=1'b0;
always #50 tb_clk=~tb_clk;  

initial 
begin
 $monitor($time,"tb_inp_add=%b",tb_inp_add);
 tb_rst=1'b1; tb_en_256=1'b0; tb_rst_256=1'b0;
 #160 tb_rst=1'b0; tb_en_256=1'b1; tb_rst_256=1'b0;
 #40000 tb_rst=1'b0; tb_en_256=1'b0; tb_rst_256=1'b1;
 #200 tb_rst=1'b0; tb_en_256=1'b1; tb_rst_256=1'b0;
 #500 tb_rst=1'b0; tb_en_256=1'b0; tb_rst_256=1'b0;
 #100 $finish;
end                
                  
                  
endmodule

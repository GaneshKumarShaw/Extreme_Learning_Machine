`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_DATAPATHM1;
parameter acc_width=16;  
parameter P_width=13; 
parameter inp_width=8; 
parameter lfsr_width=8;


 
// datapath wire declaration   
wire[acc_width-1:0] tb_OUT;
wire tb_done256;
wire[P_width-1:0] tb_P_index;
wire tb_stop;
wire[inp_width-1:0] tb_inp_add;
reg tb_clk,
     tb_start,
     tb_rst;
wire tb_inp_data;
     
// memory wire declaratiion 
wire[inp_width-1:0] mem_address;
reg mem_data_in;
wire mem_clk;
reg mem_wen;
wire mem_data_out;     
// datapath instantiatio       
DATAPATHM1 dp(.OUT(tb_OUT),      //  Perceptron value 
                  .done256(tb_done256),
                  .P_index(tb_P_index),  // Perceptron index for LUT
                  .stop(tb_stop),     // complete counting of neurons 
                  .inp_add(tb_inp_add),  // memory address
                  
                  .clk(tb_clk),
                  .start(tb_start),
                  .inp_data(tb_inp_data),  // memory data 
                  .rst(tb_rst));
                  
assign tb_inp_data=mem_data_out;

// memory instantiation 
input_memory mem(.a(mem_address),
                 .d(mem_data_in),
                 .clk(mem_clk),
                 .we(mem_wen),
                 .spo(mem_data_out));   // output
assign mem_address=tb_inp_add;
initial mem_data_in=1'b0;
assign mem_clk=tb_clk;
initial mem_wen=1'b0;

// clock instantiation 
initial tb_clk=1'b0;
always #10 tb_clk=~tb_clk;

initial 
begin
$monitor($time,"tb_OUT=%b",tb_OUT);
 tb_rst=1'b1;tb_start=1'b0;
 #25 tb_rst=1'b0; tb_start=1'b1;
 #20 tb_start=1'b0;
 
 #131072 ;
 
#50 $finish; 
end                 
                  
endmodule

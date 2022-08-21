`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module DATAPATH(Digit,
                OVER,
                add,
                clk,
                rst,
                start,
                input_data);
output[9:0] Digit;
output OVER;
output[7:0] add;
input clk,
      rst,
      start,
      input_data;
// module1 wire declaration 
wire[15:0] m1_out;
wire m1_done256;
wire[12:0] m1_P_index;
wire m1_stop;
wire[7:0] m1_inp_add;
wire m1_clk,
     m1_start,
     m1_inp_data,
     m1_rst;
//module2 wire declaration 
wire[31:0] m2_data;
wire m2_M2done,
     m2_clk;
wire[3:0] m2_raddr;
wire m2_rst,
     m2_OVER,
     m2_done256;
wire[12:0] m2_P_index;
wire[15:0] m2_Perceptron;   
// module3 wire declaration 
wire[3:0] m3_raddr;
wire[9:0] m3_Digit;
wire m3_clk,
     m3_rst,
     m3_M2done;
wire[31:0] m3_regfile_data;
wire m3_start;      
// module1 instantiatiion 
DATAPATHM1 m1(.OUT(m1_OUT),      //  Perceptron value 
                  .done256(m1_done256),   // 256 counter indicator 
                  .P_index(m1_P_index),  // Perceptron index for LUT
                  .stop(m1_stop),     // complete counting of neurons 
                  .inp_add(m1_inp_add),  // memory address
                  
                  .clk(m1_clk),
                  .start(m1_start),
                  .inp_data(m1_inp_data),  // memory data 
                  .rst(m1_rst)); 
assign m1_clk=clk;
assign m1_start=start;
assign m1_inp_data=input_data;
assign m1_rst=rst;


     
// module2 instantaition 
DATAPATHM2 m2(.regf_data(m2_data),   // output
                  .M2done(m2_M2done),
                  .clk(m2_clk),
                  .raddr(m2_raddr),
                  .rst(m2_rst),
                  .start(m2_start),
                  .OVER(m2_OVER),
                  .done256(m2_done256),
                  .P_index(m2_P_index),
                  .Perceptron(m2_Perceptron));                                
assign m2_clk=clk;
assign m2_raddr=m3_raddr;
assign m2_rst=rst;
assign m2_start=start;
assign m2_OVER=m3_OVER;
assign m2_done256=m1_done256;
assign m2_P_index=m1_P_index;
assign m2_Perceptron=m1_OUT;


// module3 instantiation 
DATAPATHM3 m3(.raddr(m3_raddr),
                  .Digit(m3_Digit),
                  .OVER(m3_OVER),
                  .clk(m3_clk),
                  .rst(m3_rst),
                  .M2done(m3_M2done),
                  .regf_data(m3_regfile_data),
                  .start(m3_start));
assign m3_clk=clk;
assign m3_rst=rst;
assign m3_M2done=m2_M2done;
assign m3_regfile_data=m2_data;
assign m3_start=start;

// output instantiation 
assign Digit=m3_Digit;
assign OVER=m3_OVER;
assign add=m1_inp_add;
endmodule

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module DATAPATHM1(OUT,      //  Perceptron value 
                  done256,   // 256 counter indicator 
                  P_index,  // Perceptron index for LUT
                  stop,     // complete counting of neurons 
                  inp_add,  // memory address
                  
                  clk,
                  start,
                  inp_data,  // memory data 
                  rst);
 parameter acc_width=16;  
 parameter P_width=13; 
 parameter inp_width=8; 
 parameter lfsr_width=8;
              
 output[acc_width-1:0] OUT;
 output[P_width-1:0] P_index;
 output reg done256;
 output     stop;
 output[inp_width-1:0] inp_add; 
 
 input clk,
       start,
       inp_data,
       rst;             
 
 // controller wire declaration  
                    wire cr_per_load,
                    cr_en_P,
                    cr_rst_P,
                    cr_en_lfsr,
                    cr_rst_lfsr,
                    cr_acc_rst,
                    cr_acc_load,
                    cr_en_256,
                    cr_rst_256,
                    cr_clk,
                    cr_rst,
                    cr_start,
                    cr_done_256,
                    cr_stop;
                    
 // couter256 wire declaration  
wire[inp_width-1:0] ct256_inp_add;
wire ct256_done256,
     ct256_clk,
     ct256_rst,
     ct256_en_256,
     ct256_rst_256;       

// counterP declaration 
wire[P_width-1:0] ctP_P_index;
wire ctP_stop,
     ctP_clk,
     ctP_rst,
     ctP_en,
     ctP_rst_P,
     ctP_done_256;
     
 // mux1 wire declaratio 
wire[acc_width-1:0] mux1_out,
                    mux1_data0,
                    mux1_data1;
wire mux1_sel;           
 
// mux2 wire declaratio 
wire[lfsr_width-1:0] mux2_out,
                     mux2_data0,
                     mux2_data1;                     
wire mux2_sel;  

// perceptron wire declaration 
wire[acc_width-1:0] per_data_out,
                    per_data_in;
wire per_clk,
     per_rst,
     per_load; 
     
// adder wire declaratioi  
wire[acc_width-1:0] add_out,
                    add_dataL,
                    add_dataR;
                    
     
// accumulator wire declaration 
wire[acc_width-1:0] acc_data_out,
                    acc_data_in;
wire acc_clk,
     global_rst,
     acc_load,
     acc_rst;
                                 
 // controller instantiation 
 CONTROLLERM1 controller(.per_load(cr_per_load),
                    .en_P(cr_en_P),
                    .rst_P(cr_rst_P),
                    .en_lfsr(cr_en_lfsr),
                    .rst_lfsr(cr_rst_lfsr),
                    .acc_rst(cr_acc_rst),
                    .acc_load(cr_acc_load),
                    .en_256(cr_en_256),
                    .rst_256(cr_rst_256),
                    .clk(cr_clk),
                    .rst(cr_rst),
                    .start(cr_start),
                    .done_256(cr_done_256),
                    .stop(cr_stop)); 
assign cr_clk=clk;
assign cr_rst=rst;
assign cr_start= start;
assign cr_done_256=ct256_done256;
assign cr_stop=ctP_stop; 


// counter256 instanttiation 
COUNTER256M1 ct256(.inp_add(ct256_inp_add),
                  .done256(ct256_done256),
                  .clk(ct_clk),
                  .rst(ct_rst),
                  .en_256(ct_en_256),
                  .rst_256(ct_rst_256));
                  
assign ct_clk=clk;
assign ct_rst=rst;
assign ct_en_256=cr_en_256;
assign ct_rst_256=cr_rst_256;
// counterP instantiation  
COUNTERPM1 ctP(.P_index(ctP_P_index),
                  .stop(ctP_stop),
                  .clk(ctP_clk),
                  .rst(ctP_rst),
                  .en_P(ctP_en_P),
                  .rst_P(ctP_rst_P),
                  .done_256(ctP_done_256));   
assign ctP_clk=clk;
assign ctP_rst=rst;
assign ctP_en_P=cr_en_P;
assign ctP_rst_P=cr_rst_P;  
assign ctP_done_256=ct256_done256;  

                 
                    
// mux1 instantiatio 
MUXM1 mux1(.out(mux1_out),
             .data0(mux1_data0),
             .data1(mux1_data1),
             .sel(mux1_sel));
 assign mux1_data0=acc_data_out;
 assign mux1_data1=16'b0;
 assign mux1_sel=acc_data_out[acc_width-1];            
             
            
// mux2 instantiatio 
MUX2M1 mux2(.out(mux2_out),
             .data0(mux2_data0),
             .data1(mux2_data1),
             .sel(mux2_sel));  
assign mux2_data0=16'b0;
assign mux2_data1=lfsr_out;
assign mux2_sel=inp_data;
 

// perceptron instantiation 
PIPOPM1 per(.data_out(per_data_out),
             .clk(per_clk),
             .data_in(per_data_in),
             .rst(per_rst),
             .load(per_load));            
assign per_clk=clk;
assign per_data_in=mux1_out;
assign per_rst=rst;
assign per_load=cr_per_load; 


// accumulator instantiatio 
PIPOAM1 acc(.data_out(acc_data_out),
             .clk(acc_clk),
             .data_in(acc_data_in),
             .rst(global_rst),
             .load(acc_load),
             .RST(acc_rst));  
assign acc_clk=clk;
assign acc_data_in=add_out;
assign global_rst=rst; 
assign acc_load=cr_acc_load;
assign acc_rst=cr_acc_rst;


// adder instantiation  
ADDERM1 add(.out(add_out),
               .dataL(add_dataL),
               .dataR(add_dataR));
assign add_dataL={{8{mux2_out[lfsr_width-1]}},mux2_out};
assign add_dataR=acc_data_out;

// lfsr wire declaration 
wire[lfsr_width-1:0] lfsr_out;
wire lfsr_clk,
     lfsr_global_rst,
     lfsr_en_lfsr,
     lfsr_rst_lfsr;
// lfsr instantiation  
LFSRM1 lfsr(.out(lfsr_out),
              .clk(lfsr_clk),
              .rst(lfsr_global_rst),
              .en_lfsr(lfsr_en_lfsr),
              .rst_lfsr(lfsr_rst_lfsr));
assign lfsr_clk=clk;
assign lfsr_global_rst=rst;
assign lfsr_en_lfsr=cr_en_lfsr;
assign lfsr_rst_lfsr=cr_rst_lfsr;
               
// output instantiation              
assign OUT=per_data_out;
//assign done256=ct256_done256;
assign P_index=ctP_P_index;
assign stop=ctP_stop;
assign inp_add=ct256_inp_add;             

always @(posedge clk)
if(rst)
 done256<= #3 1'b0;
else
 done256<= #3 ct256_done256;            
                                                                      
endmodule

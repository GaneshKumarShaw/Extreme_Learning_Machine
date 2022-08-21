`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module DATAPATHM3(raddr,
                  Digit,
                  OVER,
                  clk,
                  rst,
                  M2done,
                  regf_data,
                  start);
output[3:0] raddr;                  
output[9:0] Digit;
output OVER;
input clk,
      rst,
      M2done,
      start;
input[31:0] regf_data;      

// controller wire declaration 
wire cr_en_digit,
     cr_rst_digit,
     cr_en_counter,
     cr_rst_counter,
     cr_en_acc,
     cr_rst_acc,
     cr_clk,
     cr_rst,
     cr_count9,
     cr_leq,
     cr_gt,
     cr_start,
     cr_M2done;
// counter wire declaration 
wire[3:0] ct_count;
wire ct_count9,
     ct_clk,
     ct_rst,
     ct_en_counter,
     ct_rst_counter; 
// DIGIT wire declaration 
wire[3:0] dg_digit,
          dg_count_data;
wire dg_clk,
     dg_rst,
     dg_en_digit,
     dg_rst_digit;         
// accumulator wire declaration  
wire[31:0] acc_data_out,
           acc_data_in;
wire acc_clk,
     acc_rst,
     acc_en_acc,
     acc_rst_acc;   
// comparator wire declaration 
wire[31:0] comp_out,
           comp_dataL,
           comp_dataR;
wire comp_leq,
     comp_gt;           
// controller instantiation 
CONTROLLERM3 crM3(.en_digit(cr_en_digit),
                    .rst_digit(cr_rst_digit),
                    .en_counter(cr_en_counter),
                    .rst_counter(cr_rst_counter),
                    .en_acc(cr_en_acc),
                    .rst_acc(cr_rst_acc),
                    .clk(cr_clk),
                    .rst(cr_rst),
                    .count9(cr_count9),
                    .leq(cr_leq),
                    .gt(cr_gt),
                    .start(cr_start),
                    .M2done(cr_M2done)); 
assign cr_clk=clk;
assign cr_rst=rst;
assign cr_count9=ct_count9;
assign cr_leq=comp_leq;
assign cr_gt=comp_gt;
assign cr_start=start;
assign cr_M2done=M2done;


// counter instantiation 
COUNTER9M3 ctM3(.count(ct_count),
                  .count9(ct_count9),
                  .clk(ct_clk),
                  .rst(ct_rst),
                  .en_counter(ct_en_counter),
                  .rst_counter(ct_rst_counter));
assign ct_clk=clk;
assign ct_rst=rst;
assign ct_en_counter=cr_en_counter;
assign ct_rst_counter=cr_rst_counter;


// DIGIT instantiation 
DIGITM3 dg(.digit(dg_digit),
               .clk(dg_clk),
               .rst(dg_rst),
               .en_digit(dg_en_digit),
               .rst_digit(dg_rst_digit),
               .count_data(dg_count_data)); 
assign dg_clk=clk;
assign dg_rst=rst;
assign dg_en_digit=cr_en_digit;
assign dg_rst_digit=cr_rst_digit; 


// accumulator instantiation 
PIPOAM3 accM3(.data_out(acc_data_out),
             .clk(acc_clk),
             .data_in(acc_data_in),
             .rst(acc_rst),
             .load(acc_en_acc),
             .RST(acc_rst_acc)); 
assign acc_clk=clk;
assign acc_data_in=comp_out;
assign acc_rst=rst;
assign acc_en_acc=cr_en_acc;
assign acc_rst_acc=cr_rst_acc;                                           
       
// comparator instantiation  
COMPARATORM3 comp(.out(comp_out),
                    .leq(comp_leq),
                    .gt(comp_gt),
                    .dataL(comp_dataL),
                    .dataR(comp_dataR)); 
assign comp_dataL=regf_data;
assign comp_dataR=acc_data_out; 

// output declaration 
assign raddr=ct_count;
assign Digit=dg_digit;
assign OVER=ct_count9;                                                             
endmodule

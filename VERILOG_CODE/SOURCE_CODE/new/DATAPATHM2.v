`timescale 1ns / 1ps
  
//////////////////////////////////////////////////////////////////////////////////


module DATAPATHM2(regf_data,   // output
                  M2done,
                  clk,
                  raddr,
                  rst,
                  start,
                  OVER,
                  done256,
                  P_index,
                  Perceptron);
parameter P_width=13;
output[31:0] regf_data; 
output reg M2done;
input clk,
      rst,
      start,
      OVER,
      done256;
input[3:0] raddr;
input[P_width-1:0] P_index;
input[15:0] Perceptron; 

// controller wire dclaration 
wire cr2_en_bias,
     cr2_rst_bias,
     cr2_M3read,
     cr2_initialise,
     cr2_en_acc,
     cr2_rst_acc,
     cr2_en_reg,
     cr2_rst_reg,
     cr2_clk,
     cr2_rst,
     cr2_start,
     cr2_done256,
     cr2_done,
     cr2_count10,
     cr2_OVER;
// count10 wire declaration  
wire[3:0] ct2_count;
wire ct2_count10,
     ct2_clk,
     ct2_rst,
     ct2_en_ct,
     ct2_rst_ct;    
// mux wire declaration 
wire[3:0] mux_out,
          mux_data0,
          mux_data1;
wire mux_sel;  
// W21LUT wire declaration 
wire[P_width-1:0] w21_addr;
wire[15:0] w21_data;  
// adder wire declaration 
wire[P_width-1:0] add_out,
                  add_dataU,
                  add_dataD;
// multiplicatio wire declaration 
wire[31:0] mul_product;
wire[15:0] mul_multiplicand,
           mul_multiplier;
wire mul_clk,
     mul_done,
     mul_start,
     mul_rst; 
// accumulator wire declaration 
wire[31:0] acc2_data_out,
           acc2_data_in;
wire acc2_clk,
     acc2_rst,
     acc2_load,
     acc2_RST;
// sign adder wire declaration 
wire[31:0] sadd_out,
            sadd_dataL,
            sadd_dataR;  
// regfiles wire declaration 
wire[31:0] rg_dataR,
           rg_dataW;
wire rg_clk,
     rg_rst,
     rg_en_reg,  
     rg_rst_reg;   
wire[3:0] rg_addr;                                                          
// controller instantiation 
CONTROLLERM2 cr2M2(.en_bias(cr2_en_bias),
                    .rst_bias(cr2_rst_bias),
                    .M3read(cr2_M3read),
                    .initialise(cr2_initialise),
                    .en_acc(cr2_en_acc),
                    .rst_acc(cr2_rst_acc),
                    .en_reg(cr2_en_reg),
                    .rst_reg(cr2_rst_reg),
                    .clk(cr2_clk),
                    .rst(cr2_rst),
                    .start(cr2_start),
                    .done256(cr2_done256),
                    .done(cr2_done),
                    .count10(cr2_count10),
                    .OVER(cr2_OVER));
assign cr2_clk=clk;
assign cr2_rst=rst;
assign cr2_start=start;
assign cr2_done256=done256;
assign cr2_done=mul_done;             // multiplier done signal 
assign cr2_count10=ct2_count10; 
assign cr2_OVER=OVER;



// count10 instantiation 
COUNTER10M2  ct2M2(.count(ct2_count),
                   .count10(ct2_count10),
                   .clk(ct2_clk),
                   .rst(ct2_rst),
                   .en_ct(ct2_en_ct),
                   .rst_ct(ct2_rst_ct));
assign ct2_clk=clk;
assign ct2_rst=rst;
assign ct2_en_ct=cr2_en_bias;
assign ct2_rst_ct=cr2_rst_bias; 

        
// mux instantiation 
MUXM2 mux(.out(mux_out),
             .data0(mux_data0),
             .data1(mux_data1),
             .sel(mux_sel)); 
assign mux_data0=ct2_count;
assign mux_data1=raddr;
assign mux_sel=cr2_M3read;


// W21LUT instantiation 
W21LUT w21(.out(w21_data),
              .addr(w21_addr));        
assign w21_addr=add_out;


// adder instantiation 
ADDERM2 add(.out(add_out),
               .dataU(add_dataU),
               .dataD(add_dataD));
assign add_dataU={9'b0,ct2_count};
assign add_dataD=P_index; 

        
// multiplication instantiation 
MULPLICATION mul(.Product(mul_product),
                .done(mul_done),
                .clk(mul_clk),
                .multiplicand(mul_multiplicand),
                .multiplier(mul_multiplier),
                .start(mul_start),
                .rst(mul_rst));  
assign mul_clk=clk;
assign mul_multiplicand=w21_data;
assign mul_multiplier=Perceptron; 
assign mul_start=start;
assign mul_rst=rst;  


// accumulator instantiation 
PIPOAM2 acc2M2(.data_out(acc2_data_out),
             .clk(acc2_clk),
             .data_in(acc2_data_in),
             .rst(acc2_rst),
             .load(acc2_en_acc),
             .RST(acc2_rst_acc));  
assign acc2_clk=clk;
assign acc2_data_in=rg_dataR;
assign acc2_rst=rst;
assign acc2_en_acc=cr2_en_acc;
assign acc2_rst_acc=cr2_rst_acc;


// sign adder instantiation 
SADDERM2 sadd(.out(sadd_out),
                .dataL(sdd_dataL),
                .dataR(sadd_dataR)); 
       
// regfiles instantiation 
REGFILESM2 rg(.dataR(rg_dataR), 
                  .clk(rg_clk),
                  .dataW(rg_dataW),
                  .rst(rg_rst),
                  .en(rg_en_reg),
                  .rst_reg(rg_rst_reg),
                  .addr(rg_addr));  
assign rg_clk=clk;
assign rg_dataW=sadd_out;
assign rg_rst=rst;
assign rg_en_reg=cr2_en_reg;
assign rg_rst_reg=cr2_rst_reg;
assign rg_addr=mux_out;

// output declaration 
assign regf_data=rg_dataR; 
always @(posedge clk)
 if(rst)
  M2done<=0;
 else
  M2done<=cr2_M3read;                                                                                                                                        
endmodule

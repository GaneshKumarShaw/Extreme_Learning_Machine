`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module MULPLICATION(Product,
                done,
                clk,
                multiplicand,
                multiplier,
                start,
                rst);
parameter n=16,    //n:multiplicand width
          m=16 ;  // m:multiplier width  
output[m+n-1:0] Product;
output reg done;
input[n:0] multiplicand;
input[m:0] multiplier;
input clk,
      start,
      rst;
// controller wire instantiation  
wire cr_rstAC,
     cr_loadAC,
     cr_load,
     cr_shift,
     cr_count16set,
     cr_count16reset,
     cr_clk,
     cr_start,
     cr_count16done,
     cr_rst;
     
// wire instantiation for counter 
wire ct_count16done,
     ct_clk,
     ct_count16set,
     ct_count16reset,
     ct_rst; 
     
// 2's complement wire instantiation 
wire[n-1:0] c2s_data_out,
            c2s_data_in; 
// multiplicand register wire instantiaiton 
wire[n-1:0] md_data_out;
wire[n-1:0] md_data_in;
wire md_clk,
     md_load,
     md_rst;  
// 2's multiplicand wire instantition 
wire[n-1:0] md2s_data_out;
wire[n-1:0] md2s_data_in;
wire md2s_clk,
     md2s_load,
     md2s_rst; 
// mux1 wire instantiation 
wire[n-1:0] mx1_data_out,
            mx1_data0,
            mx1_data1;
wire mx1_sel;                           
     
// adder wire instantiation  
wire[n:0] add_sum;
wire[n-1:0] add_dataL,
            add_dataR;
// mux2 wire instantiation 
wire[n:0] mx2_data_out,
          mx2_data0,
          mx2_data1;
wire mx2_sel;  

// accumulator wire instantiation  
wire[n-1:0] ac_data_out,
            ac_data_in;
wire ac_clk,
     ac_loadAC,
     ac_rstAC,
     ac_rst;  
// multiplier wire instantiation  
wire[m-1:0] mr_data_in;
wire[m-1:0] mr_data_out;
wire mr_clk,
     mr_load,
     mr_shift_data,
     mr_shift,
     mr_rst; 


reg Q; 
wire x;                    
                 
// controller instantiaiton  
CONTROLLER cr(.load(cr_load),
                  .loadAC(cr_loadAC),
                  .rstAC(cr_rstAC),
                  .shift(cr_shift),
                  .count16set(cr_count16set),
                  .count16reset(cr_count16reset),
                  
                  .clk(cr_clk),
                  .start(cr_start),
                  .rst(cr_rst),
                  .count16done(cr_count16done));     
 
assign cr_clk=clk;
assign cr_start=start;
assign cr_count16done=ct_count16done;
assign cr_rst=rst;


// counter instantition 
COUNTER16 ct(.count16done(ct_count16done), // one bit output
                 .clk(ct_clk),
                 .count16set(ct_count16set),  // one bit input
                 .count16reset(ct_count16reset),
                 .rst(ct_rst));
assign ct_clk=clk;
assign ct_count16set=cr_count16set;
assign ct_count16reset=cr_count16reset;
assign ct_rst=rst; 


// 2's complement instantiation 
COMP2S comp2s(.data_out(c2s_data_out),
              .data_in(c2s_data_in));   
assign c2s_data_in=multiplicand;


// multiplicand instantiaiton 
PIPO md(.data_out(md_data_out),
            .clk(md_clk),
            .data_in(md_data_in),
            .load(md_load),
            .rst(md_rst));
assign md_clk=clk;
assign md_data_in=multiplicand;
assign md_load=cr_load;
assign md_rst=rst;           
            

// 2's multiplicand instantiation 
PIPO md2s(.data_out(md2s_data_out),
            .clk(md2s_clk),
            .data_in(md2s_data_in),
            .load(md2s_load),
            .rst(md2s_rst));
assign md2s_clk=clk;
assign md2s_data_in=c2s_data_out;
assign md2s_load=cr_load;
assign md2s_rst=rst;


// mux1 instantiation 
MUX16BITS mx1(.data_out(mx1_data_out),
                 .data0(mx1_data0),
                 .data1(mx1_data1),
                 .sel(mx1_sel)); 
assign mx1_data0=md2s_data_out;
assign mx1_data1=md_data_out;
assign mx1_sel=Q;


// adder instantiation  
ADDER add(.sum(add_sum),
             .dataL(add_dataL),
             .dataR(add_dataR));  
assign add_dataL=ac_data_out;
assign add_dataR=mx1_data_out;  

        
// mux2 instantition i,e 17 Bits 
MUX17BITS mx2(.data_out(mx2_data_out),
                 .data0(mx2_data0),
                 .data1(mx2_data1),
                 .sel(mx2_sel));
assign mx2_data0={ac_data_out[n-1],ac_data_out};
assign mx2_data1=add_sum;
assign mx2_sel=x; 

          
// accumulator instantiation  
SPIPO ac(.data_out(ac_data_out),
             .clk(ac_clk),
             .data_in(ac_data_in),
             .load(ac_loadAC),
             .rst(ac_rst),
             .Srst(ac_rstAC));
assign ac_clk=clk;
assign ac_data_in=mx2_data_out[n:1];
assign ac_loadAC=cr_loadAC;
assign ac_rst=rst;
assign ac_rstAC=cr_rstAC;  


// multiplier instantiation  
PISO mr(.data_out(mr_data_out),
             .clk(mr_clk),
             .data_in(mr_data_in),
              .load(mr_load),
             .shift_data(mr_shift_data),
             .shift(mr_shift),
             .rst(mr_rst));         
assign mr_clk=clk;
assign mr_data_in=multiplier;
assign mr_load=cr_load;
assign mr_shift_data=mx2_data_out[0];
assign mr_shift=cr_shift;
assign mr_rst=rst;

 
 // Q instantiation   
always @(posedge clk)
begin
 if(rst)
  Q<=1'b0;
 else if(cr_load)
  Q<=1'b0;
 else
  Q<=mr_data_out[0];
end
                
// xor gate instantiation  
xor(x,mr_data_out[0],Q);

// output declaration  

assign Product={ac_data_out,mr_data_out};   

always @(posedge clk)
if(rst)
 done<= #3 1'b0;
else 
 done<= #3 cr_count16done;                
                                                                                                                                                                       
endmodule





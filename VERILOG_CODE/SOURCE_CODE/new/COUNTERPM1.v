`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module COUNTERPM1(P_index,
                  stop,
                  clk,
                  rst,
                  en_P,
                  rst_P,
                  done_256);
output[12:0] P_index;           // number of perceptron is 512
output stop;
input clk,
      rst,
      en_P,
      rst_P,
      done_256;
reg[12:0] count;
wire[12:0] wire_in,
           wire_out;
reg temp; 
reg  Q;          

assign wire_out=wire_in+10;
assign wire_in=count;

always @(posedge clk)
 begin
  if(rst)
   count<= #3 13'b1111_1111_1011_0;  //max 13 bits value is 8191 
  else if(rst_P)
   count<= #3 13'b1111_1111_1011_0; // decimal value 8182
  else if(en_P)
   count<= #3 wire_out[12:0]; 
 end   

always @(*)
if(count==13'd5100)
 temp=1;
else
 temp=0;
 
always @(posedge clk)
begin
 if(rst)
  Q<=1'b0;
 else if(rst_P)
  Q<=1'b0;
 else if(done_256)
  Q<=temp;
end   

// output declaration 
assign P_index=count;
assign stop=Q;             

endmodule







































//module COUNTERPM1(P_index,
//                  stop,
//                  clk,
//                  rst,
//                  en_P,
//                  rst_P,
//                  done_256);
//output[8:0] P_index;           // number of perceptron is 512
//output stop;
//input clk,
//      rst,
//      en_P,
//      rst_P,
//      done_256;

//reg[8:0] count;
//wire[8:0] wire_in;
//wire[9:0] wire_out;
//wire t;
//reg q;

//always @(posedge clk)
// begin
//  if(rst)
//   count<= #3 9'b1111_1111_1;
//  else if(rst_P)
//   count<= #3 9'b1111_1111_1; 
//  else if(en_P)
//   count<= #3 wire_out[8:0]; 
// end   
 
//assign wire_out= wire_in+1;
//assign wire_in=count;

//always @(posedge clk)
//begin
// if(rst)
//  q<= #3 1'b0;
// else if(rst_P)
//  q<= #3 1'b0;
// else if(done_256)
//  q<= #3 1'b1;
//end

//// output declaration 
//and(t,q,wire_out[9]);
//assign P_index=count;
//assign stop=t;
                
//endmodule

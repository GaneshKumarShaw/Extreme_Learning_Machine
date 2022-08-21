`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module CONTROLLER(load,
                  loadAC,
                  rstAC,
                  shift,
                  count16set,
                  count16reset,
                  
                  clk,
                  start,
                  rst,
                  count16done);
output reg load,
           loadAC,
           rstAC,
           shift,
           count16set,
           count16reset;
input clk,
      rst,
      start,
      count16done;
parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;  
reg[1:0] ps,ns;
always @(posedge clk)
begin
 if(rst)
  ps<= #3 S0;
 else
  ps<=#3 ns;
end    

always @(*)
begin
case(ps)
S0: begin
     rstAC=1'b1;
     loadAC=1'b0;
     load=1'b0;
     shift=1'b0;
     count16set=1'b0;
     count16reset=1'b1;  
     if(start)
      ns=S1;
     else
      ns=S0;
    end
S1: begin
     rstAC=1'b1;
     loadAC=1'b0;
     load=1'b1;
     shift=1'b0;
     count16set=1'b0;
     count16reset=1'b1; 
     
     ns=S2;
    end 
S2: begin
     rstAC=1'b0;
     loadAC=1'b1;
     load=1'b0;
     shift=1'b1;
     count16set=1'b1;
     count16reset=1'b0; 
     if(count16done)
      ns=S3;
     else
      ns=S2; 
    end   
S3: begin
     rstAC=1'b0;
     loadAC=1'b0;
     load=1'b0;
     shift=1'b0;
     count16set=1'b0;
     count16reset=1'b1;
     if(start)
      ns=S1;
     else
      ns=S3;
    end 
default: begin
          rstAC=1'b1;
          loadAC=1'b0;
          load=1'b0;
          shift=1'b0;
          count16set=1'b0;
          count16reset=1'b1;
          
          ns=S0;
         end 
endcase                       
end                             
                                      
endmodule

//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////


//module CONTROLLER(rstAC,
//                  loadAC,
//                  load,
//                   shift,
//                   count16set,
//                   count16reset,
//                   clk,
//                   start,
//                   count16done,
//                   rst);   
// output reg rstAC,
//        loadAC,
//        load,
//        shift,
//        count16set,
//        count16reset;
// input  clk,
//        start,
//        count16done,
//        rst;
//parameter n=16, // multiplicand width size 
//          m=16; // mulitplier width size  
//parameter[1:0] S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11; 
//reg[1:0] ps,ns;
//always @(posedge clk)
//begin
// if(rst) 
//  ps<=2'b00;
// else
//  ps<=ns;
//end      

//always @(*)
// case(ns)
//S0: begin
//     if(start)
//      begin
//       rstAC=1'b1;
//       loadAC=1'b0;
//       load=1'b1;
//       shift=1'b0;
//       count16set=1'b0;
//       count16reset=1'b1;
//      end
//     else
//      begin
//       rstAC=1'b1;
//       loadAC=1'b0;
//       load=1'b0;
//       shift=1'b0;
//       count16set=1'b0;
//       count16reset=1'b1;
//      end 
//    end
//S1: begin
//       rstAC=1'b0;
//       loadAC=1'b1;
//       load=1'b0;
//       shift=1'b1;
//       count16set=1'b1;
//       count16reset=1'b0;
//    end 
//S2: begin
//     if(count16done)
//      begin
//       rstAC=1'b0;
//       loadAC=1'b0;
//       load=1'b0;
//       shift=1'b0;
//       count16set=1'b0;
//       count16reset=1'b0;
//      end
//     else
//      begin
//       rstAC=1'b0;
//       loadAC=1'b1;
//       load=1'b0;
//       shift=1'b1;
//       count16set=1'b1;
//       count16reset=1'b0;
//      end 
//    end 
//S3: begin
//     if(start)
//      begin
//       rstAC=1'b1;
//       loadAC=1'b0;
//       load=1'b1;
//       shift=1'b0;
//       count16set=1'b0;
//       count16reset=1'b1;
//      end
//     else
//      begin
//       rstAC=1'b0;
//       loadAC=1'b0;
//       load=1'b0;
//       shift=1'b0;
//       count16set=1'b0;
//       count16reset=1'b0;
//      end 
//    end    
//default: begin
//       rstAC=1'b1;
//       loadAC=1'b0;
//       load=1'b0;
//       shift=1'b0;
//       count16set=1'b0;
//       count16reset=1'b1;
//         end           
// endcase                              
                     
// always @(*)
//if(rst)
//  ns=S0;
//else
// case(ps)
//S0: begin
//     if(start)
//      ns=S1;
//     else
//      ns=S0;
//    end
//S1: begin
//     ns=S2;
//    end  
//S2: begin
//     if(count16done)
//      ns=S3;
//     else
//      ns=S2;
//    end   
//S3: begin
//     if(start)
//      ns=S1;
//     else
//      ns=S3;
//    end 
//default: begin
//          ns=S0;
//         end          
// endcase
                                   
//endmodule

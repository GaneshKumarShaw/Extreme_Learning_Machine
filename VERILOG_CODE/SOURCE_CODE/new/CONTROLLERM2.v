`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module CONTROLLERM2(en_bias,
                    rst_bias,
                    M3read,
                    initialise,
                    en_acc,
                    rst_acc,
                    en_reg,
                    rst_reg,
                    clk,
                    rst,
                    start,
                    done256,
                    done,
                    count10,
                    OVER);
                    
         output reg en_bias,
                    rst_bias,
                    M3read,
                    initialise,
                    en_acc,
                    rst_acc,
                    en_reg,
                    rst_reg;
         input      clk,
                    rst,
                    start,
                    done256,
                    done,
                    count10,
                    OVER;
reg[1:0] ps,
         ns;
parameter[1:0] IDEL=2'b00, MA=2'b01, LOAD=2'b10, ExpData=2'b11;

always @(posedge clk)
begin 
case(ps)
IDEL:begin
  if(done256)
   begin
    en_bias=1'b0;
    rst_bias=1'b0;
    M3read=1'b0;
    initialise=1'b1;
    en_acc=1'b0;
    rst_acc=1'b1;
    en_reg=1'b0;
    rst_reg=1'b1;
    ns=MA;
   end
  else
   begin
    en_bias=1'b0;
    rst_bias=1'b1;
    M3read=1'b0;
    initialise=1'b0;
    en_acc=1'b0;
    rst_acc=1'b1;
    en_reg=1'b0;
    rst_reg=1'b1;
    ns=IDEL;
   end  
   end 
MA:begin
    if(done)
     begin
    en_bias=1'b1;
    rst_bias=1'b0;
    M3read=1'b0;
    initialise=1'b0;
    en_acc=1'b0;
    rst_acc=1'b0;
    en_reg=1'b1;
    rst_reg=1'b0;
    ns=LOAD;
     end
    else
     begin
    en_bias=1'b0;
    rst_bias=1'b0;
    M3read=1'b0;
    initialise=1'b0;
    en_acc=1'b1;
    rst_acc=1'b0;
    en_reg=1'b0;
    rst_reg=1'b0;
    ns=MA;
     end
   end  
LOAD:begin
    en_bias=1'b0;
    rst_bias=1'b0;
    M3read=1'b0;
    en_acc=1'b0;
    rst_acc=1'b0;
    en_reg=1'b0;
    rst_reg=1'b0;
    if(count10)
     begin
       initialise=1'b0;
       ns=ExpData;
     end
    else
     begin
       initialise=1'b1;
       ns=MA;
     end
     end 
ExpData:begin
    en_bias=1'b0;
    rst_bias=1'b1;
    M3read=(OVER==0);
    initialise=1'b0;
    en_acc=1'b0;
    rst_acc=1'b1;
    en_reg=1'b0;
    rst_reg=1'b0;
    ns=MA;
    if(start)
     ns=IDEL;
    else
     ns=ExpData;
        end 
default:begin
    en_bias=1'b0;
    rst_bias=1'b1;
    M3read=1'b0;
    initialise=1'b0;
    en_acc=1'b0;
    rst_acc=1'b1;
    en_reg=1'b0;
    rst_reg=1'b1;
    ns=IDEL;
        end             
endcase
end                                       
                    
endmodule
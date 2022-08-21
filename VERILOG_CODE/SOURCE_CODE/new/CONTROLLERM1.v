`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module CONTROLLERM1(per_load,
                    en_P,
                    rst_P,
                    en_lfsr,
                    rst_lfsr,
                    acc_rst,
                    acc_load,
                    en_256,
                    rst_256,
                    clk,
                    rst,
                    start,
                    done_256,
                    stop);
output reg per_load,
       en_P,
       rst_P,
       en_lfsr,
       rst_lfsr,
       acc_rst,
       acc_load,
       en_256,
       rst_256;   
input clk,
      rst,
      start,
      done_256,
      stop;
parameter[2:0] IDEL=3'b000, SETTING=3'b001, PROCESS=3'B010, LOADING=3'b011, DONE=3'b100;
reg[2:0] ps,ns;     
always @(posedge clk)
begin
 if(rst)
  ps<=3'b000;
 else
  ps<= #3 ns;
end  

always @(*)
begin
 case(ps)
IDEL:begin
      per_load=1'b0;
      en_P=1'b0;
      rst_P=1'b1;
      rst_lfsr=1'b1;
      en_lfsr=1'b0;
      acc_load=1'b0;
      acc_rst=1'b1;
      en_256=1'b0;
      rst_256=1'b1;
      if(start)
       ns=SETTING;
      else
       ns=IDEL;
     end
SETTING:begin
      per_load=1'b0;
      en_P=1'b0;
      rst_P=1'b1;
      rst_lfsr=1'b0;
      en_lfsr=1'b1;
      acc_load=1'b1;
      acc_rst=1'b0;
      en_256=1'b0;
      rst_256=1'b1;
      ns=PROCESS;
        end
PROCESS:begin
    if(done_256)
     begin
      per_load=1'b1;
      en_P=1'b1;
      rst_P=1'b0;
      rst_lfsr=1'b0;
      en_lfsr=1'b0;
      acc_load=1'b0;
      acc_rst=1'b1;
      en_256=1'b0;
      rst_256=1'b1;
      ns=LOADING;
     end
    else
     begin
      per_load=1'b0;
      en_P=1'b0;
      rst_P=1'b0;
      rst_lfsr=1'b0;
      en_lfsr=1'b1;
      acc_load=1'b1;
      acc_rst=1'b0;
      en_256=1'b1;
      rst_256=1'b0; 
      ns=PROCESS;
     end 
        end
LOADING:begin
      per_load=1'b0;
      en_P=1'b0;
      rst_P=1'b0;
      rst_lfsr=1'b0;
      en_lfsr=1'b1;
      acc_load=1'b1;
      acc_rst=1'b0;
      en_256=1'b0;
      rst_256=1'b1;
      if(stop)
       ns=DONE;
      else
       ns=PROCESS;
       end
DONE:begin
      per_load=1'b0;
      en_P=1'b0;
      rst_P=1'b0;
      rst_lfsr=1'b1;
      en_lfsr=1'b0;
      acc_load=1'b0;
      acc_rst=1'b1;
      en_256=1'b0;
      rst_256=1'b1;
      if(start)
       ns=SETTING;
      else
       ns=DONE;
     end 
default: begin
      per_load=1'b0;
      en_P=1'b0;
      rst_P=1'b1;
      rst_lfsr=1'b1;
      en_lfsr=1'b0;
      acc_load=1'b0;
      acc_rst=1'b1;
      en_256=1'b0;
      rst_256=1'b1;
      ns=IDEL;
         end     
 endcase
end                                   
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module REGFILESM2(dataR, 
                  clk,
                  dataW,
                  rst,
                  en,
                  rst_reg,
                  addr);
output[31:0] dataR;
input[31:0] dataW;
input       clk,
            rst,
            en,
            rst_reg;
input[3:0] addr;            
reg[31:0] regfiles[0:9];
always @(posedge clk)
begin
 if(rst || rst_reg)
  begin
   regfiles[0]<= #3 0;
   regfiles[1]<= #3 0;
   regfiles[2]<= #3 0;
   regfiles[3]<= #3 0;
   regfiles[4]<= #3 0;
   regfiles[5]<= #3 0;
   regfiles[6]<= #3 0;
   regfiles[7]<= #3 0;
   regfiles[8]<= #3 0;
   regfiles[9]<= #3 0;
  end
 else
  regfiles[addr]<= #3 dataW;
end 

assign dataR=regfiles[addr];
                  

endmodule

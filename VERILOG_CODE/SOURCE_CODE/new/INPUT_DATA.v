`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module INPUT_DATA(data_out,
                  clk,
                  mem_addr);
parameter inp_width=8;                  
output data_out;
input clk;
input[7:0] mem_addr;
                  
    
    
// memory wire declaratiion 
wire[inp_width-1:0] mem_address;
wire mem_data_in;
wire mem_clk;
wire mem_wen;
wire mem_data_out;    

// memory instantiation 
input_memory mem(.a(mem_address),
                 .d(mem_data_in),
                 .clk(mem_clk),
                 .we(mem_wen),
                 .spo(mem_data_out));   // output
assign mem_address=mem_addr;
assign mem_data_in=1'b0;
assign mem_clk=clk;
assign mem_wen=1'b0;  

// output declaration 
assign data_out=mem_data_out;

endmodule

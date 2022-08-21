`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module tb_DATAPATH;


wire[9:0] tb_Digit;
wire tb_OVER;
reg tb_clk,
    tb_rst,
    tb_start;
    
    
// memory wire declaration 
wire mem_data_out;
wire mem_clk;
wire[7:0] mem_addr;

// top module datapath wire declaration 
wire[9:0] tp_Digit;
wire tp_OVER;
wire[7:0] tp_add;
wire tp_clk,
     tp_rst,
     tp_start,
     tp_input_data;
// memory instantiation  
INPUT_DATA memory(.data_out(mem_data_out),
                  .clk(mem_clk),
                  .mem_addr(mem_addr)); 
assign mem_clk=tb_clk;
assign mem_addr=tp_add;

// top module datapath instantiatio 
DATAPATH  top_module(.Digit(tp_Digit),
                .OVER(tp_OVER),
                .add(tp_add),
                .clk(tp_clk),
                .rst(tp_rst),
                .start(tp_start),
                .input_data(tp_input_data)); 
assign tp_clk=tb_clk; 
assign tp_rst=tb_rst;
assign tp_start=tb_start;
assign tp_input_data=mem_data_out;

initial tb_clk=1'b0;
always #50 tb_clk=~tb_clk;
// output declaration 
assign tb_Digit=tp_Digit;
assign tb_OVER=tp_OVER;



initial 
begin
$monitor($time,"tb_Digti=%b",tb_Digit);
tb_rst=1'b1; tb_start=1'b0;
#500 tb_rst=1'b0; tb_start=1'b1;
#500 tb_rst=1'b0; tb_start=1'b0;


end                                  
endmodule

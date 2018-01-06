`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/16 15:41:58
// Design Name: 
// Module Name: tb_blink
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_blink();
reg clk,reset;
reg en;
wire blink;

blink #(.DVSR(5)) 
tb_blink
(
.clk(clk),
.reset(reset),
.en(en),
.blink(blink)
);

parameter T = 4;

always begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
end

initial begin
    reset = 1'b1;
    en = 1'b0;
    #(1.3*T);
    reset = 1'b0;
    #(T);
    en = 1'b1;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/16 15:11:08
// Design Name: 
// Module Name: blink
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


module blink#(parameter DVSR = 10000_0000 - 1)
    (
    input clk,reset,
    input en,
    output blink
    );
    
    reg [29:0] ms_reg;
    wire [29:0] ms_next;
    reg blink_reg;
    reg blink_next;
    
    //寄存器部分
    always@(posedge clk) begin
        ms_reg <= ms_next;
        blink_reg <= blink_next;
    end
    
    //分频
    assign ms_next = (reset||(ms_reg == DVSR && en)) ? 0 :
                                                (en) ? ms_reg + 1 :
                                                       ms_reg;
    
    //下一个状态
    always@(*) begin
        if(reset||~en) begin
            blink_next = 1'b0;
        end else if(en && (ms_reg == DVSR)) begin
            blink_next = ~blink_reg;
        end
    end
    
    assign blink = blink_reg;
endmodule

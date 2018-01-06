`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 08:31:05
// Design Name: 
// Module Name: counter_s
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


module counter_s
    (
    input clk,go,clr,
    output s_tick 
    );
    
    parameter DVSR = 10000_0000 - 1;
    reg [23:0] s_reg;
    wire [23:0] s_next;
    
    //寄存器部分
    always@(posedge clk,posedge clr) begin
        s_reg <= s_next;
    end
    
    //下一个状态
    assign s_next = (clr||(s_reg == DVSR && go)) ? 0 :
                                            (go) ? s_reg + 1 :
                                                   s_reg;
                                                     
    //输出逻辑
    assign s_tick = (s_reg == DVSR) ? 1'b1 : 1'b0;
endmodule

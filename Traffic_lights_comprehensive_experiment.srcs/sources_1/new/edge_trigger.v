`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/13 20:04:35
// Design Name: 
// Module Name: edge_trigger
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


module edge_trigger
    (
    input wire clk,reset,
    input wire level,
    output wire tick
    );
    
    reg delay_reg;
    
    always@(posedge clk,posedge reset) begin
        if(reset) begin
            delay_reg <= 1'b0;
        end else begin
            delay_reg <= level;
        end
    end
    
    assign tick = ~delay_reg & level;
endmodule

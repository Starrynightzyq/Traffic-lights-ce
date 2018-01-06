`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/17 00:14:10
// Design Name: 
// Module Name: emergency
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


module emergency
    (
    input emergency,
    input [3:0] counterh,counterl,
    input [2:0] lights_in,
    output [3:0] qh,ql,
    output [2:0] lights_out
    );
    
    parameter [3:0] time_emergency = 4'h8;
    parameter [2:0] lights_emergency = 3'b100; //ºìÂÌ»Æ
    
    assign {qh,ql} = emergency ? {time_emergency,time_emergency} : {counterh,counterl};
    assign {lights_out} = emergency ? {lights_emergency} : {lights_in};
endmodule

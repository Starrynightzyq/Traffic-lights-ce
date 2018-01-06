`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/15 12:29:10
// Design Name: 
// Module Name: tb_countdown
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


module tb_countdown();
reg clk,clr,en; //clk时钟信号，clr异步清零，pe同步置数，en使能；所有信号高电or上升沿平有效
reg [3:0] dh; //置数
reg [3:0] dl;
wire tick; 
wire [3:0] qh;
wire [3:0] ql;

countdown_double #(.DVSR(5))
tb_countdown_double
(
.clk(clk),
.clr(clr),
.en(en),
.dh(dh),
.dl(dl),
.tick(tick),
.qh(qh),
.ql(ql)
);

parameter T = 4;

always begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
end

initial begin
    clr = 1'b1;
    en = 1'b0;
    dh = 4'h5;
    dl = 4'h0;
    #(5.1*T);
    en = 1'b1;
    #(T);
    clr = 1'b0;
    
end


endmodule

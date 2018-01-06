`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 08:52:04
// Design Name: 
// Module Name: testbench
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


module testbench();
reg clk;
reg reset;
reg go; //Æô¶¯ÔÝÍ£ÐÅºÅ
reg emergency; //½ô¼±Çé¿ö£¬ÁÁºìµÆ
wire [7:0] sseg;
wire [3:0] an;
wire redout_2,yellowout_2,greenout_2;
wire redout_1,yellowout_1,greenout_1;
wire s_tick;

Traffic_lights_ce #(.DVSR(5))
U_Traffic_lights_ce
(
.clk(clk),
.reset(reset),
.go(go),
.emergency(emergency),
.sseg(sseg),
.an(an),
.redout_2(redout_2),
.yellowout_2(yellowout_2),
.greenout_2(greenout_2),
.redout_1(redout_1),
.yellowout_1(yellowout_1),
.greenout_1(greenout_1)
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
    emergency = 1'b0;
    go = 1'b0;
    #(1.5*T);
    reset = 1'b0;
    #(T);
    go = 1'b1;
    #(19.4*T);
    emergency = 1'b0;
    #(100*T);
    emergency = 1'b0;
    #(100*T);
    go = 1'b0;
    #(100*T);
    go = 1'b1;
    #(100*T);
    emergency = 1'b1;
    #(500*T);
    emergency = 1'b0;
    
end

endmodule

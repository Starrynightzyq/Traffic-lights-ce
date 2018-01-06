`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 08:31:42
// Design Name: 
// Module Name: fsm_lights
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


module fsm_lights
    (
    input clk,
    input reset,
    input change_2, //每一个change改变一次灯
    input change_1,
    input en, //使能
    output redout_1,redout_2, //灯信号输出，接led，东西方向为2，南北方向为1
    output greenout_1,greenout_2,
    output yellowout_1,yellowout_2,
    output [3:0] d2_1,d2_0,d1_1,d1_0 //d2_0,d2_1为灯2，d1_0,d1_1为灯1，接计数器置数
    );
    
    reg [7:0] time_reg_2,time_reg_1; //倒计时时间
    reg [7:0] time_next_2,time_next_1;
    reg [2:0] lights_reg_2,lights_reg_1;
    reg [2:0] lights_next_2,lights_next_1;
    parameter [2:0] red = 3'b100; //灯信号，接lights_reg，接out
    parameter [2:0] yellow = 3'b010;
    parameter [2:0] green = 3'b001;
    parameter time_red_2 = 8'b0011_0101; //red2 35 东西方向时间 
    parameter time_yellow_2 = 8'b0000_0101; //yellow2 5
    parameter time_green_2 = 8'b0100_0101; //green2 45
    parameter time_red_1 = 8'b0101_0000; //red1 50 南北方向时间
    parameter time_yellow_1 = 8'b0000_0101; //yellow1 5
    parameter time_green_1 = 8'b0011_0000; //green1 30
    parameter time_emergency = 8'b1000_1000; //紧急时时间显示88 
    
    //寄存器部分
    always@(posedge clk) begin
            time_reg_2 <= time_next_2;
            time_reg_1 <= time_next_1;
            lights_reg_2 <= lights_next_2;
            lights_reg_1 <= lights_next_1;
    end
    
    //2（东西方向）下一个状态逻辑
    always@(*) begin
        time_next_2 = time_reg_2;
        lights_next_2 = lights_reg_2;
        if(reset) begin
            time_next_2 <= time_green_2; //东西方向上默认绿灯
            lights_next_2 <= green; 
        end else if(en) begin
            case(time_reg_2)
            time_red_2 : 
                if(change_2) begin
                    time_next_2 = time_green_2;
                    lights_next_2 = green;
                end else begin
                    time_next_2 = time_red_2;
                    lights_next_2 = red;
                end
            time_green_2 : 
                if(change_2) begin
                    time_next_2 = time_yellow_2;
                    lights_next_2 = yellow;
                end else begin
                    time_next_2 = time_green_2;
                    lights_next_2 = green;
                end
            time_yellow_2 : 
                if(change_2) begin
                    time_next_2 = time_red_2;
                    lights_next_2 = red;
                end else begin
                    time_next_2 = time_yellow_2;
                    lights_next_2 = yellow;
                end
            default : begin
                    time_next_2 = time_green_2;
                    lights_next_2 = green;
                end
            endcase
        end
    end
        
    //1（南北方向）下一个状态逻辑
    always@(*) begin
        time_next_1 = time_reg_1;
        lights_next_1 = lights_reg_1;
        if(reset) begin
            time_next_1 <= time_red_1; //南北方向上默认红灯
            lights_next_1 <= red;
        end else if(en) begin
            case(time_reg_1)
            time_red_1 : 
                if(change_1) begin
                    time_next_1 = time_green_1;
                    lights_next_1 = green;
                end else begin
                    time_next_1 = time_red_1;
                    lights_next_1 = red;
                end
            time_green_1 : 
                if(change_1) begin
                    time_next_1 = time_yellow_1;
                    lights_next_1 = yellow;
                end else begin
                    time_next_1 = time_green_1;
                    lights_next_1 = green;
                end
            time_yellow_1 : 
                if(change_1) begin
                    time_next_1 = time_red_1;
                    lights_next_1 = red;
                end else begin
                    time_next_1 = time_yellow_1;
                    lights_next_1 = yellow;
                end
            default : begin
                    time_next_1 = time_red_1;
                    lights_next_1 = red;
                end
            endcase
        end
    end
    
    //输出信号
    assign {d2_1,d2_0,d1_1,d1_0} = {time_reg_2,time_reg_1};
    assign redout_2 = lights_reg_2[2];
    assign yellowout_2 = lights_reg_2[1];
    assign greenout_2 = lights_reg_2[0];
    assign redout_1 = lights_reg_1[2];
    assign yellowout_1 = lights_reg_1[1];
    assign greenout_1 = lights_reg_1[0];
endmodule

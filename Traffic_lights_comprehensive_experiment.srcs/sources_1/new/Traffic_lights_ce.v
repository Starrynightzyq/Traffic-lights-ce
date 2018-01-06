`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 08:17:59
// Design Name: 
// Module Name: Traffic_lights_ce
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


module Traffic_lights_ce 
    #(parameter DVSR = 10000_0000 - 1)
    (
    input clk,
    input reset,
    input go, //启动暂停信号
    input emergency, //紧急情况，亮红灯
    output [7:0] sseg,
    output [3:0] an,
    output redout_2,yellowout_2,greenout_2,
    output redout_1,yellowout_1,greenout_1
    );
    
    //内部信号声明
    wire counter1_tick; //倒计时结束信号
    wire counter2_tick;
    wire [3:0] d2_1,d2_0,d1_1,d1_0; //fsm输出倒计时初始值
    wire [3:0] q2_1,q2_0,q1_1,q1_0; //计数器输出值，接led_display
    wire [3:0] sq2_1,sq2_0,sq1_1,sq1_0; //选择后输出
    wire tick_1_c,tick_2_c;
    wire en;
    wire fsm_redout_1,fsm_greenout_1,fsm_yellowout_1;
    wire fsm_redout_2,fsm_greenout_2,fsm_yellowout_2;
    wire s_yellowout_2,s_yellowout_1; //选择后黄灯输出
    
    assign en = go && (!emergency);
    
    //实例化各模块
    countdown_double #(.DVSR(DVSR))
    U_countdown_double_2
    (
    .clk(clk),
    .clr(reset),
    .en(en),
    .dh(d2_1),
    .dl(d2_0),
    .tick(counter2_tick),
    .qh(q2_1),
    .ql(q2_0)    
    );
    countdown_double  #(.DVSR(DVSR))
    U_countdown_double_1
    (
    .clk(clk),
    .clr(reset),
    .en(en),
    .dh(d1_1),
    .dl(d1_0),
    .tick(counter1_tick),
    .qh(q1_1),
    .ql(q1_0)  
    );
    fsm_lights U_fsm_lights
    (
    .clk(clk),
    .reset(reset),
    .change_2(tick_2_c),
    .change_1(tick_1_c),
    .en(en),
    .redout_2(fsm_redout_2),
    .redout_1(fsm_redout_1),
    .greenout_2(fsm_greenout_2),
    .greenout_1(fsm_greenout_1),
    .yellowout_2(fsm_yellowout_2),
    .yellowout_1(fsm_yellowout_1),
    .d2_1(d2_1),
    .d2_0(d2_0),
    .d1_1(d1_1),
    .d1_0(d1_0)
    );
    scan_led_hex_disp U_scan_led_hex_disp
    (
    .clk(clk),
    .reset(reset),
    .hex3(sq2_1),
    .hex2(sq2_0),
    .hex1(sq1_1),
    .hex0(sq1_0),
    .dp_in(4'b1011), //小数点
    .an(an), //位选信号
    .sseg(sseg) //段选信号
    );
    edge_trigger U_edge_trigger_counter1_change1
    (
    .clk(clk),
    .reset(reset),
    .level(counter1_tick),
    .tick(tick_1_c)
    );
    edge_trigger U_edge_trigger_counter1_change2
    (
    .clk(clk),
    .reset(reset),
    .level(counter2_tick),
    .tick(tick_2_c)
    );
    blink #(.DVSR(DVSR))
    U_blink_1
    (
    .clk(clk),
    .reset(reset),
    .en(s_yellowout_1),
    .blink(yellowout_1)
    );
    blink #(.DVSR(DVSR))
    U_blink_2
    (
    .clk(clk),
    .reset(reset),
    .en(s_yellowout_2),
    .blink(yellowout_2)
    );
    emergency U_emergency_1
    (
    .emergency(emergency),
    .counterh(q1_1),
    .counterl(q1_0),
    .lights_in({fsm_redout_1,fsm_greenout_1,fsm_yellowout_1}), //红绿黄
    .qh(sq1_1),
    .ql(sq1_0),
    .lights_out({redout_1,greenout_1,s_yellowout_1})
    );
    emergency U_emergency_2
    (
    .emergency(emergency),
    .counterh(q2_1),
    .counterl(q2_0),
    .lights_in({fsm_redout_2,fsm_greenout_2,fsm_yellowout_2}),
    .qh(sq2_1),
    .ql(sq2_0),
    .lights_out({redout_2,greenout_2,s_yellowout_2})
    );
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/13 21:18:00
// Design Name: 
// Module Name: countdown_double
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


module countdown_double
    #(parameter DVSR = 10000_0000 - 1,dh_min = 0,dl_min = 1)
    (
    input wire clk,clr,en, //clkʱ���źţ�clr�첽���㣬peͬ��������enʹ�ܣ������źŸߵ�or������ƽ��Ч
    input wire [3:0] dh, //����
    input wire [3:0] dl,
    output wire tick, 
    output wire [3:0] qh,
    output wire [3:0] ql
    );
    //�ڲ��ź�����
    reg [29:0] ms_reg;
    wire [29:0] ms_next;
    wire ms_tick;
    reg [3:0] dh_reg,dl_reg;
    reg [3:0] dh_next,dl_next;
    wire pe; //�ڲ���������
    
    //�Ĵ�������
    always@(posedge clk) begin
        dh_reg <= dh_next;
        dl_reg <= dl_next;
        ms_reg <= ms_next;
    end
    
    //��Ƶ
    assign ms_next = (clr||(ms_reg == DVSR && en)) ? 0 :
                                              (en) ? ms_reg + 1 :
                                                     ms_reg;
    assign ms_tick = (en)&&(ms_reg == DVSR) ? 1'b1 : 1'b0;
    
    //��һ��״̬
    always@(*) begin
        dh_next = dh_reg;
        dl_next = dl_reg;
        if(clr) begin
            dh_next = dh;
            dl_next = dl;
        end else if(ms_tick) begin
            if(dh_reg == dh_min && dl_reg == dl_min) begin
                dh_next = dh;
                dl_next = dl;
            end else if(dl_reg != 0) begin
                dl_next = dl_reg - 1;
            end else begin
                dl_next = 4'h9;
                if(dh_reg != 0) begin
                    dh_next = dh_reg - 1;
                end else begin
                    dl_next = dl;
                    dh_next = dh;
                end
            end
        end 
    end
    
    //����߼�
    assign qh = dh_reg;
    assign ql = dl_reg;
    assign tick = (dl_reg==dl_min && dh_reg==dh_min)?1'b1:1'b0;
    
    reg delay_reg;
    
    always@(posedge clk,posedge clr) begin
        if(clr) begin
            delay_reg <= 1'b0;
        end else begin
            delay_reg <= tick;
        end
    end
    
    assign pe = (~delay_reg & tick)||clr;
    
endmodule

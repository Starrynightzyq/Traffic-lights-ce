`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 08:22:54
// Design Name: 
// Module Name: countdown
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


module countdown
    (
    input wire clk,clr,pe,en, //clkʱ���źţ�clr�첽���㣬peͬ��������enʹ�ܣ������źŸߵ�or������ƽ��Ч
    input wire [3:0] d, //����
    input wire sec, //������ʽѡ��1Ϊ��λ��0Ϊ
    output wire tick, 
    output wire [3:0] q
    );

    //�ź�����
    reg [3:0] r_reg;
    reg [3:0] r_next;
    reg delay_reg;
    wire level;
    //�Ĵ�������
    always@(posedge clk, posedge clr) begin
        if(clr) begin
            r_reg <= 9;
        end else begin
            r_reg <= r_next;
        end
    end

    //��һ��״̬�߼�
    always@(*) begin
        r_next = r_reg;
        if(pe) begin
           r_next = d; 
        end else if(en) begin 
            if(r_reg == 0) begin
                if(sec) begin
                    r_next = d;
                end else begin
                    r_next = 9;
                end
            end else begin
                r_next = r_reg - 1;
            end 
        end
    end
    
    assign level = (r_reg == 0) ? 1'b1 : 1'b0;
    //�����ش���
    always@(posedge clk,posedge clr) begin
        if(clr) begin
            delay_reg <= 1'b0;
        end else begin
            delay_reg <= level;
        end
    end
    //����߼�
    assign q = r_reg;
    assign tick = delay_reg;    
    
endmodule

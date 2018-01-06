`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 10:22:56
// Design Name: 
// Module Name: scan_led_hex_display
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


module scan_led_hex_disp(clk,reset,hex3,hex2,hex1,hex0,dp_in,an,sseg);
input clk,reset;
input [3:0] hex3,hex2,hex1,hex0;
input [3:0] dp_in; //小数点
output reg [3:0] an; //位选信号
output reg [7:0] sseg; //段选信号
localparam  N = 18; //100MHZ/2^16??
reg [N-1:0] regN;
reg [3:0] hex_in;
reg dp;

always @ ( posedge clk, posedge reset ) begin
    if (reset) begin
        regN <= 0;
    end else begin
        regN <= regN + 1;
    end
end

always @ ( * ) begin
    case (regN[N-1:N-2])
        2'b00:
            begin
                an = 4'b1110;
                hex_in = hex0;
                dp = dp_in[0];
            end
        2'b01:
            begin
                an = 4'b1101;
                hex_in = hex1;
                dp = dp_in[1];
            end
        2'b10:
            begin
                an = 4'b1011;
                hex_in = hex2;
                dp = dp_in[2];
            end
        default:
            begin
                an = 4'b0111;
                hex_in = hex3;
                dp = dp_in[3];
            end
    endcase
end

always @ ( * ) begin
    case (hex_in)
        4'h0:sseg[6:0] = 7'b0000001;
        4'h1:sseg[6:0] = 7'b1001111;
        4'h2:sseg[6:0] = 7'b0010010;
        4'h3:sseg[6:0] = 7'b0000110;
        4'h4:sseg[6:0] = 7'b1001100;
        4'h5:sseg[6:0] = 7'b0100100;
        4'h6:sseg[6:0] = 7'b0100000;
        4'h7:sseg[6:0] = 7'b0001111;
        4'h8:sseg[6:0] = 7'b0000000;
        4'h9:sseg[6:0] = 7'b0000100;
        4'ha:sseg[6:0] = 7'b0001000;
        4'hb:sseg[6:0] = 7'b1100000;
        4'hc:sseg[6:0] = 7'b0110001;
        4'hd:sseg[6:0] = 7'b1000010;
        4'he:sseg[6:0] = 7'b0110000;
        4'hf: sseg[6:0] = 7'b0111000; //4'hf
        default: sseg[6:0] = 7'b0000000;
    endcase
    sseg[7] = dp;
end
endmodule

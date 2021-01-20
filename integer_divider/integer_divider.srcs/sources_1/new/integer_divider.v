`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 12:15:28 PM
// Design Name: 
// Module Name: integer_divider
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


module integer_divider(input [3:0] x,
                       input [3:0] y,
                       input go,
                       input rst,
                       input CLK,
                       output [3:0] quotient,
                       output [3:0] remainder,
                       output Done, Err);
    wire yZero, cnt, R_lt_Y; 
    wire x_RightIn, x_LD, x_SL, y_LD, r_LD, r_SL, r_SR; 
    wire s1,s2,s3; 
    wire [3:0] n;
    wire cnt_LD, cnt_en;          
CU FSM (.Go(go),
        .clk(CLK),
        .rst(rst),
        .yZero(yZero),
        .cnt(cnt),
        .R_lt_Y(R_lt_Y),
        .x_RightIn(x_RightIn),
        .x_LD(x_LD),
        .x_SL(x_SL),
        .y_LD(y_LD),
        .r_LD(r_LD),
        .r_SL(r_SL),
        .r_SR(r_SR),
        .s1(s1),
        .s2(s2),
        .s3(s3),
        .n(n),
        .cnt_LD(cnt_LD),
        .cnt_en(cnt_en),
        .Done(Done),
        .Err(Err));
 data_path DP (.x(x),
               .x_RightIn(x_RightIn),
               .x_LD(x_LD),
               .x_SL(x_SL),
               .y(y),
               .y_LD(y_LD),
               .r_LD(r_LD),
               .r_SL(r_SL),
               .r_SR(r_SR),
               .s1(s1),
               .s2(s2),
               .s3(s3),
               .n(n),
               .cnt_LD(cnt_LD),
               .cnt_en(cnt_en), 
               .rst(rst),
               .clk(CLK),
               .cnt_out(cnt),
               .R_lt_Y(R_lt_Y),
               .yZero(yZero),
               .Q(quotient),
               .R(remainder));      
                               
endmodule

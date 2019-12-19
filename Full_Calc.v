`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2019 04:57:01 PM
// Design Name: 
// Module Name: Full_Calc
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


module Full_Calc(input Go,
                 input [3:0] X, Y,
                 input [2:0] F,
                 input clk, rst,
                 output Done,
                 output [3:0] H, L,
                 output [3:0] CS,
                 output Err
    );
    
    wire [2:0] qF;
    wire Done_Calc, Done_DIV;
    wire Sel_square, Sel_H;
    wire En_F, En_X, En_Y;// CU output 
    wire Go_Calc, Go_DIV;
    wire En_Out_H, En_Out_L;
    wire [1:0] Op_Calc, Sel_L;
    
    Top_CU CU (.Go(Go),
               .F(qF),
               .clk(clk),
               .Done_Calc(Done_Calc),
               .Done_DIV(Done_DIV),
               .Sel_square(Sel_square),
               .En_F(En_F),
               .En_X(En_X),
               .En_Y(En_Y),
               .Go_Calc(Go_Calc),
               .Go_DIV(Go_DIV),
               .Op_Calc(Op_Calc),
               .Sel_H(Sel_H),
               .Sel_L(Sel_L),
               .En_Out_H(En_Out_H),
               .En_Out_L(En_Out_L),
               .Done(Done),
               .CS(CS),
               .Err(Err),
               .rst(rst));
               
    FullCalc_dp DP(.x(X),
                   .y(Y),
                   .f(F),
                   .En_F(En_F),
                   .En_X(En_X),
                   .En_Y(En_Y),
                   .Go_Calc(Go_Calc),
                   .Go_DIV(Go_DIV),
                   .Op_Calc(Op_Calc),
                   .Sel_H(Sel_H),
                   .Sel_L(Sel_L),
                   .En_Out_H(En_Out_H),
                   .En_Out_L(En_Out_L),
                   .Sel_square(Sel_square),
                   .clk(clk),
                   .rst(rst),
                   .Done_Calc(Done_Calc),
                   .Done_DIV(Done_DIV),
                   .qF(qF),
                   .L(L),
                   .H(H),
                   .Err(Err));
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 06:05:06 PM
// Design Name: 
// Module Name: FullCalc_dp
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


module FullCalc_dp(input [3:0] x, y,
                   input [2:0] f,
                   input En_F, En_X, En_Y,
                   input Go_Calc, Go_DIV,
                   input [1:0] Op_Calc,
                   input Sel_H, Sel_L, En_out_H, En_out_L,
                   input rst, clk,
                   output Done_Calc, Done_DIV,
                   output [2:0] qF,
                   output [3:0] L, H
    );
    
    wire [3:0] qX, qY;
    wire [3:0] Calc_out, quotient, remainder, qL, qH;
    wire [7:0] P_out;
    
    
    flopenr#3 F( .clk(clk), .reset(rst), .en(En_F), .d(f), .q(qF));
    flopenr#4 X( .clk(clk), .reset(rst), .en(En_X), .d(x), .q(qX));
    flopenr#4 Y( .clk(clk), .reset(rst), .en(En_Y), .d(y), .q(qY));
    
    Calc Calc(.go(Go_Calc),
              .op(Op_Calc),
              .in1(qX),
              .in2(qY),
              .done(Done_Calc),
              //.CS(),
              .out(Calc_out));
              
    MUL MUL(.A(qX),
            .B(qY),
            .P(P_out),
            .Clk(clk),
            .Reset(rst),
            .En(1));  
            
    DIV DIV(.x(qX),
            .y(qY),
            .go(Go_DIV),
            .rst(rst),
            .Clk(clk),
            .quotient(quotient),
            .remainder(remainder),
            //.Err(),
            .Done(Done_DIV)); 
     
    mux4 #4  MUX_L(.sel(Sel_L),
                   .in0(4'b0000),
                   .in1(Calc_out),
                   .in2(P_out[3:0]),
                   .in3(quotient),
                   .out(qL));
                   
   mux2 #2 MUX_H(.sel(Sel_H),
                 .in0(P_out[7:4]),
                 .in1(remainder),
                 .out(qH));
                 
   flopenr#4 Out_H( .clk(clk), .reset(rst), .en(En_out_H), .d(qH), .q(H));
   flopenr#4 Out_L( .clk(clk), .reset(rst), .en(En_out_L), .d(qL), .q(L));                 
                       
    
endmodule

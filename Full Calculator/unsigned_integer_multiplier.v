`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2019 04:56:46 PM
// Design Name: 
// Module Name: unsigned_integer_multiplier
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


module MUL( input [3:0]A, input[3:0]B, output[7:0]P, 
        input Clk,input Reset, input En);
    wire[3:0] pp3,pp2, pp1, pp0;
    wire[3:0] q_A, q_B;
    wire[7:0] q_top, q_bottom, d_P;
    wire[7:0] shifted_3, shifted_2, shifted_1, shifted_0;
    wire[7:0] top, bottom, mid;
    wire Cout_top_left, Cout_top_right, Cout_bottom_left, Cout_bottom_right,
    Cout_mid_left, Cout_mid_right;
    
 // insert input registers to the inputs
    flopenr#4 A_reg( .clk(Clk), .reset(Reset), .en(En), .d(A), .q(q_A));
    flopenr#4 B_reg(.clk(Clk), .reset(Reset), .en(En), .d(B), .q(q_B));
// use to and for the function (a3a2a1a0)*bi    
    AND and_3(.A(q_A[3:0]), .B(q_B[3]), .out(pp3[3:0]));
    AND and_2(.A(q_A[3:0]), .B(q_B[2]), .out(pp2[3:0]));
    AND and_1(.A(q_A[3:0]), .B(q_B[1]), .out(pp1[3:0]));
    AND and_0(.A(q_A[3:0]), .B(q_B[0]), .out(pp0[3:0]));
 
//shift every pp by +1 bit 
    shift shift_3(.pp(pp3[3:0]), .index(2'b11), .out(shifted_3));
    shift shift_2(.pp(pp2[3:0]), .index(2'b10), .out(shifted_2));
    shift shift_1(.pp(pp1[3:0]), .index(2'b01), .out(shifted_1));
    shift shift_0(.pp(pp0[3:0]), .index(2'b00), .out(shifted_0));
    
 //add all 4 together
 //top
    CLA top_right(.A_1(shifted_0[3:0]), .B_1(shifted_1[3:0]), .Cin(1'b0), 
    .sum(top[3:0]), .Cout(Cout_top_right));
    CLA top_left(.A_1(shifted_0[7:4]), .B_1(shifted_1[7:4]), .Cin(Cout_top_right),
    .sum(top[7:4]), .Cout(Cout_top_left));
//bottom 
    CLA bottom_right(.A_1(shifted_2[3:0]), .B_1(shifted_3[3:0]), .Cin(1'b0), 
    .sum(bottom[3:0]), .Cout(Cout_bottom_right));
    CLA bottom_left(.A_1(shifted_2[7:4]), .B_1(shifted_3[7:4]), .Cin(Cout_bottom_right),
    .sum(bottom[7:4]), .Cout(Cout_bottom_left));
//insert stage registers
    flopenr  top_reg( .clk(Clk), .reset(Reset), .en(En), .d(top), .q(q_top));
    flopenr bottom_reg(.clk(Clk), .reset(Reset), .en(En), .d(bottom), .q(q_bottom));
//add top and bottom together
    CLA mid_right(.A_1(q_top[3:0]), .B_1(q_bottom[3:0]), .Cin(1'b0),
    .sum(d_P[3:0]), .Cout(Cout_mid_right));
    CLA mid_left(.A_1(q_top[7:4]), .B_1(q_bottom[7:4]), .Cin(Cout_mid_right),
    .sum(d_P[7:4]), .Cout(Cout_mid_left));
////insert output registers
    flopenr  out_reg( .clk(Clk), .reset(Reset), .en(En), .d(d_P), .q(P));

endmodule

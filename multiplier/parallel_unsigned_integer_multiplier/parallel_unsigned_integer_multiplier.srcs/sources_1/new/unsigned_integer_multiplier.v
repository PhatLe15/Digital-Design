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


module unsigned_integer_multiplier( input [3:0]A, input[3:0]B, output[7:0]P);
    wire[3:0] pp3,pp2, pp1, pp0;
    wire[7:0] shifted_3, shifted_2, shifted_1, shifted_0;
    wire[7:0] top, bottom, mid;
    wire Cout_top_left, Cout_top_right, Cout_bottom_left, Cout_bottom_right,
    Cout_mid_left, Cout_mid_right;
// use to and for the function (a3a2a1a0)*bi    
    AND and_3(.A(A[3:0]), .B(B[3]), .out(pp3[3:0]));
    AND and_2(.A(A[3:0]), .B(B[2]), .out(pp2[3:0]));
    AND and_1(.A(A[3:0]), .B(B[1]), .out(pp1[3:0]));
    AND and_0(.A(A[3:0]), .B(B[0]), .out(pp0[3:0]));
 
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
//add top and bottom together
    CLA mid_right(.A_1(top[3:0]), .B_1(bottom[3:0]), .Cin(1'b0),
    .sum(P[3:0]), .Cout(Cout_mid_right));
    CLA mid_left(.A_1(top[7:4]), .B_1(bottom[7:4]), .Cin(Cout_mid_right),
    .sum(P[7:4]), .Cout(Cout_mid_left));
 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2019 05:48:33 PM
// Design Name: 
// Module Name: CLA
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



module CLA(
                input[3:0]          A_1, B_1,
                input               Cin,
                output[3:0]         sum,
                output              Cout       );
 
    wire[3:0] P, G;
    wire[4:0] C;
 
    half_adder X0(.A(A_1[0]), .B(B_1[0]), .Y(P[0]), .carry(G[0]));
    half_adder X1(.A(A_1[1]), .B(B_1[1]), .Y(P[1]), .carry(G[1]));
    half_adder X2(.A(A_1[2]), .B(B_1[2]), .Y(P[2]), .carry(G[2]));
    half_adder X3(.A(A_1[3]), .B(B_1[3]), .Y(P[3]), .carry(G[3]));
 
    assign C[0] = Cin;
    assign C[1] = G[0]|(P[0]&Cin);
    assign C[2] = G[1]|(P[1]&G[0])|(P[1]&P[0]&C[0]);
    assign C[3] = G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&C[0]);
    assign C[4] = G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&C[0]);
 
    assign Cout = C[4];
    XOR2 Z3(.a(C[3]),.b(P[3]),.out(sum[3]));
    XOR2 Z2(.a(C[2]),.b(P[2]),.out(sum[2]));
    XOR2 Z1(.a(C[1]),.b(P[1]),.out(sum[1]));
    XOR2 Z0(.a(C[0]),.b(P[0]),.out(sum[0]));
endmodule

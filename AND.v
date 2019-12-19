`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2019 05:05:57 PM
// Design Name: 
// Module Name: AND
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


module AND(
    input [3:0]A,
    input B,
    output [3:0]out
    );
    assign out[3] = B & A[3];
    assign out[2] = B & A[2];
    assign out[1] = B & A[1];
    assign out[0] = B & A[0];
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 01:03:30 PM
// Design Name: 
// Module Name: CLA_inferred_adder
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


module CLA_inferred_adder(
                    input[3:0]      A, B,
                    input           Cin,
                    output reg[3:0] Y,
                    output reg      Cout);
    integer temp;
    always@(*)
    begin
        temp = A + B + Cin;
        assign Y = {temp[3:0]};
        assign Cout = {temp[4]};
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2019 08:27:10 PM
// Design Name: 
// Module Name: ALU
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


module ALU( input wire[3:0]          A, 
            input wire[3:0]          B,
            input wire[2:0]          ctrl,
            output reg[3:0]     out,
            output              zero, 
            output reg          overflow
            );

always@(*)
    case(ctrl)
        3'b000: begin overflow = 0; out = A & B; end    //bitwise AND
        3'b001: begin overflow = 0; out = A | B; end    //bitwise OR
        3'b010: {overflow, out} = A + B;    //addition
        3'b110: {overflow, out} = A - B;    //subtraction
        3'b111: begin overflow = 0; out = (A < B)? 1:0; end     //SLT
    endcase
    
    //assign overflow = (out[4] == 5'b1);
    assign zero = (out == 4'b0);

endmodule
  
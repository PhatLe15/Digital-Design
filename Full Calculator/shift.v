`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2019 05:15:52 PM
// Design Name: 
// Module Name: shift
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


module shift(input [3:0]pp, input [1:0] index, 
                output reg [7:0] out 
    );
    always @(*)
        case (index)
            2'b00: out = {4'b0000,pp[3:0]};
            2'b01: out = {3'b000,pp[3:0],1'b0};
            2'b10: out = {2'b00,pp[3:0],2'b00};
            2'b11: out = {1'b0,pp[3:0],3'b000};
            default: out = {4'b0000,pp[3:0]};
        endcase
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2019 01:00:10 PM
// Design Name: 
// Module Name: shift_rotator
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


module shift_rotator(
    input wire[2:0] control,
    input wire[3:0] x,
    output reg [3:0] y
    );
    always @(control,x)
    begin
        case(control)
            3'b000: y=x;
            3'b001: y={1'b0,x[3:1]};
            3'b010: y={2'b00, x[3:2]};
            3'b011: y={3'b000,x[3:3]};
            3'b100: y=4'b0000;
            3'b101: y={x[0],x[3:1]};
            3'b110: y={x[1:0],x[3:2]};
            3'b111: y={x[2:0],x[3]};
            default: y=4'b0000;
        endcase
     end
endmodule

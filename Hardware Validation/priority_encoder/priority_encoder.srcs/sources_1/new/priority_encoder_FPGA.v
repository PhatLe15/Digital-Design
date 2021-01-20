`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2019 02:00:16 PM
// Design Name: 
// Module Name: priority_encoder_FPGA
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


module priority_encoder_FPGA(input [7:0] switch, output [2:0] LED, output valid);
    enc_case(switch[7:0],LED[2:0],valid);   // connect the DUT
endmodule

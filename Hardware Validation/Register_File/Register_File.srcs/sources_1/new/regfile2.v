`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 12:21:53 PM
// Design Name: 
// Module Name: regfile2
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


module regfile2(input clk,
                input we1, we2,  ///write enable
                input [4:0] ra1, ra2, wa1, wa2,   // read address
                input[31:0] wd1, wd2,   //write data
                output [31:0] rd1, rd2);
    reg [31:0] rf [31:0];  //read file
    always @(posedge clk)
    begin
        if(we1) rf[wa1] <= wd1;
        else if(we2) rf[wa2] <= wd2;
    end
    
    assign rd1 = (ra1 != 0) ? rf[ra1]:0;
    assign rd2 = (ra2 != 0) ? rf[ra2]:0;
endmodule

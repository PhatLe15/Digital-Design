`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2019 04:01:44 PM
// Design Name: 
// Module Name: calculatorFPGA
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


module calculatorFPGA(input go,
                      input [1:0] op,
                      input clk,
                      input [3:0] in1,in2,
                      output [3:0] CS,
                      output done,
                      output [3:0] out
    );
    
    wire [1:0] s1, wa, c, raa, rab;
    wire we, rea, reb, s2;
    
    CU cu(.go(go),
          .op(op),
          .clk(clk),
          .done(done),
          .CS(CS),
          .s1(s1),
          .wa(wa),
          .c(c),
          .raa(raa),
          .rab(rab),
          .we(we),
          .rea(rea),
          .reb(reb),
          .s2(s2));
    small_calculator_dp DP(.clk(clk),
                           .in1(in1),
                           .in2(in2),
                           .s1(s1),
                           .wa(wa),
                           .raa(raa),
                           .rab(rab),
                           .c(c),
                           .we(we),
                           .rea(rea),
                           .reb(reb),
                           .s2(s2),
                           .out(out));
          
endmodule

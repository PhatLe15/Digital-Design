`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2019 08:32:25 PM
// Design Name: 
// Module Name: tb_ALU
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


module tb_ALU;

reg[3:0] A_tb;
reg[3:0] B_tb;
reg[2:0] ctrl_tb;
wire[3:0] out_tb;
wire zero_tb;
wire overflow_tb;

ALU DUT(.A(A_tb), .B(B_tb), .ctrl(ctrl_tb), .out(out_tb), .zero(zero_tb), .overflow(overflow_tb));

integer a;
integer b;
integer c;

initial
begin

    $display("Testbench started.");
    
    for (a = 0; a < 16; a = a + 1)//input a
    begin
        A_tb = a;
        for (b = 0; b < 16; b = b + 1)//input b
        begin
            B_tb = b;
            for (c = 0; c < 8; c = c + 1)//control
            begin
                ctrl_tb = c; #5
                if (c == 0 && out_tb != (A_tb & B_tb))              $display("Control signal 000: error at A = %0d, B = %0d", a, b);
                else if (c == 1 && out_tb != (A_tb | B_tb))         $display("Control signal 001: error at A = %0d, B = %0d", a, b);
                else if (c == 2 && out_tb != (A_tb + B_tb))         $display("Control signal 010: error at A = %0d, B = %0d", a, b);
                else if (c == 6 && out_tb != (A_tb - B_tb))         $display("Control signal 110: error at A = %0d, B = %0d", a, b);
                else if (c == 7 && out_tb != (A_tb < B_tb)?1:0)     $display("Control signal 111: error at A = %0d, B = %0d", a, b);
            end
        end
    end
    
    $display("Test was successful.");
    #10 $finish;
    
end
endmodule

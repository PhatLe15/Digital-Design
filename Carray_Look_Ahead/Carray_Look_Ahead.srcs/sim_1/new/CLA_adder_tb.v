`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 01:18:29 PM
// Design Name: 
// Module Name: CLA_adder_tb
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

module CLA_adder_tb;
    reg tb_Cin;
    reg[3:0] tb_A;
    reg[3:0] tb_B;
    reg[3:0] sum_expected;
    reg cout_expected;
    wire[3:0] tb_sum;
    
    wire tb_Cout;
 
    CLA_adder_top DUT(.Cin(tb_Cin), .A_1(tb_A), .B_1(tb_B), .sum(tb_sum), .Cout(tb_Cout));
 
    integer i;
    integer j;
    integer k;
    integer error;
 
initial
begin
    error = 0;
    for (i=0; i<2; i=i+1)
        begin
        tb_Cin = i;
        for (j=0; j<16; j=j+1)
            begin
                tb_A = j;
                for (k=0; k<16; k=k+1)
                begin
                    tb_B = k;
                    {cout_expected, sum_expected } = tb_A + tb_B + tb_Cin;
                    
                    if ({cout_expected, sum_expected} != (tb_A + tb_B + tb_Cin))
                    begin
                        $display("error");
                        error = error + 1;
                    end
                    #5;
                end
            end
        end
 
    if(!error) $display("Test finished with %0d errors", error);            
    #10 $finish;
 
end
endmodule


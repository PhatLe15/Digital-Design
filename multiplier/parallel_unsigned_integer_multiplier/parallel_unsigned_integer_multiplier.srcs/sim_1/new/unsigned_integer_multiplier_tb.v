`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2019 06:19:00 PM
// Design Name: 
// Module Name: unsigned_integer_multiplier_tb
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


module unsigned_integer_multiplier_tb;
    reg [3:0] A_tb;
    reg [3:0] B_tb;
    wire [7:0] P_tb;
    
    unsigned_integer_multiplier DUT(.A(A_tb), .B(B_tb), .P(P_tb));
    integer i,j, errors;
    reg[7:0] P_expected;
    initial 
    begin
        errors = 0;
        for(i=0; i< 16; i=i+1)
        begin
            A_tb = i;
            for(j=0; j< 16; j=j+1)
            begin
                B_tb = j;
                P_expected = A_tb*B_tb;
                #5;
                if(P_tb != P_expected)
                begin
                    $display("Failed when A=%b, B=%b, the P_expected is %d, but the actual value P is %d",
                                A_tb, B_tb, P_expected, P_tb);
                    errors = errors+1;
                end 
                #5;
            end
        end
        if(!errors) $display("Test finished with %0d errors", errors);            
    #10 $finish;
    end
endmodule

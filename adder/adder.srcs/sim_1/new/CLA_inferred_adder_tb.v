`timescale 1ns / 1ps

module CLA_inferred_adder_tb;
    reg [3:0] A_tb, B_tb;
    reg cin_tb;
    wire [3:0] sum_tb;
    wire cout_tb;
    reg [3:0] sum_expected;
    reg  cout_expected;
    CLA_inferred_adder DUT(.A(A_tb), .B(B_tb), .Cin(cin_tb), .Y(sum_tb), .Cout(cout_tb));

integer i, j, k;
initial 
begin
 
        for (i=0; i<2; i=i+1)
        begin
            cin_tb = i;
            for (j=0; j<16; j=j+1)
                begin
                    A_tb = j;
                    for (k=0; k<16; k=k+1)
                    begin
                        B_tb = k;
                        #5
                        assign {cout_expected, sum_expected} = A_tb + B_tb + cin_tb;
                        if (sum_tb != sum_expected)// if the sum is not as expected
                            begin
                                $display("Failed when A=%b, B=%b, Cin=%b, the expected sum is %d, but the actual value is %d",
                                A_tb, B_tb, cin_tb, sum_expected, sum_tb);
                            end
                        if (cout_tb != cout_expected)// if carray out is not as expected
                            begin 
                                $display("Failed when A=%b, B=%b, Cin=%b, the expected carry out is %d, but the actual value is %d",
                                A_tb, B_tb, cin_tb, cout_expected, cout_tb);
                            end
                        #5;
                    end
                end
        end
    #10 $finish;
    end
endmodule
                        







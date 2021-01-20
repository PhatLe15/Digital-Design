`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 09:58:46 AM
// Design Name: 
// Module Name: shift_register_tb
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


module shift_register_tb;
    reg LD_tb,SL_tb,SR_tb,clk_tb,LeftIn_tb, RightIn_tb;
    reg[4:0] D_tb;
    wire [4:0] Q_tb;
    
    shift_register #5 DUT(.LD(LD_tb),
                       .SL(SL_tb),
                       .SR(SR_tb),
                       .CLK(clk_tb),
                       .LeftIn(LeftIn_tb),
                       .RightIn(RightIn_tb),
                       .D(D_tb),
                       .Q(Q_tb));
                       
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    initial begin
        clk_tb = 0;
        
        LD_tb=1;
        SL_tb = 0;
        SR_tb = 0;
        LeftIn_tb = 0;
        RightIn_tb = 0;
        D_tb = 4'b0100; //load 4
        
        ticktock();
        
        LD_tb=0;
        SL_tb = 1;
        SR_tb = 0;
        LeftIn_tb = 0;
        RightIn_tb = 0;
        D_tb = 4'b0100; //shift left
        ticktock();
        
    end
endmodule

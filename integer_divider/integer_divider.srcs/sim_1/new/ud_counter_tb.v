`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 12:20:30 PM
// Design Name: 
// Module Name: ud_counter_tb
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


module ud_counter_tb;
    reg LD_tb, UD_tb, CE_tb, clk_tb, rst_tb;
    reg [3:0] D_tb;
    wire [3:0] Q_tb;
    
    ud_counter #4 DUT(.LD(LD_tb),
                      .UD(UD_tb),
                      .CE(CE_tb),
                      .CLK(clk_tb),
                      .RST(rst_tb),
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
        
        LD_tb = 1;
        UD_tb = 0;
        CE_tb = 1;
        D_tb = 4'b0100;
        
        ticktock();
        LD_tb = 0;
        UD_tb = 0;
        CE_tb = 0;
        D_tb = 0;
        
        ticktock();
        
        LD_tb = 0;//no load
        UD_tb = 0;//count down
        CE_tb = 1;
        D_tb = 0;
        
        ticktock();
        
    end
                 
endmodule

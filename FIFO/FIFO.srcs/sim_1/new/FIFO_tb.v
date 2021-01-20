`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 01:31:35 PM
// Design Name: 
// Module Name: FIFO_tb
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


module FIFO_tb;
    reg clk,rst,wnr,en;
    reg [3:0] D_in_tb;
    wire [3:0] D_out_tb;
    wire empty_tb, full_tb;
    
    integer i;
    FIFO DUT(.clk(clk),
             .rst(rst),
             .wnr(wnr),
             .enable(en),
             .D_in(D_in_tb),
             .D_out(D_out_tb),
             .empty(empty_tb),
             .full(full_tb));
           
    task ticktock;
    begin
        #5 clk = ~clk;
        #5 clk = ~clk;
    end
    endtask
    
    initial begin
        D_in_tb = 0;
        clk = 0;
        rst = 1;
        wnr = 1;//write
        en=0;
        ticktock();
        
        #5 rst = 1; // clear all unknowns
        #5 rst = 0; // clear all unknowns
        #5 en = 1; //enable to begin process
        ticktock();
        for (i = 0; i< 8; i=i+1)
        begin
            D_in_tb = i;
            wnr = 1;
            ticktock();
        end
        
        for (i = 0; i< 8; i=i+1)
        begin
            wnr = 0;
            ticktock();
        end
    end            
endmodule

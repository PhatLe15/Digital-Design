`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 04:49:54 PM
// Design Name: 
// Module Name: CU_tb
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


module CU_tb;
    reg clk_tb;
    reg go_tb;
    reg [1:0] op_tb;
    wire [3:0] cs_tb;
    wire done_tb;
    wire [1:0] s1_tb;
    wire [1:0] wa_tb;
    wire [1:0] raa_tb;
    wire [1:0] rab_tb;
    wire [1:0] c_tb;
    wire       we_tb;
    wire       rea_tb;
    wire       reb_tb;
    wire       s2_tb;
    
    CU DUT(.clk(clk_tb),
           .op(op_tb),
           .done(done_tb),
           .go(go_tb),
           .CS(cs_tb),
           .s1(s1_tb),
           .wa(wa_tb),
           .raa(raa_tb),
           .rab(rab_tb),
           .c(c_tb),
           .we(we_tb),
           .rea(rea_tb),
           .reb(reb_tb),
           .s2(s2_tb));
           
           
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    integer i;
           
    initial begin
        go_tb = 0;
        clk_tb = 0;
        op_tb = 2'b00;
        
        for(i=0; i< 4; i = i+1)
        begin
            op_tb =i;
            go_tb = 1;
            //Init
            ticktock();
            //W1:
            ticktock();
            //W2:
            ticktock();
            //Wait:
            ticktock();
            //op:
            ticktock();
            //out:
            ticktock();
            //Init
            //ticktock();
            
        end     
    end
endmodule

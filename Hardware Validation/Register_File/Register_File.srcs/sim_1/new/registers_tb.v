`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 10:13:41 AM
// Design Name: 
// Module Name: registers_tb
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


module registers_tb;
    reg clk_tb;
    reg we1_tb;
    reg we2_tb;
    reg [4:0] ra1_tb;
    reg [4:0] ra2_tb;
    reg [4:0] wa1_tb;
    reg [4:0] wa2_tb;
    reg [31:0] wd1_tb;
    reg [31:0] wd2_tb;
    
    wire[31:0] rd1_tb;
    wire[31:0] rd2_tb;
    
    integer errors, i, j;
    

    regfile2 DUT(.clk(clk_tb), 
                 .we1(we1_tb),
                 .we2(we2_tb),
                 .ra1(ra1_tb),
                 .ra2(ra2_tb),
                 .wa1(wa1_tb),
                 .wa2(wa2_tb),
                 .rd1(rd1_tb),
                 .rd2(rd2_tb));
       
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    initial begin
        clk_tb = 0;
        we1_tb = 0;//      disable both write 
        we2_tb = 0;
         
        for (i=0;i<32; i= i+1)
        begin
            for (j=0; j<32;j=j+1)
            begin 
                we1_tb = 1-j;// enable write 1 when j =0
                we2_tb = j;//disable write 2 when j =0
                
                wa1_tb = i;
                wa2_tb = i;
                ra1_tb = wa1_tb;
                ra2_tb = wa1_tb;
                //initialize when we1 is enable
                wd1_tb = 31-i; //let the data run from 31-0
                wd2_tb = 31-i; //let the data run from 31-0
                ticktock();
                #5
                if( (we1_tb == 1) && (rd1_tb !=  wd1_tb))// check if the write data is the same as what is read
                begin
                    $display("WE1-> testbench failed at address: %d, write data is %d, but read data is %d",ra1_tb, wd1_tb,rd1_tb);
                    errors = errors +1; 
                end
                
                if( (we2_tb == 1) && (rd2_tb !=  wd2_tb))// check if the write data is the same as what is read
                begin
                    $display("WE2->testbench failed at address: %d, write data is %d, but read data is %d",ra1_tb, wd1_tb,rd1_tb);
                    errors = errors +1; 
                end
            end
        end 
        $display("test successful");
        $finish;
        
    end    
                 

endmodule

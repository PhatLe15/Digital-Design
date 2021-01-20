`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 05:19:03 PM
// Design Name: 
// Module Name: FIFO
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


module FIFO#(parameter bus_width = 4,
             parameter addr_width = 3,
             parameter fifo_depth= 8)// 2^addr_width = fifo_depthinputclk;// clock
            (input clk,
             input rst, // Asynchronous reset
             input wnr,// read (0) or write (1) control
             input enable,// enables the FIFO
             input [bus_width-1:0]  D_in,// Data input to the FIFO
             output reg [bus_width-1:0]  D_out,// Data output from the FIFO
             output reg full,// Asserted when the FIFOis full
             output reg empty// Asserted when the FIFOis empty
    );
    
    reg [addr_width:0] r_ptr, w_ptr;            // read and write pointers
                                                // Pay attention on their size!!!
    reg [bus_width-1:0] mem [fifo_depth-1:0];   // memoryused by the FIFO
    always@ (posedge clk, posedge rst)
    begin
        if(rst)
        begin
            r_ptr = 0; 
            w_ptr = 0; 
            D_out = 0; 
        end
        else if(!enable)
        begin
            D_out = 'bz; 
        end
        else if(!wnr && !empty) // startreading
        begin
            D_out = mem[r_ptr[addr_width-1:0]]; 
            r_ptr = r_ptr + 1; 
        end
        else if(wnr && !full) // start writing
        begin
            mem[w_ptr[addr_width-1:0]]= D_in; 
            w_ptr = w_ptr + 1; 
        end
        else  
        begin
            D_out = 'bz; 
        end
    end
    
    always@ (r_ptr, w_ptr)  // update the flags based on the read/write pointers
    begin
        if(r_ptr == w_ptr)
        begin
            empty = 1; 
            full = 0; 
        end
        else if(r_ptr[addr_width -1:0] == w_ptr[addr_width-1:0])
        begin
            empty = 0; 
            full = 1; 
        end
        else
        begin
            empty = 0; 
            full = 0; 
        end
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 07:23:53 PM
// Design Name: 
// Module Name: FIFO_FPGA
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


module FIFO_FPGA(input wire [3:0] D_in,
                 output wire [3:0] D_out,
                 input wire clk100MHz,
                 input wire rst,en, wnr,
                 output wire empty,full,
                 input wire clk_button
    );
    wire DONT_USE;
    wire clk_5KHz;
    wire debounced_clk;
    //wire [3:0] D_out;
    
    clk_gen clk(.clk100MHz(clk100MHz),
                .rst(rst),
                .clk_4sec(DONT_USE),
                .clk_5KHz(clk_5KHz));
                
    button_debouncer input_but(.clk(clk_5KHz),
                               .button(clk_button),
                               .debounced_button(debounced_clk));
    FIFO U(.clk(debounced_clk),
           .rst(rst),
           .wnr(wnr),
           .enable(en),
           .D_in(D_in),
           .D_out(D_out),
           .full(full),
           .empty(empty));
                
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 11:09:54 PM
// Design Name: 
// Module Name: integer_multiplier_fpga
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


module integer_multiplier_fpga(
        input wire [3:0] A,
        input wire [3:0] B,
        input wire rst,
        input wire en,
        input wire clock,
        input wire clk100mHz,
        output wire [3:0] LEDSEL,
        output wire [7:0] LEDOUT,
        output wire [3:0] A_out,B_out, 
        output wire rst_out, en_out
        
    );
    wire [7:0] P_out;
    wire DONT_USE;
    wire clk_5KHz;
    wire clock_button, debounced_clk_button;
    wire debounced_rst_button;
    wire [3:0] ones, tenths, hundredths;
    wire [7:0] LED2, LED1, LED0;
    supply1 [7:0] vcc;

    //set input LED
    assign A_out = A;
    assign B_out = B;
    assign rst_out = rst;
    assign en_out = en; 
    
    clk_gen     clk(.clk100MHz(clk100mHz), 
                .rst(rst), 
                .clk_4sec(DONT_USE), 
                .clk_5KHz(clk_5KHz));
    
    button_debouncer    clk_button(.clk(clk_5KHz),
                                   .button(clock),
                                   .debounced_button(debounced_clk_button)); 
    //button_debouncer    rst_button(.clk(clk_5KHz),
      //                             .button(rst),
        //                           .debounced_button(debounced_rst_button));
                
    unsigned_integer_multiplier     UIM(.A(A), 
                                        .B(B),
                                        .P(P_out), 
                                        .Clk(debounced_clk_button), 
                                        .Reset(rst),
                                        .En(en));
    
    digit_seperator DiSep       (.total(P_out), 
                                 .ones(ones), 
                                 .tenths(tenths),
                                 .hundredths(hundredths));   
    
    bcd_to_7seg     hundreds(.BCD(hundredths),
                             .s(LED2));
    bcd_to_7seg     tens(.BCD(tenths),
                             .s(LED1));
    bcd_to_7seg     one(.BCD(ones),
                             .s(LED0));
                             
    led_mux         LED(.clk(clk_5KHz), 
                        .rst(rst),
                        .LED3(vcc), 
                        .LED2(LED2), 
                        .LED1(LED1),
                        .LED0(LED0),
                        .LEDSEL(LEDSEL),
                        .LEDOUT(LEDOUT));
    
endmodule

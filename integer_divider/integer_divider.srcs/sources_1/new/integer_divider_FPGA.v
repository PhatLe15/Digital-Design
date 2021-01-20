`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 10:25:43 PM
// Design Name: 
// Module Name: integer_divider_FPGA
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


module integer_divider_FPGA(input wire go, rst, clkBut, clk100mHz,
                            input wire [3:0] x, y,  
                            output wire done, err,
                            output wire [3:0] LEDSEL,
                            output wire [7:0] LEDOUT);
                            
    wire DONT_USE;
    wire DONT_CARE, dont_use, dont_care;
    wire clk_5KHz; 
    wire debounced_clk;
    //wire debounced_rst_button;
    wire [3:0] r_tenths, r_ones, ones, tenths, quotient, remainder,r;
    wire [7:0] LED3, LED2, LED1, LED0;       
    
    //supply1 [7:0] vcc;
    
    clk_gen     clk(.clk100MHz(clk100mHz), 
                .rst(rst), 
                .clk_4sec(DONT_USE), 
                .clk_5KHz(clk_5KHz));
    
    button_debouncer    clk_button(.clk(clk_5KHz),
                                   .button(clkBut),
                                   .debounced_button(debounced_clk)); 
    
    integer_divider ID (.x(x),
                        .y(y),
                        .go(go),
                        .rst(rst),
                        .CLK(debounced_clk),
                        .quotient(quotient),
                        .remainder(remainder),
                        .Done(done),
                        .Err(err));   
                        
    binary2bcd U1       (.number(quotient), 
                                 .units(ones), 
                                 .tens(tenths),
                                 .hundreds(DONT_CARE));   
    binary2bcd U2       (.number(remainder), 
                         .units(r_ones), 
                         .tens(r_tenths),
                         .hundreds(dont_care));   
                         
    bcd_to_7seg     remain1 (.BCD(r_ones),
                        .s(LED2));
    bcd_to_7seg     remain10 (.BCD(r_tenths),
                        .s(LED3));
    bcd_to_7seg     tens(.BCD(tenths),
                             .s(LED1));
    bcd_to_7seg     one(.BCD(ones),
                             .s(LED0)); 
                             
    led_mux         LED(.clk(clk_5KHz), 
                        .rst(rst),
                        .LED3(LED3), 
                        .LED2(LED2), 
                        .LED1(LED1),
                        .LED0(LED0),
                        .LEDSEL(LEDSEL),
                        .LEDOUT(LEDOUT));                          
      
endmodule

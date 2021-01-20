`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2019 04:23:03 PM
// Design Name: 
// Module Name: FPGA
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


module FPGA(input wire go,
       input wire [1:0] op,
       input wire clk100mHz,
       input wire rst,
       input wire [3:0] in1,in2,
       input wire CLK_db,
       output wire done,
       output wire [3:0] LEDSEL,
       output wire [7:0] LEDOUT
    );
    
    wire [3:0] CS;
    wire [3:0] cal_out;
    wire DONT_USE;
    wire DONT_CARE, dont_use, dont_care;
    wire clk_5KHz;
    wire debounced_clk;
    wire debounced_rst_button;
    wire [3:0] ones, tenths, CS_bcd;
    wire [7:0] LED3, LED1, LED0;
    //wire done_LED;
    
    supply1 [7:0] vcc;
    
    clk_gen     clk(.clk100MHz(clk100mHz), 
                .rst(rst), 
                .clk_4sec(DONT_USE), 
                .clk_5KHz(clk_5KHz));
    
    button_debouncer    clk_button(.clk(clk_5KHz),
                                   .button(CLK_db),
                                   .debounced_button(debounced_clk)); 
    
    calculatorFPGA calculator (.go(go),
                               .op(op),
                               .clk(debounced_clk),
                               .in1(in1),
                               .in2(in2),
                               .CS(CS),
                               .done(done),
                               .out(cal_out));

    binary2bcd U1       (.number(cal_out), 
                                 .units(ones), 
                                 .tens(tenths),
                                 .hundreds(DONT_CARE));  
                     
    bcd_to_7seg     cs (.BCD(CS),
                             .s(LED3));
    bcd_to_7seg     tens(.BCD(tenths),
                             .s(LED1));
    bcd_to_7seg     one(.BCD(ones),
                             .s(LED0));
                             
    led_mux         LED(.clk(clk_5KHz), 
                        .rst(rst),
                        .LED3(LED3), 
                        .LED2(vcc), 
                        .LED1(LED1),
                        .LED0(LED0),
                        .LEDSEL(LEDSEL),
                        .LEDOUT(LEDOUT));
endmodule

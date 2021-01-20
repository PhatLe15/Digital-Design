`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2019 10:23:02 PM
// Design Name: 
// Module Name: carry_look_ahead_fpga
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


module carry_look_ahead_fpga(
                input [3:0] A,   //Declare 4-bit input signal 
                input [3:0] B,   //Declare 4-bit input signal
                input clk100MHz, //Declare clock with f=100 Mhz 
                input rst, 
                input c_in,      
                        output wire [3:0] A_LED,
                output wire [3:0] B_LED,
                output wire c_o_led, 
                output wire c_i_led, 
                output [7:0] LEDOUT,  
                output [3:0] LEDSEL);
 wire c_out;
supply1[7:0] vcc;
assign A_LED=A;
assign B_LED=B;
assign c_i_led = c_in;
assign c_o_led = c_out;
wire s0, s1, s2, s3, s4, s5, s6, s7;
wire [3:0] sum;  //this hold sum
wire [7:0] led1,led2,led4;

wire DONT_USE, clk_5KHz;
wire [3:0] hundreds;
 wire [3:0] tens;
 wire [3:0] units;  
assign s7 = 1'b1;
  
  // instantiation and connect the sub modules
 clk_gen clk1(.clk100MHz(clk100MHz),
                .rst(rst),
                .clk_4sec(DONT_USE),
                .clk_5KHz(clk_5KHz)
                );
                
CLA_adder_top u0(A,B,sum,c_out,c_in);
 bcd_to_7seg bcd2(.BCD(tens[3:0]),.s(led2));
 bcd_to_7seg bcd3(.BCD(units[3:0]),.s(led1));
  bcd_to_7seg bcd1 (c_in,led4);
led_mux u2 (
                .clk   (clk_5KHz),
                .rst   (rst),
                .LED3  (led4),
                .LED2  (vcc),
                .LED1  (led2),
                .LED0  (led1),
                .LEDSEL    (LEDSEL),
                .LEDOUT    (LEDOUT)
                  ); 
   
endmodule

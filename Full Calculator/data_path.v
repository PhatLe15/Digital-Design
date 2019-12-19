`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2019 01:12:11 PM
// Design Name: 
// Module Name: data_path
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


module data_path(input [3:0] x,
                 input x_LD, x_SL,x_RightIn,
                 input [3:0] y,
                 input y_LD,
                 input r_LD, r_SL, r_SR,
                 input s1,s2,s3,
                 input [3:0] n,
                 input cnt_LD, cnt_en,
                 input rst,clk,
                 output [3:0] Q,
                 output [3:0] R,
                 output R_lt_Y, cnt_out, yZero
                 
    );
    
    wire [3:0] x_out, y_out, r, cnt;
    wire [4:0] r_out;
    wire [3:0] r_y;

    shift_register #4 diviend (.D(x),
                               .LeftIn(1'b0),
                               .RightIn(x_RightIn),
                               .LD(x_LD),
                               .SL(x_SL),
                               .SR(1'b0),
                               .RST(rst),
                               .CLK(clk),
                               .Q(x_out));
    
    shift_register #4 divisor (.D(y),
                               .LeftIn(1'b0),
                               .RightIn(1'b0),
                               .LD(y_LD),
                               .SL(1'b0),
                               .SR(1'b0),
                               .RST(rst),
                               .CLK(clk),
                               .Q(y_out));
                               
    shift_register #5 remainder (.D(r),
                               .LeftIn(1'b0),
                               .RightIn(x_out[3]),
                               .LD(r_LD),
                               .SL(r_SL),
                               .SR(r_SR),
                               .RST(rst),
                               .CLK(clk),
                               .Q(r_out));
    comp RltY (.a(r_out[3:0]),
             .b(y_out),
             .lt(R_lt_Y));
             
    sub RminY (.a(r_out[3:0]),
               .b(y_out),
               .c(r_y));
          
    ud_counter #4 count (.D(n),
                   .LD(cnt_LD),
                   .UD(1'b0),//countdown
                   .CE(cnt_en),
                   .RST(rst),
                   .CLK(clk),
                   .Q(cnt));
                
    nor1 cnt_NOR (.in(cnt),
              .out(cnt_out));
              
    nor1 y_NOR (.in(y_out),
              .out(yZero));
    
    mux2 #4 M1 (.in0(4'b0000),
                .in1(r_y),
                .sel(s1),
                .out(r));  
               
    mux2 #4 Remain (.in0(4'b0000),
                    .in1(r_out[3:0]),
                    .sel(s2),
                    .out(R));   
    
    mux2 #4 quotient (.in0(4'b0000),
                      .in1(x_out),
                      .sel(s3),
                      .out(Q));       
                                                                         
endmodule


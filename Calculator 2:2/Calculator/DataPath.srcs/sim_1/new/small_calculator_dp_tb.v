`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2019 08:02:48 AM
// Design Name: 
// Module Name: small_calculator_dp_tb
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


module small_calculator_dp_tb;
        reg     clk_tb;
        reg [3:0] in1_tb;
        reg [3:0] in2_tb;
        reg [1:0] s1_tb;
        reg [1:0] wa_tb;
        reg [1:0] raa_tb;
        reg [1:0] rab_tb;
        reg [1:0] c_tb;
        reg       we_tb;
        reg       rea_tb;
        reg       reb_tb;
        reg       s2_tb;
        wire [3:0] out_tb;

small_calculator_dp DUT(.clk(clk_tb),
                        .in1(in1_tb),
                        .in2(in2_tb),
                        .s1(s1_tb),
                        .wa(wa_tb),
                        .raa(raa_tb),
                        .rab(rab_tb),
                        .c(c_tb),
                        .we(we_tb),
                        .rea(rea_tb),
                        .reb(reb_tb),
                        .s2(s2_tb),
                        .out(out_tb));
                        
 task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
 endtask
    
 integer i,k;
    
initial begin
    //initialization
    clk_tb = 0;
    s1_tb = 0;
    s2_tb = 0;
    we_tb = 0;
    rea_tb = 0;
    reb_tb = 0;
    ticktock();
    ticktock();
    
    //go through all possible inputs
    for(i=0;i<4;i=i+1)
    begin
        in1_tb = $random;
        in2_tb = $random;
        we_tb = 1;
        rea_tb = 1;
        reb_tb = 1;//enable all read and write
        s2_tb = 0;// let not output anything first
            //write in1
            s1_tb = 2'b01;
            wa_tb = 2'b01;//write to the address
            ticktock();
            //write in2
            s1_tb = 2'b10; 
            wa_tb = 2'b10;//write to the second address
            ticktock();
            
            
            for(k = 0; k<4; k = k+1)
            begin
                s2_tb = 1;
                //read number to ALU
                //s2_tb = 0;// since we dont want to output it yet
                raa_tb = 2'b01;
                rab_tb = 2'b10;
                c_tb = k;// use +/-/&/^
                //go back to Mux1 and write the result to the third location
                s1_tb = 2'b11;//select the result
                wa_tb = 2'b11;//write the result to register3
                ticktock();
                //read the result at the same location
                raa_tb = 2'b11;
                rab_tb = 2'b11;
                c_tb = 2'b10;// use & to output the right number
                ticktock();
            end
                        
        //end
    end   
 end
    

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2019 01:55:19 PM
// Design Name: 
// Module Name: tb_encoder
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


module tb_encoder;
        reg  [7:0] in_tb;        
        wire         valid_if, valid_case, valid_for;        
        wire [2:0] out_if, out_case, out_for;        
        integer n;             
        enc_if               DUT_IF   (in_tb, valid_if, out_if);         
        enc_case         DUT_CASE (in_tb, valid_case, out_case);        
        enc_for  #(8,3) DUT_FOR  (in_tb, valid_for, out_for);             
        initial begin         
        for (n = 0; n < 256; n = n + 1)
        begin              
            in_tb = n; #5;                          
            if (!in_tb[out_if])       $display ("Encoder If Failed");                          
            if (!in_tb[out_case])     $display ("Encoder Case Failed");                         
            if (!in_tb[out_for])      $display ("Encoder For Failed");                         
            if (in_tb && !valid_if)   $display ("Valid If Failed");                          
            if (in_tb && !valid_case) $display ("Valid Case Failed");                        
            if (in_tb && !valid_for)  $display ("Valid For Failed");         
            end 
            $display ("Simulation Finished");         
            $finish;    
         end
endmodule    

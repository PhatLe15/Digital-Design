`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 08:20:15 PM
// Design Name: 
// Module Name: CU
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


module CU(input Go,
          input clk,
          input rst,
          input yZero,    //if y =0 output Err signal
          input cnt, //cnt_out
          input R_lt_Y,
          //output reg [3:0] x,y,
          output reg  x_RightIn, x_LD, x_SL, y_LD, r_LD, r_SL, r_SR,
          output reg s1, s2, s3,
          output reg [3:0] n,
          output reg cnt_LD, cnt_en,
          output reg Done, Err);
          
    parameter S0 = 4'b0000,
              S1 = 4'b0001,
              S2 = 4'b0010,
              S3 = 4'b0011,
              S4 = 4'b0100,
              S5 = 4'b0101,
              S6 = 4'b0110,
              S7 = 4'b0111, 
              S8 = 4'b1000;  
           
     reg [3:0] CS, NS;
     
     always@(Go, CS, R_lt_Y, cnt, yZero)
     begin
        case(CS)
            S0:
            begin
               if(!Go) NS = S0;
               else NS = S1;
            end
            
            S1:
            begin
               NS = S2;
            end
            
            S2:
            begin
               if(yZero) NS = S8;
               else NS = S3;
            end
            
            S8:
            begin
               NS = S0;
            end
            
            
            S3:
            begin
               if(R_lt_Y)
               begin
                    NS = S5;
               end
               else 
               begin
                    NS = S4;
               end
            end
            
            S5:
            begin
               if(cnt) NS = S6;
               else NS = S3;
            end
            
            S4:
            begin
               if(cnt) NS = S6;
               else NS = S3;
            end
            
            S6:
            begin
               NS = S7;
            end
            
            S7:
            begin
               NS = S0;
            end
        endcase
     end
     
    always @ (posedge clk, posedge rst)
        if(rst) CS <= S0;
        else CS <=NS;
        
    always @(CS, R_lt_Y)
    begin
        case(CS)
        S0:
        begin
            x_LD =0;
            x_SL=0;
            x_RightIn= 0;
            y_LD=0;
            r_LD=0; 
            r_SL=0;
            r_SR=0;
            s1=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=0;   
            Done = 0;
            Err = 0; 
        end
        
        S1:
        begin
            x_LD =1;
            x_SL=0;
            x_RightIn= 0;
            y_LD=1;
            r_LD=1; // R=0
            r_SL=0;
            r_SR=0;
            s1=0;
            s2=0;
            s3=0;
            n=4'b0100;
            cnt_LD =1;
            cnt_en=1;    
            Done = 0;
            Err = 0;
        end
        
        S2:
        begin
            x_LD =0;
            x_SL=1;
            x_RightIn= 0;
            y_LD=0;
            r_LD=0; 
            r_SL=1;
            r_SR=0;
            s1=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=0;   
            Done = 0;
            Err = 0;
        end
        
        S3:
        begin
            x_LD =0;
            x_SL=0;
            x_RightIn= 0;
            y_LD=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=1;
            Done = 0;
            Err = 0;
            if(!R_lt_Y)// doing R-Y operation
            begin
                r_LD=1; 
                r_SL=0;
                r_SR=0;
                s1=1;
            end
            else 
            begin
                r_LD=0; 
                r_SL=0;
                r_SR=0;
                s1=0;
            end 
        end
        
        S4:
        begin
            x_LD =0;
            x_SL=1;
            x_RightIn= 1;
            y_LD=0;
            r_LD=0; 
            r_SL=1;
            r_SR=0;
            s1=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=0;    
            Done = 0;
            Err = 0;
        end
        
        S5:
        begin
            x_LD =0;
            x_SL=1;
            x_RightIn= 0;
            y_LD=0;
            r_LD=0; 
            r_SL=1;
            r_SR=0;
            s1=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=0;   
            Done = 0; 
            Err = 0;
        end
        
        S6:
        begin
            x_LD =0;
            x_SL=0;
            x_RightIn= 0;
            y_LD=0;
            r_LD=0; 
            r_SL=0;
            r_SR=1;
            s1=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=0; 
            Done = 0;  
            Err = 0; 
        end
        
        S7:
        begin
            x_LD =0;
            x_SL=0;
            x_RightIn= 0;
            y_LD=0;
            r_LD=0; 
            r_SL=0;
            r_SR=0;
            s1=0;
            s2=1;
            s3=1;
            n=0;
            cnt_LD =0;
            cnt_en=0;
            Done = 1;   
            Err = 0; 
        end
        
        S8://error state
        begin
            x_LD =0;
            x_SL=0;
            x_RightIn= 0;
            y_LD=0;
            r_LD=0; 
            r_SL=0;
            r_SR=0;
            s1=0;
            s2=0;
            s3=0;
            n=0;
            cnt_LD =0;
            cnt_en=0;
            Done = 0;
            Err = 1;
        end
        endcase
    
    end    
endmodule

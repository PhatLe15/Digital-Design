`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2019 01:51:04 PM
// Design Name: 
// Module Name: Top_CU
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


module Top_CU(input Go,
              input [2:0] F,
              input clk, rst,
              input Done_Calc,
              input Done_DIV,
              output reg Sel_square,
              output reg En_F,
              output reg En_X,
              output reg En_Y,
              output reg Go_Calc,
              output reg Go_DIV,
              output reg [1:0] Op_Calc,
              output reg Sel_H,
              output reg [1:0] Sel_L,
              output reg En_Out_H,
              output reg En_Out_L,
              output reg Done,
              output reg [3:0] CS,
              input Err
    );
    
    parameter S0 = 4'b0000,
              S1 = 4'b0001,
              S2 = 4'b0010,
              S3 = 4'b0011,
              S4 = 4'b0100,
              S5 = 4'b0101,
              S6 = 4'b0110,
              S7 = 4'b0111, 
              S8 = 4'b1000,
              S9 = 4'b1001,
              S10 = 4'b1010;
              
       reg [3:0] NS;
       
       always@(CS, Go, F, Done_Calc, Done_DIV, Err)
       begin
            case(CS)
                S0:
                begin
                    NS = S1;
                    if(!Go) NS = S0;
                    else NS = S1;
                end
                
                S1:
                begin
                    NS = S2;
                end
                
                S2:
                begin
                    if (F == 3'b000) NS = S3;//add
                    else if (F == 3'b001) NS = S3;//sub
                    else if (F == 3'b010) NS = S4;//mul
                    else if (F == 3'b011) NS = S5;//div
                    else if (F == 3'b100) NS = S3;//+1
                    else if (F == 3'b101) NS = S3;//-1
                    else if (F == 3'b110) NS = S4;//square
                end
                
                S3://small calc state
                begin
                    NS = S6;
                    
                end
                
                S4://mult state
                begin
                    NS = S10;
                end
                
                S5://DIV state
                begin
                    NS = S7;
                end
                
                S6://small calc clock state
                begin
                    if (!Done_Calc) NS = S6;// loop back to this state if Done_Calc is not on
                    else NS = S9; //If not, move to done state
                end
                
                S10:
                begin
                    NS = S8;
                end
                
                S8:
                begin
                    NS = S9;//done state
                end
                
                S7://DIV state
                begin
                    if(Err) NS = S0;
                    else begin
                        if (!Done_DIV) NS = S7;
                        else NS = S9; //done state
                    end
                end   
                
                S9:
                begin
                    NS = S0;
                end 
                
                default:
                begin
                    NS = S0;
                end      
            endcase           
       end
       
       always@(posedge clk, posedge rst)
       begin
            if(rst) CS = S0;
            else CS <= NS;
       end
      
        
        
        always@(CS, F, Done_Calc, Done_DIV)
        begin
            case(CS)
            S0://idle
            begin
                En_F = 0;
                En_X = 0;
                En_Y = 0;
                Go_Calc = 0;
                Go_DIV = 0;
                //Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0;    
                Sel_square = 0;  
                
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
                
                 
            end
            
            S1://load state
            begin
                En_F = 1;// load F
                En_X = 1;// load X
                En_Y = 1;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                //Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0;   
                Sel_square = 0;   
                
                
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
                 
            end
            
            S2://wait state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                //Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0;     
                Sel_square = 0; 
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
                
            end
            
            S3://small Calc state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 1;//enable small calc module
                Go_DIV = 0;
                //Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0; 
                Sel_square = 0;
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end        
                
                
                        
            end
            
            S6://load output state when done . If not, loop again in this state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                Op_Calc = 2'b00;
                Sel_H = 0;
                //Sel_L = 2'b00;
                En_Out_H = 0;//keep the output 0 for the small calc state
                //En_out_L = 0;
                Sel_square = 0;
                Done = 0;  
                if(!Done_Calc)
                begin
                    Sel_L = 2'b00; 
                    En_Out_L = 0;   
                end
                else
                begin
                    Sel_L = 2'b01;
                    En_Out_L = 1;
                end
                
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
                
                
            end
            
            S4://wait state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0; 
                if( F == 3'b010)// Mult
                begin
                    Sel_square = 0;// select Y
                end
                else if( F== 3'b110)//square
                begin
                    Sel_square = 1;// select X
                end
                
                
                
                
                
            end
            
            S10://wait state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                //Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0; 
                Sel_square = 0;
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
                
                
                
            end
            
            S8://load MUL result state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                Op_Calc = 2'b00;//dont care
                Sel_H = 0;//selec P high
                Sel_L = 2'b10;//selec P Low
                En_Out_H = 1;
                En_Out_L = 1;
                Done = 0; 
                Sel_square = 0;
                
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
            end
            
            S5://load DIV result state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 1;
                Op_Calc = 2'b00;//dont care
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0; 
                Sel_square = 0;
                
            end
            
            S7://wait state
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                Op_Calc = 2'b00;
                //Sel_H = 0;
                //Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0;  
                Sel_square = 0;
                if(!Done_DIV)
                begin
                    Sel_L = 2'b00; 
                    Sel_H = 0; 
                    En_Out_H = 0;
                    En_Out_L = 0; 
                end
                else //if Done_Div is on  output the result
                begin
                    Sel_L = 2'b11;//pick quotient
                    Sel_H = 1;//pick remainder
                    En_Out_H = 1;//output the quotient
                    En_Out_L = 1;//output the remainder
                end 
            end
            
            S9:
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 1; 
                Sel_square = 0;
            end
            
            default:// just like wait state /do nothing
            begin
                En_F = 0;// load F
                En_X = 0;// load X
                En_Y = 0;// load Y
                Go_Calc = 0;
                Go_DIV = 0;
                Op_Calc = 2'b00;
                Sel_H = 0;
                Sel_L = 2'b00;
                En_Out_H = 0;
                En_Out_L = 0;
                Done = 0; 
                Sel_square = 0;
                if(F == 3'b000)
                begin
                    Op_Calc = 2'b00;//add                   
                end 
                
                else if(F == 3'b001)
                begin
                    Op_Calc = 2'b01;//sub                   
                end
                
                else if(F == 3'b100)
                begin
                    Op_Calc = 2'b01;//+1                 
                end  
                
                else if(F == 3'b101)
                begin
                    Op_Calc = 2'b01;//-1                 
                end
            end
            
            endcase
        end
        
endmodule

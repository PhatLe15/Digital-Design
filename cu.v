`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2019 02:03:20 PM
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


module cu(input go,
          input clk,
          input [1:0] op,
          output reg [3:0] CS,
          output reg done,
          output reg [1:0] s1, wa, c, raa, rab,
          output reg we, rea, reb, s2
    );
    
    parameter Init = 4'b0000,// since the CS is 4 bit
              W1 = 4'b0001,
              W2 = 4'b0010,
              Wait = 4'b0011,
              addOP = 4'b0100,
              minOP = 4'b0101,
              andOP = 4'b0110,
              xorOP = 4'b0111,
              out = 4'b1000;
   
   reg [3:0] NS; //the next state
   
   always@(go,CS,op)
   begin
        case(CS)
            Init: 
            begin
                if(!go) NS = Init; 
                else NS = W1;
            end
            
            W1:
            begin
                NS = W2;
            end
            
            W2:
            begin
               NS = Wait; 
            end
            
            Wait:
            begin
                if(op == 2'b00) NS = addOP;
                else if(op == 2'b01) NS = minOP;
                else if(op == 2'b10) NS = andOP;
                else NS = xorOP;                 
            end     
            
           
         // transition for each operation
            addOP:
            begin
                NS = out; 
            end
            
            minOP:
            begin
                NS = out; 
            end
            
            andOP:
            begin
                NS = out; 
            end
            
            xorOP:
            begin
                NS = out; 
            end
            
        //output state
            out:
            begin
                NS = Init; 
            end     
            
            default:
            begin
                NS = Init;
            end           
        endcase    
   end           
   
   //sequential
   always@(posedge clk)
        CS <= NS;   
  
  always@(CS)
  begin
    case(CS)
    Init:
    begin
        s1 = 2'b00;
        s2 = 0;
        we = 0;
        rea = 0;
        reb = 0;
        wa = 2'b00;
        raa = 2'b00;
        rab = 2'b00;
        c = 2'b00;
        done = 0;
    end
    
    W1:
    begin
        s1 = 2'b01;
        s2 = 0;
        we = 1;
        rea = 0;
        reb = 0;
        wa = 2'b01;
        raa = 2'b00;
        rab = 2'b00;
        c = 2'b00;
        done = 0;
    end
    
    W2:
    begin
        s1 = 2'b10;
        s2 = 0;
        we = 1;
        rea = 0;
        reb = 0;
        wa = 2'b10;
        raa = 2'b00;
        rab = 2'b00;
        c = 2'b00;
        done = 0;
    end
    
    
    Wait:
    begin
        s1 = 2'b00;
        s2 = 0;
        we = 0;
        rea = 0;
        reb = 0;
        wa = 2'b00;
        raa = 2'b00;
        rab = 2'b00;
        c = 2'b00;
        done = 0;
    end
    
    addOP:
    begin
        s1 = 2'b11;
        s2 = 0;
        we = 1;
        rea = 1;
        reb = 1;
        wa = 2'b11;
        raa = 2'b01;
        rab = 2'b10;
        c = 2'b00;
        done = 0;
    end
    
    minOP:
    begin
        s1 = 2'b11;
        s2 = 0;
        we = 1;
        rea = 1;
        reb = 1;
        wa = 2'b11;
        raa = 2'b01;
        rab = 2'b10;
        c = 2'b01;
        done = 0;
    end
    
    andOP:
    begin
        s1 = 2'b11;
        s2 = 0;
        we = 1;
        rea = 1;
        reb = 1;
        wa = 2'b11;
        raa = 2'b01;
        rab = 2'b10;
        c = 2'b10;
        done = 0;
    end
    
    xorOP:
    begin
        s1 = 2'b11;
        s2 = 0;
        we = 1;
        rea = 1;
        reb = 1;
        wa = 2'b11;
        raa = 2'b01;
        rab = 2'b10;
        c = 2'b11;
        done = 0;
    end
    
    out:
    begin
        s1 = 2'b00;
        s2 = 1;
        we = 0;
        rea = 1;
        reb = 1;
        wa = 2'b00;
        raa = 2'b11;
        rab = 2'b11;
        c = 2'b10;
        done = 1;
    end
    
    default:
    begin
        s1 = 2'b00;
        s2 = 0;
        we = 0;
        rea = 0;
        reb = 0;
        wa = 2'b00;
        raa = 2'b00;
        rab = 2'b00;
        c = 2'b00;
        done = 0;
    end
    
    endcase
  end      
           
endmodule

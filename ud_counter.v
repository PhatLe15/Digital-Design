`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 01:59:08 AM
// Design Name: 
// Module Name: ud_counter
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


module ud_counter #(parameter Data_width = 4)
                (input LD, UD, CE, CLK, RST,
                input [Data_width-1:0] D,
                output reg [Data_width-1:0]Q
    );
    
    always @(posedge CLK, posedge RST)
    begin 
        if(RST) Q <= 0;
        else if(CE)
            begin 
                if (LD) Q <= D;        
                else begin
                    case(UD)
                         0: Q <= Q-4'b0001;
                         1: Q <= Q+4'b0001;
                    endcase
                end
             end
        else Q<=Q;
   end
        
            
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 01:57:22 AM
// Design Name: 
// Module Name: shift_register
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


module shift_register #(parameter Data_width = 5)
                (input LD, SL, SR, CLK, RST, LeftIn, RightIn,
                input [Data_width-1:0] D,
                output reg [Data_width-1:0]Q
    );
    
    always @(posedge CLK, posedge RST)
    begin 
        if(RST) Q <= 0;
        else if(LD)
        begin
            Q <= D;
        end
        else if(SR)
        begin
            Q <= {LeftIn,Q[Data_width-1:1]};
        end
        else if(SL)
        begin
            Q <= {Q[Data_width-2:0],RightIn};
        end
        else Q<=Q;
    end
            
endmodule


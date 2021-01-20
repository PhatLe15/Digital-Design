`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2019 09:09:52 AM
// Design Name: 
// Module Name: digit_seperator
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


module digit_seperator( input [7:0] total, output reg [3:0] ones, tenths, hundredths
    );
    integer carry;
    always @(*)
        begin
        // to find the hundredths
            if((total >199) && (total <300))
            begin
                hundredths = 2;
                carry = total-200;
            end
            else if((total >99) && (total <200))
            begin
                hundredths = 1;
                carry = total-100;
            end
            else if(total <100)
            begin
                hundredths = 0;
                carry = total;
            end            
            
            //to find the tenths
            if((carry >89) && (carry <100))
            begin
                tenths = 9;
                ones = carry-90;
            end
            else if((carry >79) && (carry <90))
            begin
                tenths = 8;
                ones = carry-80;
            end
            else if((carry >69) && (carry <80))
            begin
                tenths = 7;
                ones = carry-70;
            end
            else if((carry >59) && (carry <70))
            begin
                tenths = 6;
                ones = carry-60;
            end            
            else if((carry >49) && (carry <60))
            begin
                tenths = 5;
                ones = carry-50;
            end            
            else if((carry >39) && (carry <50))
            begin
                tenths = 4;
                ones = carry-40;
            end            
            else if((carry >29) && (carry <40))
            begin
                tenths = 3;
                ones = carry-30;
            end            
            else if((carry >19) && (carry <30))
            begin
                tenths = 2;
                ones = carry-20;
            end            
            else if((carry >9) && (carry <20))
            begin
                tenths = 1;
                ones = carry-10;
            end            
            else
            begin
                tenths = 0;
                ones = carry;
            end
            //to find the ones
                        
        end
endmodule

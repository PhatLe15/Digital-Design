module enc_case 
(input [7:0] A, output reg valid, reg[2:0] Y);
    always @ (A) 
begin 
    valid = 1;
    casez (A)             
        8'b1???_????: Y = 7;            
        8'b01??_????: Y = 6;            
        8'b001?_????: Y = 5;            
        8'b0001_????: Y = 4;            
        8'b0000_1???: Y = 3;            
        8'b0000_01??: Y = 2;            
        8'b0000_001?: Y = 1;            
        8'b0000_0001: Y = 0;
        default: begin                 
            valid = 0;
            Y = 3'bxxx;
        end 
    endcase     
    end 
 endmodule 
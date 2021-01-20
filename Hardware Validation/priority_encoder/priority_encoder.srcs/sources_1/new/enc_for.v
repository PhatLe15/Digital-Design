module enc_for #(parameter iwidth = 8, owidth = 3)
(input [iwidth-1:0] A, output reg valid, reg[owidth-1:0] Y);
    integer n; 
    always @ (A) 
    begin 
        valid = 0;
        Y= 3'b000;
        for (n = 0; n < iwidth; n = n + 1)
        begin 
            if (A[n]) 
            begin                 
                valid = 1;
                Y = n;
            end 
        end     
    end 
endmodule
module tb_shift_rotator;
    reg [2:0] tb_control;
    reg [3:0] tb_x;
    wire [3:0] tb_y;
    reg [3:0] expected;
    
    shift_rotator DUT(.control(tb_control),.x(tb_x),.y(tb_y));
    integer i,j;
    initial
    begin
    
    for(i=0;i<8;i=i+1)//control bit
    begin
        for(j=0;j<16;j=j+1)//4 bit input
        begin
            tb_control=i;
            tb_x=j;
          case (tb_control)
                3'b000: expected = tb_x;
                3'b001: expected = {1'b0, tb_x[3],tb_x[2],tb_x[1]};
                3'b010: expected = {2'b00, tb_x[3],tb_x[2]};
                3'b011: expected = {3'b000, tb_x[3]};
                3'b100: expected = 4'b0000;
                3'b101: expected = {tb_x[0], tb_x[3],tb_x[2],tb_x[1]};
                3'b110: expected =  {tb_x[1], tb_x[0], tb_x[3], tb_x[2]};
                3'b111: expected =  {tb_x[2], tb_x[1], tb_x[0], tb_x[3]};
            default: expected = 4'b0000;
          endcase
            
                      // Wait for inputs to propagate to output
                      #1;
            
                      // Check if output matches expected result
       if(tb_y != expected)
           begin
            // Mismatch, print error message
                $display("Error, output is %d, expected %d", tb_y, expected);
                          // Stop simulation on the first error we found
                $stop;
           end
            
       end // End Assign loop x counts to inputs
            
    end   // End Assign loop control counts to inputs
            
              // No errors, print success message
              $display("No Errors. Test was successful.");
              $stop;
        end
endmodule

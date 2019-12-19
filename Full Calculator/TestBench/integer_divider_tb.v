`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 03:28:55 PM
// Design Name: 
// Module Name: integer_divider_tb
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


module integer_divider_tb;
    reg [3:0] x_tb ,y_tb;
    reg go_tb, rst_tb, clk_tb;
    wire Done_tb, Err_tb;
    wire [3:0] quotient_tb, remainder_tb;
    
    integer_divider DUT(.x(x_tb),
                        .y(y_tb),
                        .go(go_tb),
                        .rst(rst_tb),
                        .CLK(clk_tb),
                        .Done(Done_tb),
                        .Err(Err_tb),
                        .quotient(quotient_tb),
                        .remainder(remainder_tb));
                        
    integer errors;
    reg [3:0] quotient_expected, remainder_expected;         
    
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    initial begin
        
        errors = 0;
        quotient_expected = 0;
        remainder_expected = 0;
        
        go_tb =0;
        rst_tb = 1;        
        clk_tb = 0;
        ticktock();
        rst_tb = 0;
        
        ticktock();//go to state 0   
        ticktock();//check if it is go to state 1 or not
        
        go_tb = 1;
        x_tb = 11;
        y_tb = 3;
        quotient_expected = x_tb/y_tb;
        remainder_expected = x_tb%y_tb;
        ticktock();//go to s1
        ticktock();//go to s2
        #5 clk_tb = ~clk_tb;
        #1;
        if(y_tb ==0 && Err_tb == 0) //if y is 0 but the error signal is not on
        begin
            $display("Error signal failed");
            errors = errors +1;
        end
        ticktock();//go to s3
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();//s6
        
        
        ticktock();//s7
        
        //clk_tb = ~clk_tb;
        if(quotient_tb != quotient_expected && remainder_tb !=remainder_expected)
        begin 
            $display("The expected result of %d / %d = %d r = %d, but the testbench result is %d r = ",x_tb,y_tb, quotient_tb, remainder_tb, quotient_expected, remainder_expected);
            errors = errors + 1;
        end
        
        go_tb = 0;
        ticktock();//go to s0
        
        ticktock();//go to s1
        ticktock();//go to s2
        
        
        
         go_tb = 1;
        x_tb = 11;
        y_tb = 0;
        quotient_expected = x_tb/y_tb;
        remainder_expected = x_tb%y_tb;
        ticktock();//go to s1
        ticktock();//go to s2
        #5 clk_tb = ~clk_tb;
        #1;
        if(y_tb ==0 && Err_tb == 0) //if y is 0 but the error signal is not on
        begin
            $display("Error signal failed");
            errors = errors +1;
        end
        ticktock();//go to s3
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();
        ticktock();//s6
        
        
        ticktock();//s7
        
        //clk_tb = ~clk_tb;
        if(quotient_tb != quotient_expected && remainder_tb !=remainder_expected)
        begin 
            $display("The expected result of %d / %d = %d r = %d, but the testbench result is %d r = ",x_tb,y_tb, quotient_tb, remainder_tb, quotient_expected, remainder_expected);
            errors = errors + 1;
        end
        
        go_tb = 0;
        ticktock();//go to s0
        
        ticktock();//go to s1
        ticktock();//go to s2
        
        if(errors == 0)
            begin
                $display("No Errors. Test was successful with %d errors.", errors);
            end
            else
            begin
                $display("Test was unsuccessful with %d errors.",errors);
            end  
            
        $stop;
        
        
         
        
    end
endmodule

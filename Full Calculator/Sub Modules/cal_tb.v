`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 06:12:35 PM
// Design Name: 
// Module Name: cal_tb
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


module cal_tb;
    reg [3:0] in1_tb;
    reg [3:0] in2_tb;
    reg clk_tb;
    reg go_tb;
    reg [1:0] op_tb;
    wire done_tb;
    wire [3:0] cs_tb;
    wire [3:0] out_tb;
    reg  [3:0] out_expected;
    
    calculatorFPGA DUT (.go(go_tb),
                    .op(op_tb),
                    .clk(clk_tb),
                    .in1(in1_tb),
                    .in2(in2_tb),
                    .CS(cs_tb),
                    .done(done_tb),
                    .out(out_tb));
     
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    integer i,j, errors;
           
    initial begin
        //out_expected = 0;
        errors = 0;
        go_tb = 0;
        clk_tb = 1;
        op_tb = 2'b00;
        
        for(j=0; j< 4; j = j+1)
        begin
            out_expected = 0;
            in1_tb = $random;
            in2_tb = $random;
            //ticktock();
            
            for(i=0;i<4;i = i+1)
            begin
                //Init:0
                op_tb =i;
                go_tb = 1;
                //W1:1
                ticktock();
                //W2:2
                ticktock();
                //Wait:3
                ticktock();
                //op:
                ticktock();
                //out:8
                ticktock();
    
                case(op_tb)
                    2'b00:
                    begin
                        //#5;
                        out_expected = in1_tb + in2_tb;
                        #5;
                        if(out_tb != out_expected)
                        begin
                            $display("Addition operation failed at in1 = %d in2 = %d, but the output is %d",in1_tb, in2_tb, out_tb);
                            errors = errors +1;
                        end
                    end
                    
                    2'b01:
                    begin
                        out_expected = in1_tb - in2_tb;
                        #5;
                        if(out_tb != out_expected)
                        begin
                            $display("Subtraction operation failed simulation failed at in1 = %d in2 = %d, but the output is %d",in1_tb, in2_tb, out_tb);
                            errors = errors +1;
                        end
                    end
                    
                    2'b10:
                    begin
                        out_expected = in1_tb & in2_tb;
                        #5;
                        if(out_tb != out_expected)
                        begin
                            $display("AND operation failed at in1 = %d in2 = %d, but the output is %d",in1_tb, in2_tb, out_tb);
                            errors = errors +1;
                        end
                    end
                    
                    2'b11:
                    begin
                        out_expected = in1_tb ^ in2_tb;
                        #5;
                        if(out_tb != out_expected)
                        begin
                            $display("XOR operation failed at in1 = %d in2 = %d, but the output is %d",in1_tb, in2_tb, out_tb);
                            errors = errors +1;
                        end 
                    end
                endcase
                
                if(!done_tb)
                begin
                    $display("failed to done the operation");
                end
                //go back to init state
                    ticktock();
                    out_expected = 0;
            end
            
            
        end 
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


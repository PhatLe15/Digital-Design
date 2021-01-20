`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2019 03:02:56 AM
// Design Name: 
// Module Name: CU_tb
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


module CU_tb;
    reg Go_tb;
    reg clk_tb;
    reg rst_tb;
    reg yZero_tb;
    reg cnt_tb;
    reg R_lt_Y_tb;
    wire x_RightIn_tb, x_LD_tb, x_SL_tb, y_LD_tb, r_LD_tb, r_SL_tb, r_SR_tb;
    wire s1_tb,s2_tb,s3_tb;
    wire [3:0] n_tb;
    wire cnt_LD_tb, cnt_en_tb;
    wire Done_tb, Err_tb;
    
    CU DUT (.Go(Go_tb),
            .clk(clk_tb),
            .rst(rst_tb),
            .yZero(yZero_tb),
            .cnt(cnt_tb),
            .R_lt_Y(R_lt_Y_tb),
            .x_RightIn(x_RightIn_tb),
            .x_LD(x_LD_tb),
            .x_SL(x_SL_tb),
            .y_LD(y_LD_tb), 
            .r_LD(r_LD_tb), 
            .r_SL(r_SL_tb), 
            .r_SR(r_SR_tb),
            .s1(s1_tb),
            .s2(s2_tb),
            .s3(s3_tb),
            .n(n_tb),
            .cnt_LD(cnt_LD_tb),
            .cnt_en(cnt_en_tb),
            .Done(Done_tb),
            .Err(Err_tb)
            );
            
    integer errors;
            
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    initial begin
        Go_tb = 0;
        yZero_tb = 0;
        cnt_tb = 0;
        R_lt_Y_tb = 0;
        errors = 0;
        rst_tb = 1;        
        clk_tb = 0;
        //rst_tb = 0;
        ticktock();
        rst_tb = 0;
        
        ticktock();//go to state 0
        
        //checking state 0
        if(x_LD_tb != 0 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S0 failed");
            errors = errors + 1;
        end
        
        Go_tb = 1;
        ticktock();//go to state 1
        
        if(x_LD_tb != 1 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 1 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0100 &&
           cnt_LD_tb != 1 &&
           cnt_en_tb != 1 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S1 failed");
            errors = errors + 1;
        end
        
        ticktock();//go to state 2
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 1 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 1 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S2 failed");
            errors = errors + 1;
        end
        
        yZero_tb = 1;// check when  of y=0;
        
        ticktock();//go to state S8
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 1 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 1)
        begin
            $display("S8 failed");
            errors = errors + 1;
        end
        
        ticktock();//go back to S0
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S0 failed");
            errors = errors + 1;
        end
        
        yZero_tb = 0;
        Go_tb = 1;
        ticktock();//go to state 1
        
        if(x_LD_tb != 1 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 1 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0100 &&
           cnt_LD_tb != 1 &&
           cnt_en_tb != 1 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S1 failed");
            errors = errors + 1;
        end
        
        ticktock();//go to state 2
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 1 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 1 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S2 failed");
            errors = errors + 1;
        end
        
        R_lt_Y_tb = 0; //let R<Y is false
        ticktock();//go to state 3
        
       
        if(x_LD_tb != 1 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 1 &&
           r_LD_tb != 1 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 1 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 1 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S3 failed at R<Y = 0");
            errors = errors + 1;
        end
        
        ticktock();//should go to state 4
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 1 &&
           x_RightIn_tb != 1 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 1 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S4 failed");
            errors = errors + 1;
        end
        
         cnt_tb = 0;// if cnt=0 is false
        //go back to S3
        R_lt_Y_tb = 1; //let R<Y is false
        
        ticktock();//to go back to S3
        
       
        if(x_LD_tb != 1 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 1 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 1 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S3 failed at R<Y = 1");
            errors = errors + 1;
        end
        
        
        ticktock();//go to S5
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 1 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 1 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S5 failed");
            errors = errors + 1;
        end
        
        cnt_tb = 1; //cnt=0 is true
        ticktock();//go to S6 
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 9 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 1 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S6 failed");
            errors = errors + 1;
        end
        
        ticktock();//go to state 7
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 1 &&
           s3_tb != 1 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 1 &&
           Err_tb != 0)
        begin
            $display("S7 failed");
            errors = errors + 1;
        end
        
        ticktock();// go back to state 0
        
        if(x_LD_tb != 0 &&
           x_SL_tb != 0 &&
           x_RightIn_tb != 0 &&
           y_LD_tb != 0 &&
           r_LD_tb != 0 &&
           r_SL_tb != 0 &&
           r_SR_tb != 0 &&
           s1_tb != 0 &&
           s2_tb != 0 &&
           s3_tb != 0 &&
           n_tb != 4'b0000 &&
           cnt_LD_tb != 0 &&
           cnt_en_tb != 0 &&
           Done_tb != 0 &&
           Err_tb != 0)
        begin
            $display("S0 failed when going from S7");
            errors = errors + 1;
        end
        
        
    end
endmodule

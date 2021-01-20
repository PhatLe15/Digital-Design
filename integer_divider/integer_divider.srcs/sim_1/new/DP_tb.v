`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2019 12:18:48 AM
// Design Name: 
// Module Name: DP_tb
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


module DP_tb;
    reg [3:0] x_tb;
    reg x_LD_tb;
    reg x_SL_tb;
    reg x_RightIn_tb;
    reg [3:0] y_tb;
    reg y_LD_tb;
    reg r_LD_tb; 
    reg r_SL_tb;
    reg r_SR_tb;
    reg s1_tb,s2_tb,s3_tb;
    reg [3:0] n_tb;
    reg cnt_LD_tb, cnt_en_tb;
    reg rst_tb,clk_tb;
    wire [3:0] Q_tb;
    wire [3:0] R_tb;
    wire R_lt_Y_tb, cnt_out_tb, yZero_tb;
    
    data_path DUT(.x(x_tb),
                  .x_LD(x_LD_tb),
                  .x_SL(x_SL_tb),
                  .x_RightIn(x_RightIn_tb),
                  .y(y_tb),
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
                  .rst(rst_tb),
                  .clk(clk_tb),
                  .Q(Q_tb),
                  .R(R_tb),
                  .R_lt_Y(R_lt_Y_tb),
                  .cnt_out(cnt_out_tb),
                  .yZero(yZero_tb));
                  
    task ticktock;
    begin
        #5 clk_tb = ~clk_tb;
        #5 clk_tb = ~clk_tb;
    end
    endtask
    
    initial begin
        x_tb =0;
        x_LD_tb =0;
        x_SL_tb =0;
        x_RightIn_tb = 0;
        y_tb =0;
        y_LD_tb =0;
        r_LD_tb =0; 
        r_SL_tb =0;
        r_SR_tb =0;
        s1_tb =0;
        s2_tb =0;
        s3_tb =0;
        n_tb =0;
        cnt_LD_tb =0;
        cnt_en_tb =0;       
        
        rst_tb = 1;        
        clk_tb = 0;
        //rst_tb = 0;
        ticktock();
        rst_tb = 0;
        
        //idle state
        x_tb =0;
        x_LD_tb =0;
        x_SL_tb =0;
        x_RightIn_tb = 0;
        y_tb =0;
        y_LD_tb =0;
        r_LD_tb =0; 
        r_SL_tb =0;
        r_SR_tb =0;
        s1_tb =0;
        s2_tb =0;
        s3_tb =0;
        n_tb =0;
        cnt_LD_tb =0;
        cnt_en_tb =0;       
        
        ticktock();
        
        //s1 
        x_tb = 11; //let x be a random number
        x_LD_tb =1;//load value of x
        x_SL_tb =0;
        x_RightIn_tb = 0;//dont care about this signal for now
        y_tb = 3;
        y_LD_tb =1;// load value of y
        r_LD_tb =0; //nothing to load 
        r_SL_tb =0;
        r_SR_tb =0;
        s1_tb =0;
        s2_tb =0;
        s3_tb =0;
        n_tb =4'b0100; //load 4 to counter
        cnt_LD_tb =1;// load 4 to the counter
        cnt_en_tb =1;// enable the counter
        
        ticktock();
        if(yZero_tb)// if error y=0 stop the process
        begin
           $stop; 
        end
        
        else begin //continue the process
        
        //s2
        x_tb = 0;
        x_LD_tb =0;//dont load value of x
        x_SL_tb =1;// shift left enable
        x_RightIn_tb = 0;
        y_tb = 0;//no need to change
        y_LD_tb =0;//bc y is already hold inside
        r_LD_tb =0; //nothing to load 
        r_SL_tb =1; //enable shift left
        r_SR_tb =0;
        s1_tb =0;
        s2_tb =0;
        s3_tb =0;
        n_tb =0; //no need to load
        cnt_LD_tb =0;// counter remain 4
        cnt_en_tb =0;// no need to countdown rn
        ticktock();
        
        
     while(cnt_out_tb ==0)//end the loop if count = 0
     begin
        //s3
        x_tb = 0;
        x_LD_tb =0;//no need to load
        x_SL_tb =0;//x hold value at this state
        x_RightIn_tb = 0;// nothing comes in 
        y_tb = 0;//same as y
        y_LD_tb =0;
        
        s2_tb =0;
        s3_tb =0;
        n_tb =0; //nothing to load
        cnt_LD_tb =0;// counter not load
        cnt_en_tb =1;// start countdown 
        
        if(!R_lt_Y_tb)// if R<Y is false
        begin
            r_LD_tb =1; //load R-Y 
            r_SL_tb =0; //r no shift at this state
            r_SR_tb =0;
            s1_tb = 1;//enable R-Y
            
            ticktock();//go to s4
            x_tb = 0;
            x_LD_tb =0;//no need to load
            x_SL_tb =1;//x shift left
            x_RightIn_tb = 1; 
            y_tb = 0;// y hold
            y_LD_tb =0;
            r_LD_tb =0; //nothing to load 
            r_SL_tb =1; //shift left r
            r_SR_tb =0;
            s1_tb =0;
            s2_tb =0;
            s3_tb =0;
            n_tb =0; 
            cnt_LD_tb =0;// nothing to load
            cnt_en_tb =0;// no countdown at this state
            ticktock();//go to the next state
        end
        
        else //go to s5 if true
        begin
            r_LD_tb =0; //
            r_SL_tb =0; //r no shift at this state
            r_SR_tb =0;
            s1_tb = 0;//enable R-Y
            ticktock();
            
            x_tb = 0;
            x_LD_tb =0;//no need to load
            x_SL_tb =1;//x shift left
            x_RightIn_tb = 0; 
            y_tb = 0;// y hold
            y_LD_tb =0;
            r_LD_tb =0;
            r_SL_tb =1; //shift left r
            r_SR_tb =0;
            s1_tb =0;
            s2_tb =0;
            s3_tb =0;
            n_tb =0; //load 4 to counter
            cnt_LD_tb =0;// nothing to load
            cnt_en_tb =0;// no countdown at this state
            ticktock();//go to the next state
        end
        
      end
      //s6
            x_tb = 0;
            x_LD_tb =0;//no need to load
            x_SL_tb =0;//no shift x
            x_RightIn_tb = 0; 
            y_tb = 0;// y hold
            y_LD_tb =0;
            r_LD_tb =0; 
            r_SL_tb =0; //shift left r
            r_SR_tb =1;
            s1_tb =0;// begin R-Y
            s2_tb =0;
            s3_tb =0;
            n_tb =0; //load 4 to counter
            cnt_LD_tb =0;// nothing to load
            cnt_en_tb =0;// no countdown at this state
            
            ticktock();
      //s7
            x_tb = 0;
            x_LD_tb =0;//no need to load
            x_SL_tb =0;//no shift x
            x_RightIn_tb = 0; 
            y_tb = 0;// y hold
            y_LD_tb =0;
            r_LD_tb =0; 
            r_SL_tb =0; //shift left r
            r_SR_tb =0;
            s1_tb =0;// begin R-Y
            s2_tb =1;//output remainder
            s3_tb =1;//output quotient
            n_tb =0; //load 4 to counter
            cnt_LD_tb =0;// nothing to load
            cnt_en_tb =0;// no countdown at this state
            
            ticktock();
       end 
   
    end
                  
                  
                  
                  
endmodule

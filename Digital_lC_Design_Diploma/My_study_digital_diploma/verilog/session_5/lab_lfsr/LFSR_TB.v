`timescale 1ns/1ps
module LFSR_tb;
//parameters
parameter lfsr_wdth = 8;
parameter test_cases = 5;

//tb signals
reg clk_tb;
reg rst_tb;
reg enable_tb;
reg out_enable_tb;
reg  [lfsr_wdth-1:0] seed_tb;
wire out_tb;
wire valid_tb;

//instance of design module
LFSR uut (
    .clk(clk_tb),
    .rst(rst_tb),
    .enable(enable_tb),
    .out_enable(enable_tb),
    .seed(seed_tb),
    .out(out_tb),
    .valid(valid_tb) 
  );

// generate clk
parameter T = 10;
always #(T/2) clk_tb = ~clk_tb;

// memories of test_bench
reg [lfsr_wdth-1 : 0] test_seeds [test_cases - 1 : 0];
reg [lfsr_wdth - 1 : 0] expected_outs [test_cases - 1 : 0];

integer test_n;
//stimulus
initial 
begin
    // system functions
    $dumpfile("LFSR.vcd");
    $dumpvars;

    //read input file
 $readmemb("Seeds_b.txt", test_seeds);
 $readmemb("Expec_Out_b.txt", expected_outs);

    initialize();

    //testcaeses
    
    for (test_n = 0; test_n < test_cases; test_n = test_n + 1) 
    begin
        do_op(test_seeds[test_n]);
        check_result(expected_outs[test_n],test_n);
    end
    #100
    $finish;

end











////////////////////////////////////TASKS\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//1) initialization
task initialize;
    begin
       seed_tb = 'b10010011;
       clk_tb = 1'b0;
       rst_tb = 1'b0;
       enable_tb = 1'b0;
       out_enable_tb = 1'b0; 
    end    
endtask

//2) reset task
task reset;
    begin
        rst_tb = 1'b1; // deactivate
        #(T)
        rst_tb = 1'b0; // activate
        #(T)
        rst_tb = 1'b1;
    end
endtask

//3) task of operation senario
/*  1- assign seed
    2- activate enable to operate lfsr
    3- waiting 10 clk cycles for storing all bits
    4- deactivate enable */
task do_op;
    input [lfsr_wdth-1 : 0] IN_SEED;
    begin
        seed_tb = IN_SEED;
        reset();
        #(T)
        enable_tb = 1'b1;
        #(10*T)
        enable_tb = 1'b0;
    end
endtask

      
//4) task of checking

task check_result;
    input reg [lfsr_wdth-1 : 0]expected_output;
    input integer test_case_n; 
    integer k;
    reg [lfsr_wdth-1 : 0] current_output;
    begin       
        enable_tb = 1'b0; // deactivate the operation of storing bits
        #(T)
        out_enable_tb = 1'b1; // activate the operation of shifting (gitting the LSB out)
        @(posedge valid_tb) // waiting for activate "valid_tb" signal
        
        for(k = 0; k <=lfsr_wdth-1  ; k=k+1)
        begin
            #(T)
            current_output[k] = out_tb;
        end

        if (current_output == expected_output)
            $display("Test case %d IS PASSED",test_case_n);
        else
            $display("Test case %d IS FAILED",test_case_n);
        out_enable_tb = 1'b0;
    end
endtask





endmodule

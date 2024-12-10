`timescale 1ns/1ps
module CRC_TB;

///////////////////////parameters\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    parameter lfsr_wdth = 8;
    parameter crc_wdth = 8;
    parameter test_cases = 10;

////////////////////// DUT signals \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    reg DATA_tb;
    reg Active_tb;
    reg clk_tb;
    reg rst_tb;
    wire CRC_tb;
    wire Valid_tb;

//////////////////// instance of design module \\\\\\\\\\\\\\\\\\
    CRC dut(
        .DATA(DATA_tb),
        .Active(Active_tb),
        .clk(clk_tb),
        .rst(rst_tb),
        .CRC(CRC_TB),
        .Valid(Valid_tb)
    );
///////////////////// generating clock \\\\\\\\\\\\\\\\\\\\\\
parameter T = 10;
always #(T/2) clk_tb = ~clk_tb;

/////////////////// Memories of values \\\\\\\\\\\\\\\\\\\\\
reg [lfsr_wdth-1 : 0] data_in [test_cases-1 : 0];
reg [lfsr_wdth-1 : 0] excp_outs [test_cases-1 : 0];


//stimulus
/*
1- initial
2- reset
3- do op
4- check output
*/
integer j;

initial
begin
    $dumpfile("crc.vcd");
    $dumpvars;

    $readmemb("data_inputs.txt",data_in);
    $readmemb("excep_outputs.txt",excp_outs);

    initialize();
    for (j = 0 ; j < test_cases;j = j + 1 )
    begin
        reset();
        do_trans(data_in[j]);
        check_crc(excp_outs[j],j);
    end

    #100
    $finish;
end












/////////////////////// TASKS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// (1) initialize
task initialize;
begin
    clk_tb = 1'b0;
    rst_tb = 1'b1;
    DATA_tb = 1'b0;
    Active_tb = 1'b0;    
end
endtask

// (2) reset
task reset;
    begin       
        rst_tb = 1'b1; // de activate
        #(T)
        rst_tb = 1'b0; //activate
        #(T)
        rst_tb = 1'b1; // de activate
    end
endtask

// (3) trans_op
task do_trans;
        input [lfsr_wdth-1 : 0] data;
        integer i;
        begin
            Active_tb = 1'b1;
            for (i = 0;i<lfsr_wdth ;i = i + 1 )
            begin
                DATA_tb = data[i];    
            end
            Active_tb = 1'b0;
        end
endtask

// (4) check_crc
task check_crc;
        input [crc_wdth - 1  : 0]excepcted_output;
        input test_n;
        reg [crc_wdth - 1 : 0] current_output;
        integer k;
        begin
            @(posedge Valid_tb)
            for (k = 0; k<crc_wdth-1; k = k + 1)
                begin
                    #(T) 
                    current_output[k] = CRC_TB;                
                end
            if(current_output == excepcted_output)
                $display("Test case %d IS PASSED\n",test_n);
            else
                $display("Test case %d IS FAILED\n",test_n);
        end
endtask

    
endmodule



/*
1- intialize 
2- store the data bits from lsb in 8 cycles
3- deactive trans of data
4- git lsb out to (crc)
5- valid = 1
6- store all crc bit in container after 8 cycles
*/








module Register_file_tb();
  parameter addrs_wdth_tb = 3;
  parameter mem_wdth_tb = 16;
  parameter mem_dpth_tb = 8;
  ////internal signals
  reg [mem_wdth_tb - 1 : 0]WrData_tb;
  reg [addrs_wdth_tb - 1 : 0]Address_tb;
  reg WrEn_tb;
  reg RdEn_tb;
  reg CLK_tb;
  reg RST_tb;
  wire [mem_wdth_tb - 1 : 0]RdData_tb;



  //instance 
  Register_file
        #(
         .addrs_wdth(addrs_wdth_tb),
         .mem_wdth(mem_wdth_tb),
         .mem_dpth(mem_dpth_tb)
         )
         uut
        (
            .WrData(WrData_tb),
            .Address(Address_tb),
            .WrEn(WrEn_tb),
            .RdEn(RdEn_tb),
            .CLK(CLK_tb),
            .RST(RST_tb),
            .RdData(RdData_tb)
          );

    //generate clk
    parameter T = 10 ;
    always #(T/2) CLK_tb = ~CLK_tb;

    initial
    begin
    //initial values
    CLK_tb = 1'b0;
    RST_tb = 1'b1;
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b0;
    //reset the system
    #T
    RST_tb = 1'b0;
    #T
    RST_tb = 1'b1;
    //firstly write data 
    // 1st op
    #T
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;
    Address_tb = 3'd0;
    WrData_tb = 16'd127;
    // 2nd op
    #T
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;
    Address_tb = 3'd2;
    WrData_tb = 16'd623;
    // 3rd op
    #T
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;
    Address_tb = 3'd5;
    WrData_tb = 16'd716;
    // 4th op
    #T
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;
    Address_tb = 3'd7;
    WrData_tb = 16'd6120;
    
    //Secondly read operations
    // 1st op
    #T
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;
    Address_tb = 3'd0;
    #T
    if(RdData_tb == 16'd127)
        $display(" 1st operation IS PASSED :) ");
    else
        $display(" 1st operation IS FAILED :( ");
    #T
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;
    Address_tb = 3'd2;
    #T
    if(RdData_tb == 16'd623)
        $display(" 2nd operation IS PASSED :) ");
    else
        $display(" 2nd operation IS FAILED :( ");
    #T
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;
    Address_tb = 3'd5;
    #T
    if(RdData_tb == 16'd716)
        $display(" 3rd operation IS PASSED :) ");
    else
        $display(" 3rd operation IS FAILED :( ");
    #T
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;
    Address_tb = 3'd7;
    #T
    if(RdData_tb == 16'd6120)
        $display(" 4th operation IS PASSED :) ");
    else
        $display(" 4th operation IS FAILED :( ");
    #100
    $finish;
        
    end


  
endmodule
  


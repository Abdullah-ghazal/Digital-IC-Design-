module Register_file
        #(
         parameter addrs_wdth = 3,
         parameter mem_wdth = 16,
         parameter mem_dpth = 8)
         
         (
            input wire [mem_wdth-1 : 0]WrData,
            input wire [addrs_wdth-1 : 0]Address,
            input wire WrEn,
            input wire RdEn,
            input wire CLK,
            input wire RST,
            output reg [mem_wdth -1 : 0]RdData
          );
        
        //declare register file array
        reg [mem_wdth - 1 : 0] reg_file [mem_dpth - 1 : 0];
        
        //FOR LOOP
        integer i;
        
        always @(posedge CLK or negedge RST)
        begin
            if(!RST)    
            begin
                for ( i = 0; i < mem_dpth ; i = i + 1 )
                begin
                    reg_file[i] <= 'b0;
                end
            end
            else if(WrEn && !RdEn)
                reg_file[Address] <= WrData;
            else if(RdEn && !WrEn)
                RdData <= reg_file[Address];            

        end

  
endmodule
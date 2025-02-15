module LFSR(
    input wire clk, rst, enable, out_enable,
    input wire [7:0] seed,
    output reg out, valid 
  );
//declare register
reg [7:0]LFSR;
//declare wires
wire nor_bits = ~| LFSR[6:0];
wire feedback = nor_bits ^ LFSR[7];
//sequence declaration
parameter taps = 8'b10101010;
integer i;//for loop

always @(posedge clk or negedge rst)
begin
    if(!rst)//high periorty
        begin
            LFSR[7:0] <= seed[7:0];
            out <= 1'b0;
            valid <= 1'b0;
        end
    else if(enable)
        begin
            LFSR[0] <= feedback;
            for(i = 7 ; i >= 1 ; i = i + 1)
            begin
                if(taps[i] == 1'b1)
                    LFSR[i] <= LFSR[i-1]^feedback;
                else
                    LFSR[i] <= LFSR[i-1];
            end

        end
    else if(out_enable)
        begin
            {LFSR[6:0],out} <= LFSR[7:0];
            valid <= 1'b1;
        end
end


endmodule
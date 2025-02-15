module CRC (
    input wire DATA,
    input wire Active,
    input wire clk,
    input wire rst,
    output reg CRC,
    output reg Valid
);

reg [7:0] LFSR;
wire feedback = LFSR[0] ^ DATA;
reg [3:0] count;
wire done;

always @(posedge clk, negedge rst)
begin
    if(!rst)
        begin
            LFSR <= 8'hD8;
            CRC <= 1'b0;
            Valid <= 1'b0;
            count <= 4'd0;
        end 
    else if(Active)
        begin
            LFSR[7] <= feedback;
            LFSR[6] <= LFSR[7] ^ feedback;
            LFSR[5] <= LFSR[6];
            LFSR[4] <= LFSR[5];
            LFSR[3] <= LFSR[4];
            LFSR[2] <= LFSR[3] ^ feedback;
            LFSR[1] <= LFSR[2];
            LFSR[0] <= LFSR[1];
            CRC <= 1'b0;
            Valid <= 1'b0;
            count <= 4'd0;
        end
    else if(!done && !Active)
        begin
            {LFSR[6:0] , CRC} <= LFSR[7:0];
            Valid <= 1'b1;
            count = count + 1;
        end
end

assign done = (count == 4'd8);
    
endmodule

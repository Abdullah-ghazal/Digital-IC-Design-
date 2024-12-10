module moore_design (
    input wire clk,rst,
    input wire up_max,dn_max,
    input wire activate,
    output reg up_m, dn_m
);

    // state encoding
    localparam  idle  = 2'b01,
                mv_up = 2'b11,
                mv_dn = 2'b10;
    reg [1:0] next_state,reg_state;

    always @(posedge clk, negedge rst)
    begin
        if(!rst)
            reg_state <= idle;
        else
            reg_state <= next_state;
    end

    always @(*)
    begin
            up_m = 1'b0;
            dn_m = 1'b1;
        case(reg_state)
            idle: begin
                if(activate == 0)
                    next_state = idle;
                else if(activate && dn_max && !up_max)
                    next_state = mv_up;
                else if(activate && up_max && !dn_max)
                    next_state = mv_dn;                    
                //outputs
                up_m = 1'b0;
                dn_m = 1'b0;
                    end
            mv_up:
                begin
                    if(up_max)
                        next_state = idle;
                    else
                        next_state = mv_up;
                //outputs
                    up_m = 1'b1;
                    dn_m = 1'b0;
                end
            mv_dn:
                begin
                    if(dn_max)
                        next_state = idle;
                    else    
                        next_state = mv_dn;
                //outputs
                    up_m = 1'b0;
                    dn_m = 1'b1;
                end   
            default:
                  begin
                    next_state = idle;
                    up_m = 1'b0;
                    dn_m = 1'b0;         
                  end

        endcase
    end

    
endmodule

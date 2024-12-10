module ALU(
  input wire [15:0]A,
  input wire [15:0]B,
  input wire [3:0]ALU_FUN,
  input wire CLK,
  output reg [15:0] ALU_OUT,
  output reg Arith_Flag,
  output reg Logic_Flag,
  output reg CMP_Flag,
  output reg Shift_Flag
);

reg [15:0] ALU_OUT_reg;

always @(posedge CLK)
begin
  ALU_OUT <= ALU_OUT_reg;
end

always @(*)
begin
  ALU_OUT = 16'b0;
  Arith_Flag = 1'b0;
  Logic_Flag = 1'b0;
  CMP_Flag = 1'b0;
  Shift_Flag = 1'b0;
  case(ALU_FUN)
    //Arithmatic operations
    4'b0000:
        begin
          ALU_OUT_reg = A + B;
          Arith_Flag = 1'b1;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b0001:
        begin
          ALU_OUT_reg = A - B;
          Arith_Flag = 1'b1;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b0010:
        begin
          ALU_OUT_reg = A * B;
          Arith_Flag = 1'b1;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b0011:
        begin
          ALU_OUT_reg = A / B;
          Arith_Flag = 1'b1;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    //Ligic operations
    4'b0100:
        begin
          ALU_OUT_reg = A & B;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b1;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b0101:
        begin
          ALU_OUT_reg = A | B;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b1;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b0110:
        begin
          ALU_OUT_reg = ~(A & B) ;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b1;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b0111:
        begin
          ALU_OUT_reg = ~(A | B);
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b1;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b1000:
        begin
          ALU_OUT_reg = A ^ B;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b1;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    4'b1001:
        begin
          ALU_OUT_reg = A ~^ B;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b1;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end
    //CMP operations
    4'b1010:
        begin
          ALU_OUT_reg = (A==B)?(1):(0);
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b1;
          Shift_Flag = 1'b0;
        end                                                                                
    4'b1011:
        begin
          ALU_OUT_reg = (A>B)?(2):(0);
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b1;
          Shift_Flag = 1'b0;
        end
    4'b1100:
        begin
          ALU_OUT_reg = (A<B)?(3):(0);
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b1;
          Shift_Flag = 1'b0;
        end
    4'b1101:
        begin
          ALU_OUT_reg = A >> 1;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b1;
        end
    4'b1110:
        begin
          ALU_OUT_reg = A << 1;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b1;
        end
    default:
        begin
          ALU_OUT = 16'b0;
          Arith_Flag = 1'b0;
          Logic_Flag = 1'b0;
          CMP_Flag = 1'b0;
          Shift_Flag = 1'b0;
        end  
                
    endcase                                             
end


endmodule
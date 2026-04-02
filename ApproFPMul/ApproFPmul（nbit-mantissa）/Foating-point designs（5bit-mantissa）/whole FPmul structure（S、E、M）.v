module Approximate_Float(
input wire [31:0] A,
input wire [31:0] B,
output reg[31:0] result
    );
//尾数中心乘法结果      
wire [5:0] Mantissa3x3_result;
 Mantissa3x3 Mantissa3x3(
    .c(A[22:20]),
    .d(B[22:20]),
    .product(Mantissa3x3_result)
);
//尾数边界加法结果  
wire [9:0] mantissaCompensate_result;
 Compensate mantissaCompensate(
  .a({1'b1,B[22:20],1'b1,A[22:20],1'b1}),
  .b({1'b0,A[22:20],1'b1,B[22:20],1'b0}),
  .comTerm(mantissaCompensate_result)
);

// 尾数中心乘法结果与边界加法结果相加得到5-bit尾数乘法的乘积
wire [7:0] compMantissa3x3_result;
assign compMantissa3x3_result[7:0] = {1'b0,1'b0,Mantissa3x3_result[5:0]}; 
wire [9:0] mantissaresult;
assign mantissaresult[1:0] = mantissaCompensate_result[1:0];

parameter LUT_INIT = 64'h6666666688888888;

wire [7:0] gen, prop;
genvar i;
generate
for (i = 0; i < 8; i = i+1) begin
    LUT6_2 #(.INIT(LUT_INIT)) Fast_Adder_LUT (
        .I0(mantissaCompensate_result[i+2]), .I1(compMantissa3x3_result[i]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop[i]), .O5(gen[i])
    );
end
endgenerate

wire [7:0] cout;
wire [7:0] sum;
CARRY4 CARRY4_inst0 (
.CO(cout[3:0]), // 4-bit carry out
.O(sum[3:0]), // 4-bit carry chain XOR data out
.CI(1'b0), // 1-bit carry cascade input
.CYINIT(1'b0), // 1-bit carry initialization
.DI(gen[3:0]), // 4-bit carry-MUX data in
.S(prop[3:0]) // 4-bit carry-MUX select input
);              
CARRY4 CARRY4_inst1 (
.CO(cout[7:4]), // 4-bit carry out
.O(sum[7:4]), // 4-bit carry chain XOR data out
.CI(cout[3]), // 1-bit carry cascade input
.CYINIT(1'b0), // 1-bit carry initialization
.DI(gen[7:4]), // 4-bit carry-MUX data in
.S(prop[7:4]) // 4-bit carry-MUX select input
);
assign mantissaresult[9:2] = sum[7:0];             

// 指数加法结果，其中5-bit尾数乘法的乘积的最高位mantissaresult[9]作为进位       
 wire [9:0] Exponent_result;
 Exponent_Adder  Exponent_Adder(
    .P00(A[30:23]),
    .P01(B[30:23]),
    .cin(mantissaresult[9]),
    .product(Exponent_result)
);

//根据尾数乘积向指数加法传递进位的情况对尾数进行对应的调整
always @* begin
case (mantissaresult[9])
1'b1: begin   
      result[22:14] = mantissaresult[8:0];
      result[13:0] = 14'b0000_0000_0000_00;   
            end
1'b0: begin
      result[22:15] = mantissaresult[7:0];
      result[14:0] = 15'b0000_0000_0000_000; 
            end            
endcase
end

//根据指数高两位判断浮点乘法是否发生上溢或者下溢
always @* begin
case (Exponent_result[9:8])
2'b10: begin   
      result[30:23] = Exponent_result[7:0]; 
       end
2'b11: begin
      result[30:23] = 8'b11111110; 
       end 
2'b01: begin
      result[30:23] = 8'b0000_0001; 
       end 
2'b00: begin
      result[30:23] = 8'b0000_0000; 
       end                                          
endcase
end  

//符号位计算
always @* begin
result[31] = A[31] ^ B[31]; 
end                                                                         
endmodule

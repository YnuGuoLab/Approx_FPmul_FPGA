module Approximate_Float(
input wire [31:0] A,
input wire [31:0] B,
output reg[31:0] result
    );
//尾数中心乘法结果         
wire [11:0] Mantissa6x6_result;
 Mantissa6x6 Mantissa6x6(
    .c(A[22:17]),
    .d(B[22:17]),
    .product(Mantissa6x6_result)
);
//尾数边界加法结果  
wire [15:0] mantissaCompensate_result;
 Compensate mantissaCompensate(
  .a({1'b1,B[22:17],1'b1,A[22:17],1'b1}),
  .b({1'b0,A[22:17],1'b1,B[22:17],1'b0}),
  .comTerm(mantissaCompensate_result)
);

// 尾数中心乘法结果与边界加法结果相加得到8-bit尾数乘法的乘积
wire [15:0] mantissaresult;
assign mantissaresult[1:0] = mantissaCompensate_result[1:0];

parameter LUT_INIT = 64'h6666666688888888;
wire [11:0] gen, prop;
genvar i;
generate
for (i = 0; i < 12; i = i+1) begin
    LUT6_2 #(.INIT(LUT_INIT)) Fast_Adder_LUT (
        .I0(mantissaCompensate_result[i+2]), .I1(Mantissa6x6_result[i]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop[i]), .O5(gen[i])
    );
end
endgenerate

wire [11:0] cout;
wire [11:0] sum;
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
CARRY4 CARRY4_inst2 (
.CO(cout[11:8]), // 4-bit carry out
.O(sum[11:8]), // 4-bit carry chain XOR data out
.CI(cout[7]), // 1-bit carry cascade input
.CYINIT(1'b0), // 1-bit carry initialization
.DI(gen[11:8]), // 4-bit carry-MUX data in
.S(prop[11:8]) // 4-bit carry-MUX select input
);

LUT6_2 #(.INIT(64'hF8F8F8F866666666)) Fast_Adder_LUT22 (
        .I0(cout[11]), .I1(mantissaCompensate_result[14]), .I2(mantissaCompensate_result[15]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(mantissaresult[15]), .O5(mantissaresult[14])
        );
 assign mantissaresult[13:2] = sum[11:0];
 
// 指数加法结果，其中5-bit尾数乘法的乘积的最高位mantissaresult[15]作为进位    
 wire [9:0] Exponent_result;
 
 Exponent_Adder  Exponent_Adder(
    .P00(A[30:23]),
    .P01(B[30:23]),
    .cin(mantissaresult[15]),
    .product(Exponent_result)
);

//根据尾数乘积向指数加法传递进位的情况对尾数进行对应的调整
always @* begin
case (mantissaresult[15])
1'b1: begin   
      result[22:8] = mantissaresult[14:0];
      result[7:0] = 8'b0000_0000;   
            end
1'b0: begin
      result[22:9] = mantissaresult[13:0];
      result[8:0] = 9'b0000_0000_0; 
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

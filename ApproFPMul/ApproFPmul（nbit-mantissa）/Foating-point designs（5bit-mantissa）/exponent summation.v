module Exponent_Adder (
    input [7:0] P00,
    input [7:0] P01,
    input [0:0] cin,
    output wire [9:0] product
);

parameter LUT_INIT = 64'h6666666688888888;
wire [8:0] gen1, prop1;
wire [8:0] cache;

genvar i;
generate
for (i = 0; i < 8; i = i+1) begin
    LUT6_2 #(.INIT(LUT_INIT)) Fast_Adder_LUT (
        .I0(P00[i]), .I1(P01[i]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop1[i]), .O5(gen1[i])
    );
end
endgenerate

// 8-bit指数相加

wire [7:0] cout;
wire [7:0] sum;
CARRY4 CARRY4_inst0 (
.CO(cout[3:0]), // 4-bit carry out
.O(sum[3:0]), // 4-bit carry chain XOR data out
.CI(1'b0), // 1-bit carry cascade input
.CYINIT(1'b0), // 1-bit carry initialization
.DI(gen1[3:0]), // 4-bit carry-MUX data in
.S(prop1[3:0]) // 4-bit carry-MUX select input
);
 CARRY4 CARRY4_inst1 (
.CO(cout[7:4]), // 4-bit carry out
.O(sum[7:4]), // 4-bit carry chain XOR data out
.CI(cout[3]), // 1-bit carry cascade input
.CYINIT(1'b0), // 1-bit carry initialization
.DI(gen1[7:4]), // 4-bit carry-MUX data in
.S(prop1[7:4]) // 4-bit carry-MUX select input
);
assign cache[8:0] ={cout[7], sum[7:0]};


// 减去偏移量127并加上尾数进位

wire [8:0] gen, prop;
LUT6_2 #(.INIT(64'h5555555533333333)) Fast_Adder_LUT1 (
        .I0(cache[7]), .I1(cache[0]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop[7]), .O5(prop[0])
        );
        
wire [7:0] cout1;
wire [7:0] sum1;
CARRY4 CARRY4_inst2 (
.CO(cout1[3:0]), // 4-bit carry out
.O(sum1[3:0]), // 4-bit carry chain XOR data out
.CI(cin), // 尾数进位
.CYINIT(1'b0), // 1-bit carry initialization
.DI({1'b0, 1'b0, 1'b0, sum[0]}), // 4-bit carry-MUX data in
.S({sum[3], sum[2], sum[1], prop[0]}) // 4-bit carry-MUX select input
);
 CARRY4 CARRY4_inst3 (
.CO(cout1[7:4]), // 4-bit carry out
.O(sum1[7:4]), // 4-bit carry chain XOR data out
.CI(cout1[3]), // 1-bit carry cascade input
.CYINIT(1'b0), // 1-bit carry initialization
.DI({sum[7], 1'b0, 1'b0, 1'b0}), // 4-bit carry-MUX data in
.S({prop[7],sum[6], sum[5], sum[4]}) // 4-bit carry-MUX select input
);

LUT6_2 #(.INIT(64'hFAFAFAFAA5A5A5A5)) Fast_Adder_LUT3 (
        .I0(cache[8]), .I1(1'b1), .I2(cout1[7]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop[8]), .O5(gen[8])
        );
assign product[9:0] ={prop[8], gen[8], sum1[7:0]};
endmodule
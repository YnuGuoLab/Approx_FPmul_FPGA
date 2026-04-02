module Compensate (
    input [14:0] a,
    input [14:0] b,
    output wire [15:0] comTerm
);

//尾数乘法的边界部分直接使用进位链相加

parameter LUT_INIT = 64'h6666666688888888;

wire [11:0] gen, prop;

genvar i;
generate
for (i = 0; i < 12; i = i+1) begin
    LUT6_2 #(.INIT(LUT_INIT)) Fast_Adder_LUT (
        .I0(a[i+1]), .I1(b[i+1]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop[i]), .O5(gen[i])
    );
end
endgenerate
wire [13:0] cout;
wire [13:0] sum;
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
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT1 (
        .I0(a[13]), .I1(b[13]), .I2(cout[11]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(cout[12]), .O5(sum[12])
        ); 
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT2 (
        .I0(a[14]), .I1(b[14]), .I2(cout[12]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(cout[13]), .O5(sum[13])
        ); 
assign comTerm[0] = a[0];
assign comTerm[15:1] = {cout[13],sum[13:0]};

endmodule
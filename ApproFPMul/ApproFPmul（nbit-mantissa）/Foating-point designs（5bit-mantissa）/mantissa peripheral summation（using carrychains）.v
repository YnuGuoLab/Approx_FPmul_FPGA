module Compensate (
    input [8:0] a,
    input [8:0] b,
    output wire [9:0] comTerm
);

parameter LUT_INIT = 64'h6666666688888888;

wire [7:0] gen, prop;

genvar i;
generate
for (i = 0; i < 8; i = i+1) begin
    LUT6_2 #(.INIT(LUT_INIT)) Fast_Adder_LUT (
        .I0(a[i+1]), .I1(b[i+1]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
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
assign comTerm[0] = a[0];     
assign comTerm[9:1] = {cout[7],sum[7:0]};

endmodule
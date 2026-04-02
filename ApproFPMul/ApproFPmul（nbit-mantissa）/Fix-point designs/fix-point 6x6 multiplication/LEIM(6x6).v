module Mantissa6x6 (
    input [5:0] c,
    input [5:0] d,
    output wire [11:0] product
);

//ALBL3x3

wire [5:0] ALBL3x3;
LUT6_2 #(.INIT(64'h6AC06AC0A0A0A0A0)) Fast_Adder_LUT1 (
        .I0(d[0]), .I1(d[1]), .I2(c[0]), .I3(c[1]), .I4(1'b1), .I5(1'b1),
        .O6(ALBL3x3[1]), .O5(ALBL3x3[0])
        );
//assign  ALBL3x3[1:0] = {1'b0,1'b0};
LUT6 #(.INIT(64'h1E665AAAB4CCF000)) Fast_Adder_LUT2 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBL3x3[2])
        );
        
LUT6 #(.INIT(64'h54B46CCC38F00000)) Fast_Adder_LUT3 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBL3x3[3])
        );

LUT6 #(.INIT(64'h983870F0C0000000)) Fast_Adder_LUT4 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBL3x3[4])
        );

LUT6 #(.INIT(64'hE0C0800000000000)) Fast_Adder_LUT5 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBL3x3[5])
        );              


//AHBH3x3

wire [5:0] AHBH3x3;
LUT6_2 #(.INIT(64'h6AC06AC0A0A0A0A0)) Fast_Adder_LUT6 (
       .I0(d[3]), .I1(d[4]), .I2(c[3]), .I3(c[4]), .I4(1'b1), .I5(1'b1),
       .O6(AHBH3x3[1]), .O5(AHBH3x3[0])
       );

LUT6 #(.INIT(64'h1E665AAAB4CCF000)) FastLUT7 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBH3x3[2])
        );

LUT6 #(.INIT(64'h54B46CCC38F00000)) FastLUT8 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBH3x3[3])
        );

LUT6 #(.INIT(64'h983870F0C0000000)) FastLUT9 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBH3x3[4])
        );

LUT6 #(.INIT(64'hE0C0800000000000)) FastLUT10 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBH3x3[5])
        ); 
                            
//ALBH3x3
wire [5:0] ALBH3x3;
LUT6_2 #(.INIT(64'h6AC06AC0A0A0A0A0)) Fast_Adder_LUT11 (
      .I0(d[3]), .I1(d[4]), .I2(c[0]), .I3(c[1]), .I4(1'b1), .I5(1'b1),
      .O6(ALBH3x3[1]), .O5(ALBH3x3[0])
      );
      // assign  ALBH3x3[1:0] = {1'b0,1'b0};
LUT6 #(.INIT(64'h1E665AAAB4CCF000)) FastLUT12 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBH3x3[2])
        );

LUT6 #(.INIT(64'h54B46CCC38F00000)) FastLUT13 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBH3x3[3])
        );

LUT6 #(.INIT(64'h983870F0C0000000)) FastLUT14 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBH3x3[4])
        );

LUT6 #(.INIT(64'hE0C0800000000000)) FastLUT15 (
       .I0(d[3]), .I1(d[4]), .I2(d[5]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(ALBH3x3[5])
        ); 
        
//AHBL3x3
wire [5:0] AHBL3x3;
LUT6_2 #(.INIT(64'h6AC06AC0A0A0A0A0)) Fast_Adder_LUT16 (
       .I0(d[0]), .I1(d[1]), .I2(c[3]), .I3(c[4]), .I4(1'b1), .I5(1'b1),
       .O6(AHBL3x3[1]), .O5(AHBL3x3[0])
       );
 //assign  AHBL3x3[1:0] = {1'b0,1'b0};
LUT6 #(.INIT(64'h1E665AAAB4CCF000)) FastLUT17 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBL3x3[2])
        );

LUT6 #(.INIT(64'h54B46CCC38F00000)) FastLUT18 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBL3x3[3])
        );

LUT6 #(.INIT(64'h983870F0C0000000)) FastLUT19 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBL3x3[4])
        );

LUT6 #(.INIT(64'hE0C0800000000000)) FastLUT20 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[3]), .I4(c[4]), .I5(c[5]),
        .O(AHBL3x3[5])
        ); 
        
//final product
assign product[2:0] = ALBL3x3[2:0];
wire [5:0] carryout;
wire [4:0] sumout;
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT21 (
        .I0(AHBL3x3[0]), .I1(ALBH3x3[0]), .I2(ALBL3x3[3]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(carryout[0]), .O5(product[3])
        );
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT22 (
        .I0(AHBL3x3[1]), .I1(ALBH3x3[1]), .I2(ALBL3x3[4]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(carryout[1]), .O5(sumout[0])
        );
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT23 (
        .I0(AHBL3x3[2]), .I1(ALBH3x3[2]), .I2(ALBL3x3[5]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(carryout[2]), .O5(sumout[1])
        ); 
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT24 (
        .I0(AHBL3x3[3]), .I1(ALBH3x3[3]), .I2(AHBH3x3[0]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(carryout[3]), .O5(sumout[2])
        ); 
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT25 (
        .I0(AHBL3x3[4]), .I1(ALBH3x3[4]), .I2(AHBH3x3[1]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(carryout[4]), .O5(sumout[3])
        ); 
LUT6_2 #(.INIT(64'hE8E8E8E896969696)) Fast_Adder_LUT26 (
        .I0(AHBL3x3[5]), .I1(ALBH3x3[5]), .I2(AHBH3x3[2]), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(carryout[5]), .O5(sumout[4])
        );                             

parameter LUT_INIT = 64'h6666666688888888;
wire [7:0] cout;
wire [7:0] sum;
wire [7:0] ref1,ref2;
wire [7:0] gen, prop;
assign ref1 = {1'b0,1'b0,carryout[5:0]};
assign ref2 = {AHBH3x3[5:3],sumout[4:0]};
genvar i;
generate
for (i = 0; i < 8; i = i+1) begin
    LUT6_2 #(.INIT(LUT_INIT)) Fast_Adder_LUT (
        .I0(ref1[i]), .I1(ref2[i]), .I2(1'b1), .I3(1'b1), .I4(1'b1), .I5(1'b1),
        .O6(prop[i]), .O5(gen[i])
    );
end
endgenerate
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
assign product[11:4] = sum[7:0];
                                                           
endmodule
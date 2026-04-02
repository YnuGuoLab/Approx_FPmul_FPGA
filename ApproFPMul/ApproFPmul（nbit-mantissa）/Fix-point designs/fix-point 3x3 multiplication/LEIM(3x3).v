module Mantissa3x3 (
    input [2:0] c,
    input [2:0] d,
    output wire [5:0] cproduct
);

LUT6_2 #(.INIT(64'h6AC06AC0A0A0A0A0)) Fast_Adder_LUT1 (
        .I0(d[0]), .I1(d[1]), .I2(c[0]), .I3(c[1]), .I4(1'b1), .I5(1'b1),
        .O6(cproduct[1]), .O5(cproduct[0])
        );
        
LUT6 #(.INIT(64'h1E665AAAB4CCF000)) Fast_Adder_LUT2 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(cproduct[2])
        );
        
LUT6 #(.INIT(64'h54B46CCC38F00000)) Fast_Adder_LUT3 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(cproduct[3])
        );

LUT6 #(.INIT(64'h983870F0C0000000)) Fast_Adder_LUT4 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(cproduct[4])
        );

LUT6 #(.INIT(64'hE0C0800000000000)) Fast_Adder_LUT5 (
       .I0(d[0]), .I1(d[1]), .I2(d[2]), .I3(c[0]), .I4(c[1]), .I5(c[2]),
        .O(cproduct[5])
        );              
                                                               
endmodule
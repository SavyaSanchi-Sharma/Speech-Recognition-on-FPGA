`timescale 1ns / 1ps

module matrix_multiplication_tb;
    reg clk;
    reg [15:0] mfcc_features_flat_0, mfcc_features_flat_1;
    reg [15:0] mfcc_features_flat_2, mfcc_features_flat_3;
    reg [15:0] mfcc_features_flat_4, mfcc_features_flat_5;
    reg [15:0] mfcc_features_flat_6, mfcc_features_flat_7;
    reg [15:0] mfcc_features_flat_8, mfcc_features_flat_9;
    reg [15:0] mfcc_features_flat_10, mfcc_features_flat_11;
    reg [15:0] mfcc_features_flat_12, mfcc_features_flat_13;
    reg [15:0] mfcc_features_flat_14, mfcc_features_flat_15;
    reg [15:0] mfcc_features_flat_16, mfcc_features_flat_17;
    reg [15:0] mfcc_features_flat_18, mfcc_features_flat_19;
    reg [15:0] mfcc_features_flat_20, mfcc_features_flat_21;
    reg [15:0] mfcc_features_flat_22, mfcc_features_flat_23;
    reg [15:0] mfcc_features_flat_24, mfcc_features_flat_25;
    reg [15:0] mfcc_features_flat_26, mfcc_features_flat_27;
    reg [15:0] mfcc_features_flat_28, mfcc_features_flat_29;
    reg [15:0] mfcc_features_flat_30, mfcc_features_flat_31;
    reg [15:0] mfcc_features_flat_32, mfcc_features_flat_33;
    reg [15:0] mfcc_features_flat_34, mfcc_features_flat_35;
    reg [15:0] mfcc_features_flat_36, mfcc_features_flat_37;
    reg [15:0] mfcc_features_flat_38, mfcc_features_flat_39;

    wire signed [15:0] output_probabilities_flat_0, output_probabilities_flat_1;
    wire signed [15:0] output_probabilities_flat_2, output_probabilities_flat_3;
    wire signed [15:0] output_probabilities_flat_4, output_probabilities_flat_5;
    wire signed [15:0] output_probabilities_flat_6, output_probabilities_flat_7;

    // Instantiate the matrix_multiplication module
    matrix_multiplication uut (
        .clk(clk),
        .mfcc_features_flat_0(mfcc_features_flat_0), .mfcc_features_flat_1(mfcc_features_flat_1),
        .mfcc_features_flat_2(mfcc_features_flat_2), .mfcc_features_flat_3(mfcc_features_flat_3),
        .mfcc_features_flat_4(mfcc_features_flat_4), .mfcc_features_flat_5(mfcc_features_flat_5),
        .mfcc_features_flat_6(mfcc_features_flat_6), .mfcc_features_flat_7(mfcc_features_flat_7),
        .mfcc_features_flat_8(mfcc_features_flat_8), .mfcc_features_flat_9(mfcc_features_flat_9),
        .mfcc_features_flat_10(mfcc_features_flat_10), .mfcc_features_flat_11(mfcc_features_flat_11),
        .mfcc_features_flat_12(mfcc_features_flat_12), .mfcc_features_flat_13(mfcc_features_flat_13),
        .mfcc_features_flat_14(mfcc_features_flat_14), .mfcc_features_flat_15(mfcc_features_flat_15),
        .mfcc_features_flat_16(mfcc_features_flat_16), .mfcc_features_flat_17(mfcc_features_flat_17),
        .mfcc_features_flat_18(mfcc_features_flat_18), .mfcc_features_flat_19(mfcc_features_flat_19),
        .mfcc_features_flat_20(mfcc_features_flat_20), .mfcc_features_flat_21(mfcc_features_flat_21),
        .mfcc_features_flat_22(mfcc_features_flat_22), .mfcc_features_flat_23(mfcc_features_flat_23),
        .mfcc_features_flat_24(mfcc_features_flat_24), .mfcc_features_flat_25(mfcc_features_flat_25),
        .mfcc_features_flat_26(mfcc_features_flat_26), .mfcc_features_flat_27(mfcc_features_flat_27),
        .mfcc_features_flat_28(mfcc_features_flat_28), .mfcc_features_flat_29(mfcc_features_flat_29),
        .mfcc_features_flat_30(mfcc_features_flat_30), .mfcc_features_flat_31(mfcc_features_flat_31),
        .mfcc_features_flat_32(mfcc_features_flat_32), .mfcc_features_flat_33(mfcc_features_flat_33),
        .mfcc_features_flat_34(mfcc_features_flat_34), .mfcc_features_flat_35(mfcc_features_flat_35),
        .mfcc_features_flat_36(mfcc_features_flat_36), .mfcc_features_flat_37(mfcc_features_flat_37),
        .mfcc_features_flat_38(mfcc_features_flat_38), .mfcc_features_flat_39(mfcc_features_flat_39),
        .output_probabilities_flat_0(output_probabilities_flat_0),
        .output_probabilities_flat_1(output_probabilities_flat_1),
        .output_probabilities_flat_2(output_probabilities_flat_2),
        .output_probabilities_flat_3(output_probabilities_flat_3),
        .output_probabilities_flat_4(output_probabilities_flat_4),
        .output_probabilities_flat_5(output_probabilities_flat_5),
        .output_probabilities_flat_6(output_probabilities_flat_6),
        .output_probabilities_flat_7(output_probabilities_flat_7)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock (10ns period)

    initial begin
        // Initialize
        clk = 0;
        mfcc_features_flat_0 = 16'd10; mfcc_features_flat_1 = 16'd20;
        mfcc_features_flat_2 = 16'd30; mfcc_features_flat_3 = 16'd40;
        mfcc_features_flat_4 = 16'd50; mfcc_features_flat_5 = 16'd60;
        mfcc_features_flat_6 = 16'd70; mfcc_features_flat_7 = 16'd80;
        mfcc_features_flat_8 = 16'd90; mfcc_features_flat_9 = 16'd100;
        mfcc_features_flat_10 = 16'd110; mfcc_features_flat_11 = 16'd120;
        mfcc_features_flat_12 = 16'd130; mfcc_features_flat_13 = 16'd140;
        mfcc_features_flat_14 = 16'd150; mfcc_features_flat_15 = 16'd160;
        mfcc_features_flat_16 = 16'd170; mfcc_features_flat_17 = 16'd180;
        mfcc_features_flat_18 = 16'd190; mfcc_features_flat_19 = 16'd200;
        mfcc_features_flat_20 = 16'd210; mfcc_features_flat_21 = 16'd220;
        mfcc_features_flat_22 = 16'd230; mfcc_features_flat_23 = 16'd240;
        mfcc_features_flat_24 = 16'd250; mfcc_features_flat_25 = 16'd260;
        mfcc_features_flat_26 = 16'd270; mfcc_features_flat_27 = 16'd280;
        mfcc_features_flat_28 = 16'd290; mfcc_features_flat_29 = 16'd300;
        mfcc_features_flat_30 = 16'd310; mfcc_features_flat_31 = 16'd320;
        mfcc_features_flat_32 = 16'd330; mfcc_features_flat_33 = 16'd340;
        mfcc_features_flat_34 = 16'd350; mfcc_features_flat_35 = 16'd360;
        mfcc_features_flat_36 = 16'd370; mfcc_features_flat_37 = 16'd380;
        mfcc_features_flat_38 = 16'd390; mfcc_features_flat_39 = 16'd400;

        // Let the module process the inputs
        #100;

        // Stop simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %t | P_0 = %d | P_1 = %d | P_2 = %d | P_3 = %d | P_4 = %d | P_5 = %d | P_6 = %d | P_7 = %d",
                 $time, output_probabilities_flat_0, output_probabilities_flat_1,
                 output_probabilities_flat_2, output_probabilities_flat_3,
                 output_probabilities_flat_4, output_probabilities_flat_5,
                 output_probabilities_flat_6, output_probabilities_flat_7);
    end
endmodule

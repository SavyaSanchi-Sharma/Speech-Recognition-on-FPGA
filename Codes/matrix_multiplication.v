module matrix_multiplication (
    input wire clk,
    input wire [15:0] mfcc_features_flat_0, input wire [15:0] mfcc_features_flat_1,
    input wire [15:0] mfcc_features_flat_2, input wire [15:0] mfcc_features_flat_3,
    input wire [15:0] mfcc_features_flat_4, input wire [15:0] mfcc_features_flat_5,
    input wire [15:0] mfcc_features_flat_6, input wire [15:0] mfcc_features_flat_7,
    input wire [15:0] mfcc_features_flat_8, input wire [15:0] mfcc_features_flat_9,
    input wire [15:0] mfcc_features_flat_10, input wire [15:0] mfcc_features_flat_11,
    input wire [15:0] mfcc_features_flat_12, input wire [15:0] mfcc_features_flat_13,
    input wire [15:0] mfcc_features_flat_14, input wire [15:0] mfcc_features_flat_15,
    input wire [15:0] mfcc_features_flat_16, input wire [15:0] mfcc_features_flat_17,
    input wire [15:0] mfcc_features_flat_18, input wire [15:0] mfcc_features_flat_19,
    input wire [15:0] mfcc_features_flat_20, input wire [15:0] mfcc_features_flat_21,
    input wire [15:0] mfcc_features_flat_22, input wire [15:0] mfcc_features_flat_23,
    input wire [15:0] mfcc_features_flat_24, input wire [15:0] mfcc_features_flat_25,
    input wire [15:0] mfcc_features_flat_26, input wire [15:0] mfcc_features_flat_27,
    input wire [15:0] mfcc_features_flat_28, input wire [15:0] mfcc_features_flat_29,
    input wire [15:0] mfcc_features_flat_30, input wire [15:0] mfcc_features_flat_31,
    input wire [15:0] mfcc_features_flat_32, input wire [15:0] mfcc_features_flat_33,
    input wire [15:0] mfcc_features_flat_34, input wire [15:0] mfcc_features_flat_35,
    input wire [15:0] mfcc_features_flat_36, input wire [15:0] mfcc_features_flat_37,
    input wire [15:0] mfcc_features_flat_38, input wire [15:0] mfcc_features_flat_39,
    output reg signed [15:0] output_probabilities_flat_0, output reg signed [15:0] output_probabilities_flat_1,
    output reg signed [15:0] output_probabilities_flat_2, output reg signed [15:0] output_probabilities_flat_3,
    output reg signed [15:0] output_probabilities_flat_4, output reg signed [15:0] output_probabilities_flat_5,
    output reg signed [15:0] output_probabilities_flat_6, output reg signed [15:0] output_probabilities_flat_7
);

    reg signed [15:0] mfcc_features [0:39];
    reg signed [15:0] output_probabilities [0:7];
    reg signed [15:0] weights_flat [0:(8*40)-1];  // 40 features per neuron, 8 neurons
    reg signed [15:0] biases [0:7];
    integer i, j;

    initial begin
        $readmemh("weights.mem", weights_flat);
        $readmemh("biases.mem", biases);
    end

    always @(posedge clk) begin
        // Load MFCC features into an array
        mfcc_features[0] = mfcc_features_flat_0; mfcc_features[1] = mfcc_features_flat_1;
        mfcc_features[2] = mfcc_features_flat_2; mfcc_features[3] = mfcc_features_flat_3;
        mfcc_features[4] = mfcc_features_flat_4; mfcc_features[5] = mfcc_features_flat_5;
        mfcc_features[6] = mfcc_features_flat_6; mfcc_features[7] = mfcc_features_flat_7;
        mfcc_features[8] = mfcc_features_flat_8; mfcc_features[9] = mfcc_features_flat_9;
        mfcc_features[10] = mfcc_features_flat_10; mfcc_features[11] = mfcc_features_flat_11;
        mfcc_features[12] = mfcc_features_flat_12; mfcc_features[13] = mfcc_features_flat_13;
        mfcc_features[14] = mfcc_features_flat_14; mfcc_features[15] = mfcc_features_flat_15;
        mfcc_features[16] = mfcc_features_flat_16; mfcc_features[17] = mfcc_features_flat_17;
        mfcc_features[18] = mfcc_features_flat_18; mfcc_features[19] = mfcc_features_flat_19;
        mfcc_features[20] = mfcc_features_flat_20; mfcc_features[21] = mfcc_features_flat_21;
        mfcc_features[22] = mfcc_features_flat_22; mfcc_features[23] = mfcc_features_flat_23;
        mfcc_features[24] = mfcc_features_flat_24; mfcc_features[25] = mfcc_features_flat_25;
        mfcc_features[26] = mfcc_features_flat_26; mfcc_features[27] = mfcc_features_flat_27;
        mfcc_features[28] = mfcc_features_flat_28; mfcc_features[29] = mfcc_features_flat_29;
        mfcc_features[30] = mfcc_features_flat_30; mfcc_features[31] = mfcc_features_flat_31;
        mfcc_features[32] = mfcc_features_flat_32; mfcc_features[33] = mfcc_features_flat_33;
        mfcc_features[34] = mfcc_features_flat_34; mfcc_features[35] = mfcc_features_flat_35;
        mfcc_features[36] = mfcc_features_flat_36; mfcc_features[37] = mfcc_features_flat_37;
        mfcc_features[38] = mfcc_features_flat_38; mfcc_features[39] = mfcc_features_flat_39;

        // Compute neuron activations
        for (i = 0; i < 8; i = i + 1) begin
            output_probabilities[i] = biases[i];  // Start with bias
            for (j = 0; j < 40; j = j + 1) begin
                output_probabilities[i] = output_probabilities[i] + ((mfcc_features[j] * weights_flat[i * 40 + j]) >>> 15);
            end
        end

        // Assign output probabilities
        output_probabilities_flat_0 = output_probabilities[0];
        output_probabilities_flat_1 = output_probabilities[1];
        output_probabilities_flat_2 = output_probabilities[2];
        output_probabilities_flat_3 = output_probabilities[3];
        output_probabilities_flat_4 = output_probabilities[4];
        output_probabilities_flat_5 = output_probabilities[5];
        output_probabilities_flat_6 = output_probabilities[6];
        output_probabilities_flat_7 = output_probabilities[7];
    end

endmodule

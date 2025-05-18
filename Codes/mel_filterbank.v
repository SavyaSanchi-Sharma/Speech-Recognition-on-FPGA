module mel_filterbank (
    input wire clk,
    input wire rst,
    input wire [15:0] fft_output_0, input wire [15:0] fft_output_1,
    input wire [15:0] fft_output_2, input wire [15:0] fft_output_3,
    input wire [15:0] fft_output_4, input wire [15:0] fft_output_5,
    input wire [15:0] fft_output_6, input wire [15:0] fft_output_7,
    input wire [15:0] fft_output_8, input wire [15:0] fft_output_9,
    input wire [15:0] fft_output_10, input wire [15:0] fft_output_11,
    input wire [15:0] fft_output_12, input wire [15:0] fft_output_13,
    input wire [15:0] fft_output_14, input wire [15:0] fft_output_15,
    output reg [15:0] mel_features_0, output reg [15:0] mel_features_1,
    output reg [15:0] mel_features_2, output reg [15:0] mel_features_3,
    output reg [15:0] mel_features_4, output reg [15:0] mel_features_5,
    output reg [15:0] mel_features_6, output reg [15:0] mel_features_7,
    output reg [15:0] mel_features_8, output reg [15:0] mel_features_9,
    output reg [15:0] mel_features_10, output reg [15:0] mel_features_11,
    output reg [15:0] mel_features_12
);

    reg signed [15:0] fft_output [0:15];
    reg signed [15:0] mel_features [0:12];
    reg signed [15:0] mel_filter [0:15][0:12];  // 16 FFT bins to 13 Mel bands mapping
    integer i, j;

    initial begin
        $readmemh("mel_filter.mem", mel_filter);  // Load filter coefficients
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 13; i = i + 1) begin
                mel_features[i] <= 0;
            end
        end else begin
            // Load FFT Outputs into array
            fft_output[0] = fft_output_0; fft_output[1] = fft_output_1;
            fft_output[2] = fft_output_2; fft_output[3] = fft_output_3;
            fft_output[4] = fft_output_4; fft_output[5] = fft_output_5;
            fft_output[6] = fft_output_6; fft_output[7] = fft_output_7;
            fft_output[8] = fft_output_8; fft_output[9] = fft_output_9;
            fft_output[10] = fft_output_10; fft_output[11] = fft_output_11;
            fft_output[12] = fft_output_12; fft_output[13] = fft_output_13;
            fft_output[14] = fft_output_14; fft_output[15] = fft_output_15;

            // Apply Mel Filter Bank
            for (i = 0; i < 13; i = i + 1) begin
                mel_features[i] = 0;
                for (j = 0; j < 16; j = j + 1) begin
                    mel_features[i] = mel_features[i] + ((fft_output[j] * mel_filter[j][i]) >>> 8);
                end
            end

            // Assign output registers
            mel_features_0 = mel_features[0]; mel_features_1 = mel_features[1];
            mel_features_2 = mel_features[2]; mel_features_3 = mel_features[3];
            mel_features_4 = mel_features[4]; mel_features_5 = mel_features[5];
            mel_features_6 = mel_features[6]; mel_features_7 = mel_features[7];
            mel_features_8 = mel_features[8]; mel_features_9 = mel_features[9];
            mel_features_10 = mel_features[10]; mel_features_11 = mel_features[11];
            mel_features_12 = mel_features[12];
        end
    end

endmodule

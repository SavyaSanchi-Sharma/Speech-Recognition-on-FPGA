// Top Module (Keyword Detection System)
module top_module (
    input wire clk,
    input wire rst,
    output wire [3:0] keyword_id, // Detected keyword
   
    output reg led_r,  // Red LED
    output reg led_g,  // Green LED
    output reg led_b   // Blue LED

    );
    wire [15:0] audio_processed;
    wire [15:0] fft_input;
    wire [15:0] fft_out_0, fft_out_1, fft_out_2, fft_out_3;
    wire [15:0] fft_out_4, fft_out_5, fft_out_6, fft_out_7;
    wire [15:0] fft_out_8, fft_out_9, fft_out_10, fft_out_11;
    wire [15:0] fft_out_12, fft_out_13, fft_out_14, fft_out_15;

    wire [15:0] mel_out_0, mel_out_1, mel_out_2, mel_out_3;
    wire [15:0] mel_out_4, mel_out_5, mel_out_6, mel_out_7;
    wire [15:0] mel_out_8, mel_out_9, mel_out_10, mel_out_11, mel_out_12;


    wire [15:0] relu_out_0, relu_out_1, relu_out_2, relu_out_3;
    wire [15:0] relu_out_4, relu_out_5, relu_out_6, relu_out_7;

    wire [15:0] nn_out_0, nn_out_1, nn_out_2, nn_out_3;
    wire [15:0] nn_out_4, nn_out_5, nn_out_6, nn_out_7;

    wire [15:0] softmax_out_0, softmax_out_1, softmax_out_2, softmax_out_3;
    wire [15:0] softmax_out_4, softmax_out_5, softmax_out_6, softmax_out_7;

    wire debounce_keyword_id;

    // Preprocessing Module (Pre-emphasis & Hamming Window)
   preprocessing preprocess_inst (
    .clk(clk),
    .rst(rst),
    .audio_out(fft_input)  // Sending audio sample to FFT
);

    
  

    // FFT Module
    fft fft_inst (
        .clk(clk),
        .audio_in(fft_input),
        .fft_output_0(fft_out_0), .fft_output_1(fft_out_1),
        .fft_output_2(fft_out_2), .fft_output_3(fft_out_3),
        .fft_output_4(fft_out_4), .fft_output_5(fft_out_5),
        .fft_output_6(fft_out_6), .fft_output_7(fft_out_7),
        .fft_output_8(fft_out_8), .fft_output_9(fft_out_9),
        .fft_output_10(fft_out_10), .fft_output_11(fft_out_11),
        .fft_output_12(fft_out_12), .fft_output_13(fft_out_13),
        .fft_output_14(fft_out_14), .fft_output_15(fft_out_15)
    );

    // Mel Filterbank Module
    mel_filterbank mel_inst (
        .clk(clk), .rst(rst),
        .fft_output_0(fft_out_0), .fft_output_1(fft_out_1),
        .fft_output_2(fft_out_2), .fft_output_3(fft_out_3),
        .fft_output_4(fft_out_4), .fft_output_5(fft_out_5),
        .fft_output_6(fft_out_6), .fft_output_7(fft_out_7),
        .fft_output_8(fft_out_8), .fft_output_9(fft_out_9),
        .fft_output_10(fft_out_10), .fft_output_11(fft_out_11),
        .fft_output_12(fft_out_12), .fft_output_13(fft_out_13),
        .fft_output_14(fft_out_14), .fft_output_15(fft_out_15),
        .mel_features_0(mel_out_0), .mel_features_1(mel_out_1),
        .mel_features_2(mel_out_2), .mel_features_3(mel_out_3),
        .mel_features_4(mel_out_4), .mel_features_5(mel_out_5),
        .mel_features_6(mel_out_6), .mel_features_7(mel_out_7),
        .mel_features_8(mel_out_8), .mel_features_9(mel_out_9),
        .mel_features_10(mel_out_10), .mel_features_11(mel_out_11),
        .mel_features_12(mel_out_12)
    );

    // Neural Network Module
   matrix_multiplication nn_inst (
    .clk(clk),

    // Existing connections:
    .mfcc_features_flat_0(mel_out_0), .mfcc_features_flat_1(mel_out_1),
    .mfcc_features_flat_2(mel_out_2), .mfcc_features_flat_3(mel_out_3),
    .mfcc_features_flat_4(mel_out_4), .mfcc_features_flat_5(mel_out_5),
    .mfcc_features_flat_6(mel_out_6), .mfcc_features_flat_7(mel_out_7),
    .mfcc_features_flat_8(mel_out_8), .mfcc_features_flat_9(mel_out_9),
    .mfcc_features_flat_10(mel_out_10), .mfcc_features_flat_11(mel_out_11),
    .mfcc_features_flat_12(mel_out_12),

    // Missing connections, temporarily set to zero:
    .mfcc_features_flat_13(16'd0), .mfcc_features_flat_14(16'd0),
    .mfcc_features_flat_15(16'd0), .mfcc_features_flat_16(16'd0),
    .mfcc_features_flat_17(16'd0), .mfcc_features_flat_18(16'd0),
    .mfcc_features_flat_19(16'd0), .mfcc_features_flat_20(16'd0),
    .mfcc_features_flat_21(16'd0), .mfcc_features_flat_22(16'd0),
    .mfcc_features_flat_23(16'd0), .mfcc_features_flat_24(16'd0),
    .mfcc_features_flat_25(16'd0), .mfcc_features_flat_26(16'd0),
    .mfcc_features_flat_27(16'd0), .mfcc_features_flat_28(16'd0),
    .mfcc_features_flat_29(16'd0), .mfcc_features_flat_30(16'd0),
    .mfcc_features_flat_31(16'd0), .mfcc_features_flat_32(16'd0),
    .mfcc_features_flat_33(16'd0), .mfcc_features_flat_34(16'd0),
    .mfcc_features_flat_35(16'd0), .mfcc_features_flat_36(16'd0),
    .mfcc_features_flat_37(16'd0), .mfcc_features_flat_38(16'd0),
    .mfcc_features_flat_39(16'd0),

    // Outputs remain as before:
    .output_probabilities_flat_0(nn_out_0), .output_probabilities_flat_1(nn_out_1),
    .output_probabilities_flat_2(nn_out_2), .output_probabilities_flat_3(nn_out_3),
    .output_probabilities_flat_4(nn_out_4), .output_probabilities_flat_5(nn_out_5),
    .output_probabilities_flat_6(nn_out_6), .output_probabilities_flat_7(nn_out_7)
);



    // Instantiate ReLU Activation Module
    // Corrected top_module instantiation
    relu relu_inst_0(.clk(clk), .nn_input(nn_input_0), .relu_output(relu_output_0));
    relu relu_inst_1(.clk(clk), .nn_input(nn_input_1), .relu_output(relu_output_1));
    relu relu_inst_2(.clk(clk), .nn_input(nn_input_2), .relu_output(relu_output_2));
    relu relu_inst_3(.clk(clk), .nn_input(nn_input_3), .relu_output(relu_output_3));
    relu relu_inst_4(.clk(clk), .nn_input(nn_input_4), .relu_output(relu_output_4));
    relu relu_inst_5(.clk(clk), .nn_input(nn_input_5), .relu_output(relu_output_5));
    relu relu_inst_6(.clk(clk), .nn_input(nn_input_6), .relu_output(relu_output_6));
    relu relu_inst_7(.clk(clk), .nn_input(nn_input_7), .relu_output(relu_output_7));



    // Instantiate Softmax Module
    softmax_lut softmax_inst (
        .clk(clk),
        .input_values_0(nn_out_0), .input_values_1(nn_out_1),
        .input_values_2(nn_out_2), .input_values_3(nn_out_3),
        .input_values_4(nn_out_4), .input_values_5(nn_out_5),
        .input_values_6(nn_out_6), .input_values_7(nn_out_7),
        .output_probabilities_0(softmax_out_0), .output_probabilities_1(softmax_out_1),
        .output_probabilities_2(softmax_out_2), .output_probabilities_3(softmax_out_3),
        .output_probabilities_4(softmax_out_4), .output_probabilities_5(softmax_out_5),
        .output_probabilities_6(softmax_out_6), .output_probabilities_7(softmax_out_7)
    );


    // Postprocessing (Debouncing)
    debounce debounce_inst (
        .clk(clk),
        .rst(rst),
        .keyword_input(keyword_id),
        .keyword_output(debounce_keyword_id)
    );

//     // UART Transmission
//     // Updated UART instantiation (Output to File)
//  // UART Transmission (Now Only Saves to File)
//     uart_tx uart_transmitter (
//       .clk(clk),
//       .rst(rst),
//       .data_in(uart_data),
//       .send(uart_send),
//       .tx(tx),
//       .busy(uart_busy)
//     );


always @(posedge clk or posedge rst) begin
    if (rst) begin
        led_r <= 0;
        led_g <= 0;
        led_b <= 0;
    end else begin
        case (keyword_id)
            4'd0: {led_r, led_g, led_b} <= 3'b000;  // OFF → Up
            4'd1: {led_r, led_g, led_b} <= 3'b100;  // RED → Down
            4'd2: {led_r, led_g, led_b} <= 3'b010;  // GREEN → Right
            4'd3: {led_r, led_g, led_b} <= 3'b001;  // BLUE → Left
            4'd4: {led_r, led_g, led_b} <= 3'b110;  // YELLOW → Stop
            4'd5: {led_r, led_g, led_b} <= 3'b011;  // CYAN → Go
            4'd6: {led_r, led_g, led_b} <= 3'b101;  // MAGENTA → Dharwad
            4'd7: {led_r, led_g, led_b} <= 3'b111;  // WHITE → Hubli
            4'd8: {led_r, led_g, led_b} <= clk ? 3'b100 : 3'b000; // BLINKING RED → IIIT
            4'd9: {led_r, led_g, led_b} <= clk ? 3'b010 : 3'b000; // BLINKING GREEN → HackMaze
            default: {led_r, led_g, led_b} <= 3'b000;  // Default OFF
        endcase
    end
end


     // Classification (Select highest probability output)
    assign keyword_id = ( $unsigned(softmax_out_0) >= $unsigned(softmax_out_1) &&
                      $unsigned(softmax_out_0) >= $unsigned(softmax_out_2) &&
                      $unsigned(softmax_out_0) >= $unsigned(softmax_out_3) &&
                      $unsigned(softmax_out_0) >= $unsigned(softmax_out_4) &&
                      $unsigned(softmax_out_0) >= $unsigned(softmax_out_5) &&
                      $unsigned(softmax_out_0) >= $unsigned(softmax_out_6) &&
                      $unsigned(softmax_out_0) >= $unsigned(softmax_out_7) ) ? 4'd0 :
                    ( $unsigned(softmax_out_1) >= $unsigned(softmax_out_2) &&
                      $unsigned(softmax_out_1) >= $unsigned(softmax_out_3) &&
                      $unsigned(softmax_out_1) >= $unsigned(softmax_out_4) &&
                      $unsigned(softmax_out_1) >= $unsigned(softmax_out_5) &&
                      $unsigned(softmax_out_1) >= $unsigned(softmax_out_6) &&
                      $unsigned(softmax_out_1) >= $unsigned(softmax_out_7) ) ? 4'd1 :
                    ( $unsigned(softmax_out_2) >= $unsigned(softmax_out_3) &&
                      $unsigned(softmax_out_2) >= $unsigned(softmax_out_4) &&
                      $unsigned(softmax_out_2) >= $unsigned(softmax_out_5) &&
                      $unsigned(softmax_out_2) >= $unsigned(softmax_out_6) &&
                      $unsigned(softmax_out_2) >= $unsigned(softmax_out_7) ) ? 4'd2 :
                    ( $unsigned(softmax_out_3) >= $unsigned(softmax_out_4) &&
                      $unsigned(softmax_out_3) >= $unsigned(softmax_out_5) &&
                      $unsigned(softmax_out_3) >= $unsigned(softmax_out_6) &&
                      $unsigned(softmax_out_3) >= $unsigned(softmax_out_7) ) ? 4'd3 :
                    ( $unsigned(softmax_out_4) >= $unsigned(softmax_out_5) &&
                      $unsigned(softmax_out_4) >= $unsigned(softmax_out_6) &&
                      $unsigned(softmax_out_4) >= $unsigned(softmax_out_7) ) ? 4'd4 :
                    ( $unsigned(softmax_out_5) >= $unsigned(softmax_out_6) &&
                      $unsigned(softmax_out_5) >= $unsigned(softmax_out_7) ) ? 4'd5 :
                    ( $unsigned(softmax_out_6) >= $unsigned(softmax_out_7) ) ? 4'd6 : 4'd7;



endmodule

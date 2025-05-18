`timescale 1ns / 1ps

module tb_mel_filterbank;

    reg clk;
    reg rst;
    reg [15:0] fft_output_0, fft_output_1, fft_output_2, fft_output_3;
    reg [15:0] fft_output_4, fft_output_5, fft_output_6, fft_output_7;
    reg [15:0] fft_output_8, fft_output_9, fft_output_10, fft_output_11;
    reg [15:0] fft_output_12, fft_output_13, fft_output_14, fft_output_15;

    wire [15:0] mel_features_0, mel_features_1, mel_features_2, mel_features_3;
    wire [15:0] mel_features_4, mel_features_5, mel_features_6, mel_features_7;
    wire [15:0] mel_features_8, mel_features_9, mel_features_10, mel_features_11, mel_features_12;

    // Instantiate the Unit Under Test (UUT)
    mel_filterbank uut (
        .clk(clk),
        .rst(rst),
        .fft_output_0(fft_output_0), .fft_output_1(fft_output_1),
        .fft_output_2(fft_output_2), .fft_output_3(fft_output_3),
        .fft_output_4(fft_output_4), .fft_output_5(fft_output_5),
        .fft_output_6(fft_output_6), .fft_output_7(fft_output_7),
        .fft_output_8(fft_output_8), .fft_output_9(fft_output_9),
        .fft_output_10(fft_output_10), .fft_output_11(fft_output_11),
        .fft_output_12(fft_output_12), .fft_output_13(fft_output_13),
        .fft_output_14(fft_output_14), .fft_output_15(fft_output_15),
        .mel_features_0(mel_features_0), .mel_features_1(mel_features_1),
        .mel_features_2(mel_features_2), .mel_features_3(mel_features_3),
        .mel_features_4(mel_features_4), .mel_features_5(mel_features_5),
        .mel_features_6(mel_features_6), .mel_features_7(mel_features_7),
        .mel_features_8(mel_features_8), .mel_features_9(mel_features_9),
        .mel_features_10(mel_features_10), .mel_features_11(mel_features_11),
        .mel_features_12(mel_features_12)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period (100MHz)

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        fft_output_0 = 16'd0; fft_output_1 = 16'd0; fft_output_2 = 16'd0; fft_output_3 = 16'd0;
        fft_output_4 = 16'd0; fft_output_5 = 16'd0; fft_output_6 = 16'd0; fft_output_7 = 16'd0;
        fft_output_8 = 16'd0; fft_output_9 = 16'd0; fft_output_10 = 16'd0; fft_output_11 = 16'd0;
        fft_output_12 = 16'd0; fft_output_13 = 16'd0; fft_output_14 = 16'd0; fft_output_15 = 16'd0;

        #20 rst = 0;  // Release reset

        // Apply sample FFT outputs (simulate frequency bins)
        #10 fft_output_0 = 16'd100; fft_output_1 = 16'd200;
        #10 fft_output_2 = 16'd300; fft_output_3 = 16'd400;
        #10 fft_output_4 = 16'd500; fft_output_5 = 16'd600;
        #10 fft_output_6 = 16'd700; fft_output_7 = 16'd800;
        #10 fft_output_8 = 16'd900; fft_output_9 = 16'd1000;
        #10 fft_output_10 = 16'd1100; fft_output_11 = 16'd1200;
        #10 fft_output_12 = 16'd1300; fft_output_13 = 16'd1400;
        #10 fft_output_14 = 16'd1500; fft_output_15 = 16'd1600;

        #50; // Wait for results

        // Display results
        $display("Mel Features Output:");
        $display("Mel[0] = %d", mel_features_0);
        $display("Mel[1] = %d", mel_features_1);
        $display("Mel[2] = %d", mel_features_2);
        $display("Mel[3] = %d", mel_features_3);
        $display("Mel[4] = %d", mel_features_4);
        $display("Mel[5] = %d", mel_features_5);
        $display("Mel[6] = %d", mel_features_6);
        $display("Mel[7] = %d", mel_features_7);
        $display("Mel[8] = %d", mel_features_8);
        $display("Mel[9] = %d", mel_features_9);
        $display("Mel[10] = %d", mel_features_10);
        $display("Mel[11] = %d", mel_features_11);
        $display("Mel[12] = %d", mel_features_12);

        $stop;
    end
endmodule

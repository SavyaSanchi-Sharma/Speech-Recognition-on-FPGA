`timescale 1ns / 1ps

module fft_tb;
    reg clk;
    reg [15:0] audio_in;
    wire [15:0] fft_output_0, fft_output_1, fft_output_2, fft_output_3;
    wire [15:0] fft_output_4, fft_output_5, fft_output_6, fft_output_7;
    wire [15:0] fft_output_8, fft_output_9, fft_output_10, fft_output_11;
    wire [15:0] fft_output_12, fft_output_13, fft_output_14, fft_output_15;

    // Instantiate the FFT module
    fft uut (
        .clk(clk),
        .audio_in(audio_in),
        .fft_output_0(fft_output_0), .fft_output_1(fft_output_1),
        .fft_output_2(fft_output_2), .fft_output_3(fft_output_3),
        .fft_output_4(fft_output_4), .fft_output_5(fft_output_5),
        .fft_output_6(fft_output_6), .fft_output_7(fft_output_7),
        .fft_output_8(fft_output_8), .fft_output_9(fft_output_9),
        .fft_output_10(fft_output_10), .fft_output_11(fft_output_11),
        .fft_output_12(fft_output_12), .fft_output_13(fft_output_13),
        .fft_output_14(fft_output_14), .fft_output_15(fft_output_15)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock (10ns period)

    initial begin
        // Initialize
        clk = 0;
        audio_in = 16'd0;
        #10;

        // Apply test inputs
        audio_in = 16'd100; #10;
        audio_in = 16'd200; #10;
        audio_in = -16'd50; #10;
        audio_in = 16'd75; #10;
        audio_in = 16'd125; #10;
        audio_in = -16'd90; #10;
        audio_in = 16'd300; #10;
        audio_in = -16'd100; #10;
        audio_in = 16'd50; #10;
        audio_in = -16'd25; #10;
        audio_in = 16'd200; #10;
        audio_in = -16'd60; #10;
        audio_in = 16'd150; #10;
        audio_in = -16'd40; #10;
        audio_in = 16'd120; #10;
        audio_in = 16'd180; #10;

        // Let it run for a while to observe FFT outputs
        #200;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %t | Input = %d | FFT[0] = %d | FFT[1] = %d | FFT[2] = %d | FFT[3] = %d",
                 $time, audio_in, fft_output_0, fft_output_1, fft_output_2, fft_output_3);
    end
endmodule

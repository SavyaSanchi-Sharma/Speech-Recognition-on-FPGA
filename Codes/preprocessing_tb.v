`timescale 1ns / 1ps

module preprocessing_tb;
    reg clk;
    reg rst;
    wire signed [15:0] audio_out;

    // Instantiate the preprocessing module
    preprocessing uut (
        .clk(clk),
        .rst(rst),
        .audio_out(audio_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock (10ns period)

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        #10;
        rst = 0;

        // Run the simulation for a while
        #1000;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %t, audio_out = %d", $time, audio_out);
    end
endmodule

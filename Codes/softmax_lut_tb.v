`timescale 1ns / 1ps

module softmax_lut_tb;

    reg clk;
    reg signed [15:0] input_values_0, input_values_1;
    reg signed [15:0] input_values_2, input_values_3;
    reg signed [15:0] input_values_4, input_values_5;
    reg signed [15:0] input_values_6, input_values_7;

    wire signed [15:0] output_probabilities_0, output_probabilities_1;
    wire signed [15:0] output_probabilities_2, output_probabilities_3;
    wire signed [15:0] output_probabilities_4, output_probabilities_5;
    wire signed [15:0] output_probabilities_6, output_probabilities_7;

    // Instantiate the Unit Under Test (UUT)
    softmax_lut uut (
        .clk(clk),
        .input_values_0(input_values_0), .input_values_1(input_values_1),
        .input_values_2(input_values_2), .input_values_3(input_values_3),
        .input_values_4(input_values_4), .input_values_5(input_values_5),
        .input_values_6(input_values_6), .input_values_7(input_values_7),
        .output_probabilities_0(output_probabilities_0), .output_probabilities_1(output_probabilities_1),
        .output_probabilities_2(output_probabilities_2), .output_probabilities_3(output_probabilities_3),
        .output_probabilities_4(output_probabilities_4), .output_probabilities_5(output_probabilities_5),
        .output_probabilities_6(output_probabilities_6), .output_probabilities_7(output_probabilities_7)
    );

    // Clock generation (10ns period => 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize clock
        clk = 0;

        // Apply test cases
        #10 input_values_0 = 16'sd1000; input_values_1 = 16'sd2000;
            input_values_2 = 16'sd1500; input_values_3 = 16'sd1800;
            input_values_4 = 16'sd2200; input_values_5 = 16'sd1700;
            input_values_6 = 16'sd900;  input_values_7 = 16'sd800;

        #10 input_values_0 = 16'sd3000; input_values_1 = 16'sd3100;
            input_values_2 = 16'sd2800; input_values_3 = 16'sd2900;
            input_values_4 = 16'sd3200; input_values_5 = 16'sd2700;
            input_values_6 = 16'sd2600; input_values_7 = 16'sd2500;

        #10 input_values_0 = -16'sd500; input_values_1 = -16'sd100;
            input_values_2 = -16'sd200; input_values_3 = -16'sd300;
            input_values_4 = -16'sd150; input_values_5 = -16'sd250;
            input_values_6 = -16'sd50;  input_values_7 = -16'sd600;

        #10 input_values_0 = 16'sd0; input_values_1 = 16'sd0;
            input_values_2 = 16'sd0; input_values_3 = 16'sd0;
            input_values_4 = 16'sd0; input_values_5 = 16'sd0;
            input_values_6 = 16'sd0; input_values_7 = 16'sd0;

        #50; // Allow time for results to stabilize

        // Display test results
        $display("Softmax LUT Test Results:");
        $display("Input Set 1: %d, %d, %d, %d, %d, %d, %d, %d", input_values_0, input_values_1, input_values_2, input_values_3, input_values_4, input_values_5, input_values_6, input_values_7);
        $display("Output Set 1: %d, %d, %d, %d, %d, %d, %d, %d", output_probabilities_0, output_probabilities_1, output_probabilities_2, output_probabilities_3, output_probabilities_4, output_probabilities_5, output_probabilities_6, output_probabilities_7);
        
        #10 $stop; // End simulation
    end

endmodule

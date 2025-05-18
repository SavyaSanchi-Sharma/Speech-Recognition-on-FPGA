`timescale 1ns / 1ps

module relu_tb;

    reg clk;
    reg signed [15:0] nn_input;  // Signed input
    wire signed [15:0] relu_output; // Signed output from DUT

    // Instantiate the Unit Under Test (UUT)
    relu uut (
        .clk(clk),
        .nn_input(nn_input),
        .relu_output(relu_output)
    );

    // Clock generation (10ns period => 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize clock and inputs
        clk = 0;
        nn_input = 16'sd0; 

        // Apply test cases
       #10 nn_input = 16'sd32767;     // Maximum positive value
        #10 nn_input = -16'sd32768;    // Maximum negative value (corrected syntax)
        #10 nn_input = 16'sd1234;      // Positive value
       #10 nn_input = -16'sd1234;     // Negative value
        #10 nn_input = 16'sd0;         // Zero (optional)

        #50; // Allow enough time for results to settle

        // Display test results
        $display("ReLU Test Results:");
        $display("Input: 100  => Output: %d", relu_output);
        #10 $display("Input: -50  => Output: %d", relu_output);
        #10 $display("Input: 32767  => Output: %d", relu_output);
        #10 $display("Input: -32768 => Output: %d", relu_output);
        #10 $display("Input: 1234 => Output: %d", relu_output);
        #10 $display("Input: -1234 => Output: %d", relu_output);
        #10 $display("Input: 0 => Output: %d", relu_output);

        $stop; // End simulation
    end
endmodule

`timescale 1ns / 1ps

module tb_debounce;

    reg clk;
    reg rst;
    reg [3:0] keyword_input;
    wire [3:0] keyword_output;

    // Instantiate the Unit Under Test (UUT)
    debounce uut (
        .clk(clk),
        .rst(rst),
        .keyword_input(keyword_input),
        .keyword_output(keyword_output)
    );

    // Clock generation (10ns period => 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize clock and reset
        clk = 0;
        rst = 1;
        keyword_input = 4'd0;
        
        #20 rst = 0; // Release reset
        
        // Simulate noisy input switching rapidly
        #10 keyword_input = 4'd3;
        #10 keyword_input = 4'd2; // Noise
        #10 keyword_input = 4'd3; // Correct keyword, starts debounce
        repeat(50000) #1 keyword_input = 4'd3; // Hold for debounce time
        
        #10 keyword_input = 4'd5; // Change to another keyword
        repeat(50000) #1 keyword_input = 4'd5; // Hold for debounce time

        #10 keyword_input = 4'd7; // Another change
        repeat(50000) #1 keyword_input = 4'd7; // Hold for debounce time
        
        #50;
        
        // Display results
        $display("Debounce Test Results:");
        $display("Final Keyword Output: %d", keyword_output);
        
        #10 $stop; // End simulation
    end

endmodule

`timescale 1ns / 1ps

module tb_top_module;

    // Clock and Reset Signals
    reg clk;
    reg rst;
    
    // Output from Top Module
    wire [3:0] keyword_id;

    // Instantiate the Top Module
    top_module uut (
        .clk(clk),
        .rst(rst),
        .keyword_id(keyword_id)
    );

    // Clock Generation (50 MHz)
    always #10 clk = ~clk; // 20ns period (50 MHz)

    // Test Stimulus
    initial begin
        // Initialize Signals
        clk = 0;
        rst = 1;  // Hold reset high initially
        
        // Wait for Some Time
        #100;
        
        // Release Reset
        rst = 0;
        
        // Wait for Processing
        #5000;
        
        // Check Output
        $display("Keyword ID: %d", keyword_id);
        
        // Wait for Processing to Complete
        #1000;

        // Finish Simulation
        $finish;
    end
    
    // Monitor the Output Signals
    initial begin
        $monitor("Time: %0t | Keyword ID: %d", $time, keyword_id);
    end
    
endmodule

module softmax_lut (
    input wire clk,
    input wire signed [15:0] input_values_0, input wire signed [15:0] input_values_1,
    input wire signed [15:0] input_values_2, input wire signed [15:0] input_values_3,
    input wire signed [15:0] input_values_4, input wire signed [15:0] input_values_5,
    input wire signed [15:0] input_values_6, input wire signed [15:0] input_values_7,
    output reg signed [15:0] output_probabilities_0, output reg signed [15:0] output_probabilities_1,
    output reg signed [15:0] output_probabilities_2, output reg signed [15:0] output_probabilities_3,
    output reg signed [15:0] output_probabilities_4, output reg signed [15:0] output_probabilities_5,
    output reg signed [15:0] output_probabilities_6, output reg signed [15:0] output_probabilities_7
);

    reg signed [15:0] lut [0:255];  // Softmax LUT storage
    reg signed [15:0] max_input;
    reg [7:0] index_0, index_1, index_2, index_3;
    reg [7:0] index_4, index_5, index_6, index_7;
    
    integer i;

    // Read Lookup Table (Softmax LUT stored in memory file)
    initial begin
        $readmemh("softmax_lut.mem", lut);
    end

    always @(posedge clk) begin
        // Step 1: Find max(input_values) for numerical stability
        max_input = input_values_0;
        if (input_values_1 > max_input) max_input = input_values_1;
        if (input_values_2 > max_input) max_input = input_values_2;
        if (input_values_3 > max_input) max_input = input_values_3;
        if (input_values_4 > max_input) max_input = input_values_4;
        if (input_values_5 > max_input) max_input = input_values_5;
        if (input_values_6 > max_input) max_input = input_values_6;
        if (input_values_7 > max_input) max_input = input_values_7;

        // Step 2: Compute LUT indices (normalize and prevent underflow)
        index_0 = ($signed((input_values_0 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_0 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_0 - max_input) >>> 6);
                  
        index_1 = ($signed((input_values_1 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_1 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_1 - max_input) >>> 6);
                  
        index_2 = ($signed((input_values_2 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_2 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_2 - max_input) >>> 6);
                  
        index_3 = ($signed((input_values_3 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_3 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_3 - max_input) >>> 6);
                  
        index_4 = ($signed((input_values_4 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_4 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_4 - max_input) >>> 6);
                  
        index_5 = ($signed((input_values_5 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_5 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_5 - max_input) >>> 6);
                  
        index_6 = ($signed((input_values_6 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_6 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_6 - max_input) >>> 6);
                  
        index_7 = ($signed((input_values_7 - max_input) >>> 6) < 0) ? 8'd0 :
                  ($signed((input_values_7 - max_input) >>> 6) > 8'd255) ? 8'd255 : 
                  $signed((input_values_7 - max_input) >>> 6);

        // Step 3: Lookup softmax values from LUT
        output_probabilities_0 = lut[index_0];
        output_probabilities_1 = lut[index_1];
        output_probabilities_2 = lut[index_2];
        output_probabilities_3 = lut[index_3];
        output_probabilities_4 = lut[index_4];
        output_probabilities_5 = lut[index_5];
        output_probabilities_6 = lut[index_6];
        output_probabilities_7 = lut[index_7];
    end

endmodule

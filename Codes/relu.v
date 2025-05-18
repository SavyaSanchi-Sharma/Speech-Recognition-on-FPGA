module relu (
    input wire clk,
    input wire signed [15:0] nn_input,   // Ensure signed input
    output reg signed [15:0] relu_output // Ensure signed output
);
    always @(posedge clk) begin
        relu_output <= (nn_input > 0) ? nn_input : 16'sd0; // Use signed constant
    end
endmodule

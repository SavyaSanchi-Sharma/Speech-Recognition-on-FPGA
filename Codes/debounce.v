module debounce (
    input wire clk,
    input wire rst,
    input wire [3:0] keyword_input,  // Raw keyword ID
    output reg [3:0] keyword_output  // Debounced keyword ID
);

    reg [3:0] prev_keyword;
    reg [15:0] counter;
    parameter DEBOUNCE_TIME = 50000;  // Adjust as needed

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            keyword_output <= 4'd0;
            prev_keyword <= 4'd0;
            counter <= 16'd0;
        end else begin
            if (keyword_input == prev_keyword) begin
                if (counter < DEBOUNCE_TIME) begin
                    counter <= counter + 1;
                end else begin
                    keyword_output <= keyword_input;  // Confirmed stable keyword
                end
            end else begin
                prev_keyword <= keyword_input;
                counter <= 16'd0;  // Reset debounce timer
            end
        end
    end

endmodule

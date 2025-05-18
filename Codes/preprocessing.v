module preprocessing (
    input wire clk,
    input wire rst,
    output reg signed [15:0] audio_out
);

reg [15:0] audio_memory [0:1023];  // example memory
reg [9:0] address;                 // address register (10 bits for 1024 depth)

initial begin
    $readmemh("audio.mem", audio_memory);
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        address <= 10'd0;
        audio_out <= 16'd0;
    end else begin
        audio_out <= audio_memory[address];
        address <= address + 1'b1;
    end
end

endmodule

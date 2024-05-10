module bpsk #(
    parameter INPUT_DATA_WIDTH = 16,                  // Width of the input data
    parameter OUTPUT_DATA_WIDTH_I = 16,               // Width of the I channel output data
    parameter OUTPUT_DATA_WIDTH_Q = 16,               // Width of the Q channel output data
    parameter BPSK_AMPLITUDE = 16'b0101101010000010  // Amplitude of the BPSK signal (1/root(2))
) (
    input clk,                                       // Clock input
    input enable,                                    // Enable signal to activate modulation
    input [INPUT_DATA_WIDTH-1:0] data_in,            // Input data to be modulated
    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i [0:INPUT_DATA_WIDTH-1],  // Output I channel
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q [0:INPUT_DATA_WIDTH-1]   // Output Q channel
);
   
    integer i;  // Declare loop counter

    always @(*) begin
        // Loop through each bit of the input data
        for (i = 0; i < INPUT_DATA_WIDTH; i = i + 1) begin
            // BPSK modulation formula: amplitude * (1 - 2 * data_in[i])
            // Modulate the in-phase (I) channel
            channel_i[i] = enable ? BPSK_AMPLITUDE * (1 - 2 * data_in[i]) : 'd0;
            // Modulate the quadrature (Q) channel
            channel_q[i] = enable ? BPSK_AMPLITUDE * (1 - 2 * data_in[i]) : 'd0; 
        end
    end
    
endmodule
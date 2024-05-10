module qpsk #(
    parameter INPUT_DATA_WIDTH = 16,                     // Width of the input data
    parameter OUTPUT_DATA_WIDTH_I = 16,                  // Width of the I channel output data
    parameter OUTPUT_DATA_WIDTH_Q = 16,                  // Width of the Q channel output data
    parameter QPSK_AMPLITUDE = 16'b0101101010000010     // Amplitude of the QPSK signal (1/root(2))
)(
    input clk,                                          // Clock input
    input enable,                                       // Enable signal to activate modulation
    input [INPUT_DATA_WIDTH-1:0] data_in,               // Input data to be modulated
    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i[0:(INPUT_DATA_WIDTH>>1)-1],  // Output I channel
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q[0:(INPUT_DATA_WIDTH>>1)-1]   // Output Q channel
);

    integer i;  // Declare loop counter

    always @(*) begin
        // Loop through each symbol of the input data (2 bits per symbol for QPSK)
        for (i = 0; i < (INPUT_DATA_WIDTH >> 1); i = i + 1) begin
            // Calculate in-phase (I) channel using QPSK modulation formula
            // QPSK_AMPLITUDE * (1 - 2 * data_in[2*i])
            channel_i[i] = enable ? QPSK_AMPLITUDE * (1 - 2 * data_in[2*i]) : 'd0;
            
            // Calculate quadrature (Q) channel using QPSK modulation formula
            // QPSK_AMPLITUDE * (1 - 2 * data_in[2*i + 1])
            channel_q[i] = enable ? QPSK_AMPLITUDE * (1 - 2 * data_in[2*i + 1]) : 'd0;
        end
    end

endmodule

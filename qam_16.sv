module qam_16 #(
    parameter INPUT_DATA_WIDTH = 16,                      // Width of the input data
    parameter OUTPUT_DATA_WIDTH_I = 16,                   // Width of the I channel output data
    parameter OUTPUT_DATA_WIDTH_Q = 16,                   // Width of the Q channel output data
    parameter QAM16_AMPLITUDE = 16'b0010100001111010     // Amplitude of the QAM-16 signal (1/root(10))
) (
    input clk,                                           // Clock input
    input enable,                                        // Enable signal to activate modulation
    input [INPUT_DATA_WIDTH-1:0] data_in,                // Input data to be modulated
    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i [0:(INPUT_DATA_WIDTH >> 2)-1],  // Output I channel
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q [0:(INPUT_DATA_WIDTH >> 2)-1]   // Output Q channel
);

    integer i;  // Declare loop counter

    always @(*) begin
        // Loop through each symbol of the input data (4 bits per symbol)
        for (i = 0; i < (INPUT_DATA_WIDTH >> 2); i = i + 1) begin
            // Calculate in-phase (I) channel using QAM-16 modulation formula
            // QAM16_AMPLITUDE * (1 - 2 * data_in[4*i]) * (2 - (1 - 2 * data_in[4*i + 2]))
            channel_i[i] = enable ? QAM16_AMPLITUDE * (1 - 2 * data_in[4*i]) * (2 - (1 - 2 * data_in[4*i + 2])) : 'd0;
            
            // Calculate quadrature (Q) channel using QAM-16 modulation formula
            // QAM16_AMPLITUDE * (1 - 2 * data_in[4*i + 1]) * (2 - (1 - 2 * data_in[4*i + 3]))
            channel_q[i] = enable ? QAM16_AMPLITUDE * (1 - 2 * data_in[4*i + 1]) * (2 - (1 - 2 * data_in[4*i + 3])) : 'd0;
        end
    end
    
endmodule

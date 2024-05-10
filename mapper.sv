module mapper #(
    parameter INPUT_DATA_WIDTH = 12,                      // Width of the input data
    parameter SCHEME_WIDTH = 4,                           // Width of the scheme input
    parameter OUTPUT_DATA_WIDTH_I = 16,                   // Width of the output I channel data
    parameter OUTPUT_DATA_WIDTH_Q = 16,                   // Width of the output Q channel data
    parameter BPSK_AMPLITUDE = 16'b0101101010000010,      // Amplitude of BPSK signal (1/root(2))
    parameter QPSK_AMPLITUDE = 16'b0101101010000010,      // Amplitude of QPSK signal (1/root(2))
    parameter QAM16_AMPLITUDE = 16'b0010100001111010,     // Amplitude of QAM-16 signal (1/root(10))
    parameter QAM64_AMPLITUDE = 16'b0001001111000000      // Amplitude of QAM-64 signal
) (
    input clk,                                           // Clock input
    input [INPUT_DATA_WIDTH-1:0] data_in,                // Input data to be modulated
    input [SCHEME_WIDTH-1:0] scheme,                     // Modulation scheme selection

    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i_pb2_bpsk [0:INPUT_DATA_WIDTH-1],  // Output I channel for π/2 BPSK
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q_pb2_bpsk [0:INPUT_DATA_WIDTH-1],  // Output Q channel for π/2 BPSK

    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i_bpsk [0:INPUT_DATA_WIDTH-1],        // Output I channel for BPSK
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q_bpsk [0:INPUT_DATA_WIDTH-1],        // Output Q channel for BPSK

    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i_qpsk [0:(INPUT_DATA_WIDTH >> 1) - 1], // Output I channel for QPSK
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q_qpsk [0:(INPUT_DATA_WIDTH >> 1) - 1], // Output Q channel for QPSK

    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i_qam16 [0:(INPUT_DATA_WIDTH >> 2) - 1], // Output I channel for QAM-16
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q_qam16 [0:(INPUT_DATA_WIDTH >> 2) - 1], // Output Q channel for QAM-16

    output reg signed [OUTPUT_DATA_WIDTH_I-1:0] channel_i_qam64 [0:(INPUT_DATA_WIDTH/6) - 1],   // Output I channel for QAM-64
    output reg signed [OUTPUT_DATA_WIDTH_Q-1:0] channel_q_qam64 [0:(INPUT_DATA_WIDTH/6) - 1]    // Output Q channel for QAM-64
);

    // Modulation scheme selection:
    // 0001 = π/2 BPSK
    // 0010 = BPSK
    // 0011 = QPSK
    // 0100 = QAM-16
    // 0101 = QAM-64

    // Instantiate π/2 BPSK module
    pi_by_2_BPSK #(
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH_I(OUTPUT_DATA_WIDTH_I),
        .OUTPUT_DATA_WIDTH_Q(OUTPUT_DATA_WIDTH_Q),
        .BPSK_AMPLITUDE(BPSK_AMPLITUDE)
    ) pb2_bpsk (
        .clk(clk),
        .data_in(data_in),
        .enable(scheme == 4'b0001),
        .channel_i(channel_i_pb2_bpsk), 
        .channel_q(channel_q_pb2_bpsk)
    );

    // Instantiate BPSK module
    bpsk #(
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH_I(OUTPUT_DATA_WIDTH_I),
        .OUTPUT_DATA_WIDTH_Q(OUTPUT_DATA_WIDTH_Q),
        .BPSK_AMPLITUDE(BPSK_AMPLITUDE)
    ) bpsk_  (
        .clk(clk),
        .data_in(data_in),
        .enable(scheme == 4'b0010),
        .channel_i(channel_i_bpsk), 
        .channel_q(channel_q_bpsk)
    );

    // Instantiate QPSK module
    qpsk  #(
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH_I(OUTPUT_DATA_WIDTH_I),
        .OUTPUT_DATA_WIDTH_Q(OUTPUT_DATA_WIDTH_Q),
        .QPSK_AMPLITUDE(QPSK_AMPLITUDE)
    ) qpsk_ (
        .clk(clk),
        .data_in(data_in),
        .enable(scheme == 4'b0011),
        .channel_i(channel_i_qpsk), 
        .channel_q(channel_q_qpsk)
    );

    // Instantiate QAM-16 module
    qam_16  #(
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH_I(OUTPUT_DATA_WIDTH_I),
        .OUTPUT_DATA_WIDTH_Q(OUTPUT_DATA_WIDTH_Q),
        .QAM16_AMPLITUDE(QAM16_AMPLITUDE)
    ) qam16_ (
        .clk(clk),
        .data_in(data_in),
        .enable(scheme == 4'b0100),
        .channel_i(channel_i_qam16), 
        .channel_q(channel_q_qam16)
    );

    // Instantiate QAM-64 module
    qam_64  #(
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH_I(OUTPUT_DATA_WIDTH_I),
        .OUTPUT_DATA_WIDTH_Q(OUTPUT_DATA_WIDTH_Q),
        .QAM64_AMPLITUDE(QAM64_AMPLITUDE)
    ) qam64_ (
        .clk(clk),
        .data_in(data_in),
        .enable(scheme == 4'b0101),
        .channel_i(channel_i_qam64), 
        .channel_q(channel_q_qam64)
    );

endmodule

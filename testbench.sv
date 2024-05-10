`timescale 1ns/1ps

module mapper_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk = 0;
    reg [11:0] data_in;
    reg [3:0] scheme;
    wire signed [15:0] channel_i_pb2_bpsk [0:11];
    wire signed [15:0] channel_q_pb2_bpsk [0:11];
    wire signed [15:0] channel_i_bpsk [0:11];
    wire signed [15:0] channel_q_bpsk [0:11];
    wire signed [15:0] channel_i_qpsk [0:5];
    wire signed [15:0] channel_q_qpsk [0:5];
    wire signed [15:0] channel_i_qam16 [0:2];
    wire signed [15:0] channel_q_qam16 [0:2];
    wire signed [15:0] channel_i_qam64 [0:1];
    wire signed [15:0] channel_q_qam64 [0:1];

    // Instantiate the mapper module
    mapper #(
        .INPUT_DATA_WIDTH(12),
        .SCHEME_WIDTH(4),
        .OUTPUT_DATA_WIDTH_I(16),
        .OUTPUT_DATA_WIDTH_Q(16),
        .BPSK_AMPLITUDE(16'b0101101010000010),
        .QPSK_AMPLITUDE(16'b0101101010000010),
        .QAM16_AMPLITUDE(16'b0010100001111010),
        .QAM64_AMPLITUDE(16'b0001001111000000)
    ) mapper_inst (
        .clk(clk),
        .data_in(data_in),
        .scheme(scheme),
        .channel_i_pb2_bpsk(channel_i_pb2_bpsk),
        .channel_q_pb2_bpsk(channel_q_pb2_bpsk),
        .channel_i_bpsk(channel_i_bpsk),
        .channel_q_bpsk(channel_q_bpsk),
        .channel_i_qpsk(channel_i_qpsk),
        .channel_q_qpsk(channel_q_qpsk),
        .channel_i_qam16(channel_i_qam16),
        .channel_q_qam16(channel_q_qam16),
        .channel_i_qam64(channel_i_qam64),
        .channel_q_qam64(channel_q_qam64)
    );

    // Clock generation
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Testbench stimulus
    initial begin
        // Initialize inputs
        data_in = 12'b110010101011;
        scheme = 4'b0001; // PB2_BPSK

        #100 data_in = 12'b101010101010;
        #100 scheme = 4'b0010; // BPSK

        // Apply stimulus
        #100 data_in = 12'b101101110111;
        #100 scheme = 4'b0011; // QPSK

        #100 data_in = 12'b010110100110;
        #100 scheme = 4'b0100; // QAM16

        #100 data_in = 12'b101010101010;
        #100 scheme = 4'b0101; // QAM64

        

        // Finish simulation
        #100 $finish;
    end

    // Display outputs
    always @(posedge clk) begin
        $display("Time=%t, BPSK I=%d, BPSK Q=%d", $time, channel_i_bpsk[0], channel_q_bpsk[0]);
        $display("Time=%t, QPSK I=%d, QPSK Q=%d", $time, channel_i_qpsk[0], channel_q_qpsk[0]);
        $display("Time=%t, QAM16 I=%d, QAM16 Q=%d", $time, channel_i_qam16[0], channel_q_qam16[0]);
        $display("Time=%t, QAM64 I=%d, QAM64 Q=%d", $time, channel_i_qam64[0], channel_q_qam64[0]);
    end

endmodule

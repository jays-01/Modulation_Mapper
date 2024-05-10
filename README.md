# Modulation_Mapper <br />
This Verilog project implements a modulation scheme mapper, capable of mapping input data to various modulation schemes including BPSK, QPSK, QAM-16, and QAM-64. The mapping is controlled using a scheme selection input. <br />

**Modules**
The project consists of the following modules:

**mapper:** Top-level module responsible for selecting and instantiating the appropriate modulation module based on the selected scheme.\n
**pi_by_2_BPSK:** Implements π/2 BPSK modulation
**bpsk:** Implements BPSK modulation.
**qpsk:** Implements QPSK modulation.
**qam_16:** Implements QAM-16 modulation.
**qam_64:** Implements QAM-64 modulation.
**Parameters**
Each module accepts various parameters to configure the behavior of the modulation:

**INPUT_DATA_WIDTH:** Width of the input data.
**SCHEME_WIDTH:** Width of the scheme selection input.
**OUTPUT_DATA_WIDTH_I:** Width of the output I channel data.
**OUTPUT_DATA_WIDTH_Q:** Width of the output Q channel data.
**BPSK_AMPLITUDE:** Amplitude of the BPSK signal.
**QPSK_AMPLITUDE:** Amplitude of the QPSK signal.
**QAM16_AMPLITUDE:** Amplitude of the QAM-16 signal.
**QAM64_AMPLITUDE:** Amplitude of the QAM-64 signal.
**Scheme Selection**
The modulation scheme is selected using the scheme input. The mapping is as follows:

**0001:** π/2 BPSK
**0010:** BPSK
**0011:** QPSK
**0100:** QAM-16
**0101:** QAM-64
**Usage**
To use this project, instantiate the mapper module in your Verilog design and connect the necessary inputs and outputs. Ensure to provide appropriate clock signals and input data. Select the desired modulation scheme using the scheme input.

**License**
This project is licensed under the MIT License.

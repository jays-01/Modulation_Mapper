# Modulation_Mapper <br />
This Verilog project implements a modulation scheme mapper, capable of mapping input data to various modulation schemes including BPSK, QPSK, QAM-16, and QAM-64. The mapping is controlled using a scheme selection input. <br />

# Modules <br />
The project consists of the following modules:

**mapper:** Top-level module responsible for selecting and instantiating the appropriate modulation module based on the selected scheme. <br />
**pi_by_2_BPSK:** Implements π/2 BPSK modulation <br />
**bpsk:** Implements BPSK modulation. <br />
**qpsk:** Implements QPSK modulation. <br />
**qam_16:** Implements QAM-16 modulation. <br />
**qam_64:** Implements QAM-64 modulation. <br />
# Parameters <br />
Each module accepts various parameters to configure the behavior of the modulation: <br />

**INPUT_DATA_WIDTH:** Width of the input data. <br />
**SCHEME_WIDTH:** Width of the scheme selection input. <br />
**OUTPUT_DATA_WIDTH_I:** Width of the output I channel data. <br />
**OUTPUT_DATA_WIDTH_Q:** Width of the output Q channel data. <br />
**BPSK_AMPLITUDE:** Amplitude of the BPSK signal. <br />
**QPSK_AMPLITUDE:** Amplitude of the QPSK signal. <br />
**QAM16_AMPLITUDE:** Amplitude of the QAM-16 signal. <br />
**QAM64_AMPLITUDE:** Amplitude of the QAM-64 signal. <br />
# Scheme Selection <br />
The modulation scheme is selected using the scheme input. The mapping is as follows: <br />

**0001:** π/2 BPSK <br />
**0010:** BPSK <br />
**0011:** QPSK <br />
**0100:** QAM-16 <br />
**0101:** QAM-64 <br />
# Usage <br />
To use this project, instantiate the mapper module in your Verilog design and connect the necessary inputs and outputs. Ensure to provide appropriate clock signals and input data. Select the desired modulation scheme using the scheme input. <br />

# License <br />
This project is licensed under the MIT License.

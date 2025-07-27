📡 AM Modulation in Verilog  
This project demonstrates a digital implementation of Amplitude Modulation (AM) using Verilog. It generates a high-frequency carrier signal and a low-frequency envelope signal, then performs AM modulation by multiplying them.

🧠 Concept
Amplitude Modulation is a technique where the amplitude of a carrier wave is varied in proportion to the message (modulating) signal.
The mathematical expression of AM is:

AM(t) = Carrier(t) × [1 + Envelope(t)]
In this digital implementation:

A 16-entry sine LUT (based on the top 4 bits of a 16-bit phase accumulator) is used.
Two phase accumulators generate:
High-frequency carrier signal (sin_carrier)
Low-frequency envelope signal (sin_env)
Final output am_out is calculated as:

am_out <= (sin_carrier * (sin_env + 32767)) >>> 15;
This equation ensures the envelope modulates the amplitude of the carrier, and the result is scaled properly to fit a 16-bit signed output.

🗂️ File Structure

exam.v : Main Verilog module implementing the AM modulation logic.
exam_tb.v : Testbench used to simulate and verify the design.
waveform.png : Simulation waveform showing carrier, envelope, and AM output.

📷 Simulation Output

From top to bottom:

clk : Clock signal
sin_carrier : High-frequency carrier wave
sin_env : Low-frequency modulating signal
am_out : AM-modulated output

As seen in the waveform, the amplitude of the carrier varies in sync with the envelope, confirming correct modulation behavior.

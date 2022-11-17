Tech Writeup

The overarching system being developed follows a closed-loop structure as follows:

Raw EEG → Teensy 4.0 → IIR Bandpass Filter → FIR Hilbert Transformer → Recognition of select phase values → Digital pulse emitted → Optogenetic Stimulation occurs

The source code in the repository will allow for the Teensy 4.0 to properly execute an IIR Bandpass Filter and FIR Hilbert Transformer while emitting digital signals at specified phase values in a real-time manner. 

MATLAB files (.m) are used for the purpose of preliminary design of filters and offline analysis of data, while the Arduino code written in C/C++ is used for direct execution of the system.




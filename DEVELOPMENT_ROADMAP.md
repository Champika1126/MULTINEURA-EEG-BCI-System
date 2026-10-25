# MULTINEURA Development Roadmap

Only mark an item complete after implementation and testing.

## Stage 1 – Simulink simulation foundation
- [x] MATLAB R2018 model-builder script
- [x] Synthetic EEG-like input and noise
- [x] Basic conditioning and monitoring
- [x] Demonstration command branches
- [ ] Run and verify the generated model in MATLAB R2018
- [ ] Add screenshots of the verified model and simulation

## Stage 2 – Real EEG acquisition
- [ ] Select a suitable EEG acquisition device
- [ ] Acquire EEG using its supported interface
- [ ] Record synchronized stimulus/event markers
- [ ] Document channels, sampling rate and protocol

## Stage 3 – P300 processing and classifier
- [ ] Present controlled visual stimuli
- [ ] Extract event-locked EEG epochs
- [ ] Label target and non-target epochs
- [ ] Extract features
- [ ] Train an LDA baseline classifier
- [ ] Evaluate held-out data: accuracy, false positives, false negatives and latency

## Stage 4 – Application command interface
- [ ] Define command states and safe defaults
- [ ] Add authorization checks for smart-lock requests
- [ ] Add cancellation and timeout handling
- [ ] Preserve an independent emergency alert method

## Stage 5 – Hardware integration
- [ ] Integrate ESP32 communication
- [ ] Test servo output on a low-voltage bench setup
- [ ] Test buzzer and notification path
- [ ] Perform fault, disconnect and false-trigger tests

## Stage 6 – Documentation and validation
- [ ] Add verified model screenshots
- [ ] Add wiring diagram and component list
- [ ] Document test setup, limitations and results
- [ ] Review electrical safety, privacy and security

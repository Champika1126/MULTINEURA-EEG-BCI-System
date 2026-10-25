# MULTINEURA – Software Requirements

## 1. Overview

MULTINEURA is a multipurpose EEG-based Brain–Computer Interface (BCI) platform designed to translate neural signals into actionable commands for integration with different external applications.

The software architecture is intended to acquire EEG data, preprocess signals, extract relevant features, classify user intent and transmit corresponding commands to an embedded application interface.

## 2. Software Tools and Technologies

| Software / Technology | Purpose |
|---|---|
| MATLAB R2018 | EEG signal analysis and algorithm development |
| Simulink | System modelling and simulation |
| MATLAB Signal Processing Functions | Signal preprocessing and filtering |
| MATLAB Classification Algorithms | EEG pattern classification |
| Arduino IDE | ESP32 firmware development |
| Embedded C/C++ | Embedded controller programming |
| Serial Communication | Data and command exchange |
| Wi-Fi / Bluetooth | Wireless application communication |

*Toolbox availability and compatibility must be verified in the installed MATLAB R2018 environment.*

## 3. EEG Signal Acquisition

The software system must receive digital EEG samples from a suitable EEG acquisition front-end.

The acquisition interface should support:
- Continuous or appropriately sampled signal input.
- Timestamped signal data.
- Synchronization with stimulus event markers when event-related paradigms are used.
- Reliable data transfer to the processing environment.

The actual acquisition interface will depend on the selected EEG hardware.

## 4. Signal Preprocessing

Raw EEG signals may contain noise and unwanted artifacts.

The proposed preprocessing stage includes:

- Band-pass filtering to retain the frequency range relevant to the selected EEG paradigm.
- Notch filtering where power-line interference is present.
- Baseline correction where required.
- Artifact detection and handling.
- Signal segmentation into appropriate analysis windows.

Filter parameters must be selected according to the acquisition hardware and experimental paradigm.

## 5. Feature Extraction

Feature extraction converts preprocessed EEG signals into numerical representations suitable for classification.

Potential methods include:

- Time-domain statistical features.
- Frequency-domain features.
- Event-related potential characteristics.
- P300 amplitude and latency features for a P300-based implementation.

The final feature set will be selected based on experimental data and validation results.

## 6. Intent Classification

A classification module is proposed to identify the intended command from extracted EEG features.

**Linear Discriminant Analysis (LDA)** is considered as an initial classification approach because it provides a relatively simple baseline for distinguishing labelled EEG classes.

The classifier development process includes:

1. Collect labelled EEG samples.
2. Segment the signals into appropriate epochs.
3. Extract relevant features.
4. Train the classifier.
5. Evaluate using held-out data.
6. Generate a command only when the classification meets the defined decision criteria.

The classifier must be evaluated using appropriate performance measures, including accuracy, sensitivity, specificity, false-positive rate and processing latency.

## 7. P300-Based Processing (Proposed)

For a P300-based interface, the user is presented with visual stimuli and attends to a selected target.

The software must support:

- Stimulus presentation.
- Accurate event-marker generation.
- EEG epoch extraction relative to stimulus events.
- P300-related feature extraction.
- Classification of target and non-target responses.
- Command generation based on the selected target.

P300

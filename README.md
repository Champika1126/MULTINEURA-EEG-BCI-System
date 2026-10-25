# MULTINEURA – EEG-Based Brain–Computer Interface (BCI)

MULTINEURA is a prototype concept exploring how EEG signals can be processed into commands for assistive and security-related applications.

**Current status:** This repository contains a MATLAB/Simulink R2018 model-builder script using synthetic EEG-like signals and demonstration decision logic. It is not a validated P300 detector, clinical device, or operational security/emergency system.

## Applications explored

1. **Neural Smart Lock:** BCI-based selection of an access request. A real deployment must use separate identity verification and authorization; EEG command selection is not identity proof.
2. **Neural Assistive Emergency Alert:** BCI-based selection of an emergency command. A conventional backup alert method must remain available.

## Architecture

```text
EEG Input
  -> Signal Conditioning
  -> P300 Event / Epoch Processing (real EEG stage planned)
  -> Feature Extraction
  -> Classifier (trained LDA integration planned)
  -> Command Decision
       |-> Smart Lock (ESP32 + servo)
       |-> Emergency Alert (ESP32 + buzzer / notification)
```

## Repository structure

```text
MULTINEURA-EEG-BCI-System/
├── README.md
├── LICENSE
├── .gitignore
├── model/
│   └── MULTINEURA_Build_R2018.m
└── docs/
    └── DEVELOPMENT_ROADMAP.md
```

## Requirements

- MATLAB R2018
- Simulink compatible with MATLAB R2018

The builder script uses standard Simulink blocks and does not intentionally require additional toolboxes. Block availability may vary by installation.

## Run the simulation

1. Download or clone this repository.
2. Open MATLAB R2018.
3. Set the Current Folder to the repository's `model` directory.
4. Open `MULTINEURA_Build_R2018.m` and click **Run**.
5. The script is intended to create and open `MULTINEURA.slx`.
6. Run the model and open its Scope blocks.

The `.slx` model is generated locally by MATLAB. It is not included until it has been generated and verified.

## Included in the current simulation

- Synthetic EEG-like signal generation and simulated noise
- Basic signal conditioning and smoothing
- Demonstration threshold decision
- Demonstration command selector
- Separate smart-lock and emergency-alert logic outputs
- Scope and Display monitoring

## Not implemented yet

- Real EEG electrode/amplifier acquisition
- Visual P300 stimuli and synchronized event markers
- Real P300 epoch extraction and averaging
- Feature extraction validated on labelled EEG recordings
- Trained and evaluated LDA classifier
- ESP32 communication and physical outputs
- Safety, security, usability or clinical validation

## Safety

- Never connect scalp electrodes directly to an Arduino or ESP32 ADC.
- Use an appropriate EEG acquisition device with suitable isolation and electrical safety.
- Do not connect this prototype to a real door lock or rely on it as a security system.
- Keep an independent conventional emergency alert method available.
- This prototype is not for medical diagnosis or treatment.

See [`docs/DEVELOPMENT_ROADMAP.md`](docs/DEVELOPMENT_ROADMAP.md) for planned work.

## Contributions

For suggestions, open a GitHub Issue. Clearly distinguish simulated results from experiments using real EEG data.

## License

MIT License. See [`LICENSE`](LICENSE).

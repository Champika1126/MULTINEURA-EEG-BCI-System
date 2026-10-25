%% MULTINEURA - Integrated Simulink Model Builder
% Target: MATLAB / Simulink R2018
% Run this script to create and open MULTINEURA.slx.
% Standard Simulink blocks only; no add-on toolbox is intentionally required.
%
% IMPORTANT:
% EEG is simulated in this starter model. The threshold logic is a demonstration
% placeholder, NOT a trained/validated P300 detector or clinical system.
% Real P300 requires synchronized visual stimulus markers, suitable EEG
% acquisition hardware, labelled epochs, classifier training and validation.

clear; clc;
model = 'MULTINEURA';

if bdIsLoaded(model)
    close_system(model, 0);
end
new_system(model);
open_system(model);
set_param(model, 'StopTime', '20', 'Solver', 'ode45');

x = 40; y = 55;

% EEG signal sources
add_block('simulink/Sources/Sine Wave', [model '/EEG Alpha Component'], ...
    'Position', [x y x+100 y+40], 'Amplitude', '0.5', ...
    'Frequency', '10', 'SampleTime', '0.01');

add_block('simulink/Sources/Sine Wave', [model '/EEG P300 Demo Component'], ...
    'Position', [x y+65 x+100 y+105], 'Amplitude', '0.8', ...
    'Frequency', '1.2', 'SampleTime', '0.01');

add_block('simulink/Sources/Random Number', [model '/EEG Noise'], ...
    'Position', [x y+130 x+100 y+170], 'Mean', '0', ...
    'Variance', '0.04', 'SampleTime', '0.01');

add_block('simulink/Math Operations/Sum', [model '/EEG Signal Mixer'], ...
    'Position', [x+145 y+55 x+180 y+145], 'Inputs', '+++');

% Basic smoothing filters using standard Discrete Filter blocks
add_block('simulink/Discrete/Discrete Filter', [model '/Signal Conditioning'], ...
    'Position', [x+245 y+75 x+365 y+125], ...
    'Numerator', '[0.2 0.2 0.2 0.2 0.2]', 'Denominator', '[1]', ...
    'SampleTime', '0.01');

add_block('simulink/Math Operations/Abs', [model '/Absolute EEG'], ...
    'Position', [x+415 y+80 x+450 y+115]);

add_block('simulink/Discrete/Discrete Filter', [model '/Feature Smoother'], ...
    'Position', [x+500 y+75 x+620 y+125], ...
    'Numerator', '[0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1]', ...
    'Denominator', '[1]', 'SampleTime', '0.01');

% Demonstration classifier threshold (replace later with trained P300/LDA)
add_block('simulink/Logic and Bit Operations/Compare To Constant', ...
    [model '/Demo Decision Threshold'], ...
    'Position', [x+675 y+75 x+805 y+125], ...
    'const', '0.30', 'relop', '>', 'outDataTypeStr', 'boolean');

% Demo selector: high = lock request; low = emergency request
add_block('simulink/Sources/Pulse Generator', [model '/Demo Command Selector'], ...
    'Position', [x+675 y+185 x+805 y+225], ...
    'Amplitude', '1', 'Period', '4', 'PulseWidth', '50', ...
    'PhaseDelay', '0', 'SampleTime', '0.01');

add_block('simulink/Logic and Bit Operations/Logical Operator', ...
    [model '/Lock Command Logic'], ...
    'Position', [x+870 y+45 x+935 y+95], 'Operator', 'AND', 'Inputs', '2');

add_block('simulink/Logic and Bit Operations/Logical Operator', ...
    [model '/NOT Selector'], ...
    'Position', [x+870 y+150 x+935 y+200], 'Operator', 'NOT', 'Inputs', '1');

add_block('simulink/Logic and Bit Operations/Logical Operator', ...
    [model '/Emergency Command Logic'], ...
    'Position', [x+1000 y+130 x+1070 y+180], 'Operator', 'AND', 'Inputs', '2');

% Displays and scopes
add_block('simulink/Sinks/Display', [model '/SMART LOCK OUTPUT'], ...
    'Position', [x+1000 y+35 x+1115 y+75]);

add_block('simulink/Sinks/Display', [model '/EMERGENCY ALERT OUTPUT'], ...
    'Position', [x+1140 y+130 x+1280 y+175]);

add_block('simulink/Sinks/Scope', [model '/EEG Waveform Scope'], ...
    'Position', [x+245 y+260 x+365 y+305]);

add_block('simulink/Sinks/Scope', [model '/Processed EEG Scope'], ...
    'Position', [x+500 y+260 x+620 y+305]);

add_block('simulink/Sinks/Scope', [model '/Decision Score Scope'], ...
    'Position', [x+675 y+260 x+805 y+305]);

add_block('simulink/Sinks/Display', [model '/COMMAND ENABLE STATUS'], ...
    'Position', [x+870 y+250 x+1010 y+290]);

% Wiring: EEG acquisition -> conditioning -> feature proxy -> threshold
add_line(model, 'EEG Alpha Component/1', 'EEG Signal Mixer/1', 'autorouting', 'on');
add_line(model, 'EEG P300 Demo Component/1', 'EEG Signal Mixer/2', 'autorouting', 'on');
add_line(model, 'EEG Noise/1', 'EEG Signal Mixer/3', 'autorouting', 'on');
add_line(model, 'EEG Signal Mixer/1', 'Signal Conditioning/1', 'autorouting', 'on');
add_line(model, 'Signal Conditioning/1', 'Absolute EEG/1', 'autorouting', 'on');
add_line(model, 'Absolute EEG/1', 'Feature Smoother/1', 'autorouting', 'on');
add_line(model, 'Feature Smoother/1', 'Demo Decision Threshold/1', 'autorouting', 'on');

% Monitoring
add_line(model, 'EEG Signal Mixer/1', 'EEG Waveform Scope/1', 'autorouting', 'on');
add_line(model, 'Feature Smoother/1', 'Processed EEG Scope/1', 'autorouting', 'on');
add_line(model, 'Feature Smoother/1', 'Decision Score Scope/1', 'autorouting', 'on');

% Lock output = threshold decision AND selector-high
add_line(model, 'Demo Decision Threshold/1', 'Lock Command Logic/1', 'autorouting', 'on');
add_line(model, 'Demo Command Selector/1', 'Lock Command Logic/2', 'autorouting', 'on');
add_line(model, 'Lock Command Logic/1', 'SMART LOCK OUTPUT/1', 'autorouting', 'on');

% Emergency output = threshold decision AND NOT selector
add_line(model, 'Demo Command Selector/1', 'NOT Selector/1', 'autorouting', 'on');
add_line(model, 'Demo Decision Threshold/1', 'Emergency Command Logic/1', 'autorouting', 'on');
add_line(model, 'NOT Selector/1', 'Emergency Command Logic/2', 'autorouting', 'on');
add_line(model, 'Emergency Command Logic/1', 'EMERGENCY ALERT OUTPUT/1', 'autorouting', 'on');
add_line(model, 'Demo Decision Threshold/1', 'COMMAND ENABLE STATUS/1', 'autorouting', 'on');

Simulink.Annotation(model, ...
    'MULTINEURA | Integrated EEG-to-command simulation | Demonstration only: replace threshold with event-locked P300 classifier');

set_param(model, 'ZoomFactor', 'FitSystem');
save_system(model, [model '.slx']);
open_system(model);
disp('MULTINEURA.slx created and opened.');
disp('Run the model and open the scopes to inspect the simulated signal path.');
disp('This model does not yet perform validated P300 classification or drive physical hardware.');

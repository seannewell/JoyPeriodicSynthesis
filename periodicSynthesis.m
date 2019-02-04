% periodicSynthesis.m
%
% Sean Newell
%
% This script demonstrates how to
% synthesize various periodic signals
clear;clc;
Fs = 48000; Ts = 1/Fs;

BPM = 80;

% 4 - whole, 2 - half, 1 - quarter, 0.5 - 8th, 0.25 - 16th
sixthteenthNote = 0.25;
eighthNote = 0.5;
dotEighthNote = 0.75;
quarterNote = 1;
dotQuarterNote = 1.5;
halfNote = 2;

% Convert note lengths to samples
n1 = round(60*Fs*quarterNote/BPM); 
n2 = round(60*Fs*dotEighthNote/BPM);
n3 = round(60*Fs*sixthteenthNote/BPM);
n4 = round(60*Fs*dotQuarterNote/BPM);
n5 = round(60*Fs*eighthNote/BPM);
n6 = round(60*Fs*quarterNote/BPM);
n7 = round(60*Fs*quarterNote/BPM);
n8 = round(60*Fs*halfNote/BPM);

% Make arrays that contain the frequencies and note durations
f1 = [523.25 * ones(n1,1) ; 493.88 * ones(n2,1); 440 * ones(n3,1);...
    392 * ones(n4,1); 349.23 * ones(n5,1); 329.63 * ones(n6,1);...
    293.66 * ones(n7,1); 261.63 * ones(n8,1);];

f2 = [261.63 * ones(n6,1) ; 246.94 * ones(n6,1) ; 261.63 * ones(n8,1);...
    196.00 * ones(n6,1); 174.61 * ones(n6,1); 164.81 * ones(n8,1)];

width1 = 0.9; % width for sawtooth function for the melody
width2 = 0.5; % width for sawtooth function for the harmony

% Allocate the melody and harmony arrays
N = length(f1);
melody = zeros(N,1);
harmony = zeros(N,1);

% Sawtooth waves based on phase angle 
currentAngle = 0; % Initialize current angle
for n = 1:N
    melody(n,1) = .3 * sawtooth(currentAngle, width1);
    angleChange = f1(n,1) * Ts * 2 * pi;
    currentAngle = currentAngle + angleChange;
   
end
currentAngle = 0; % Reinitialize current angle
for n = 1:N
    harmony(n,1) = .4 * sawtooth(currentAngle, width2);
    angleChange = f2(n,1) * Ts * 2 * pi;
    currentAngle = currentAngle + angleChange;
end

out = melody + harmony;
sound(out,Fs);


%% PART 7 - QUALITY SCORE TEST

clear;
clc;
close all;

%% Add quality folder

addpath("quality");

%% Load dataset

imds = imageDatastore( ...
    "organized_train", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

%% Read first image

img = readimage(imds,1);

%% Assess image quality

quality = assessImageQuality(img);

%% Calculate quality score

[qualityScore, status, scores] = ...
    calculateQualityScore(quality);

%% Display results

fprintf("\n============================\n");
fprintf("IMAGE QUALITY REPORT\n");
fprintf("============================\n");

fprintf("Sharpness:          %.2f\n", ...
    quality.sharpness);

fprintf("Brightness:         %.2f\n", ...
    quality.brightness);

fprintf("Contrast:           %.2f\n", ...
    quality.contrast);

fprintf("Retinal Coverage:   %.2f%%\n", ...
    quality.retinalCoverage * 100);

fprintf("\nNormalized Scores\n");

fprintf("Sharpness Score:    %.3f\n", ...
    scores.sharpScore);

fprintf("Brightness Score:   %.3f\n", ...
    scores.brightnessScore);

fprintf("Contrast Score:     %.3f\n", ...
    scores.contrastScore);

fprintf("\n----------------------------\n");

fprintf("QUALITY SCORE:      %.2f / 100\n", ...
    qualityScore);

fprintf("STATUS:             %s\n", ...
    status);

fprintf("============================\n");
%% PART 7 - QUALITY SCORE FOR ALL IMAGES

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

%% Number of images

N = numel(imds.Files);

%% Storage

sharpnessValues = zeros(N,1);
brightnessValues = zeros(N,1);
contrastValues = zeros(N,1);
coverageValues = zeros(N,1);

sharpScores = zeros(N,1);
brightnessScores = zeros(N,1);
contrastScores = zeros(N,1);

qualityScores = zeros(N,1);

statuses = strings(N,1);

%% Process every image

for i = 1:N

    %% Read image

    img = readimage(imds,i);

    %% Part 6

    quality = assessImageQuality(img);

    %% Part 7

    [score, status, scores] = ...
        calculateQualityScore(quality);

    %% Store raw metrics

    sharpnessValues(i) = quality.sharpness;

    brightnessValues(i) = quality.brightness;

    contrastValues(i) = quality.contrast;

    coverageValues(i) = ...
        quality.retinalCoverage * 100;

    %% Store normalized scores

    sharpScores(i) = scores.sharpScore;

    brightnessScores(i) = ...
        scores.brightnessScore;

    contrastScores(i) = ...
        scores.contrastScore;

    %% Store final score

    qualityScores(i) = score;

    %% Store status

    statuses(i) = status;

end

%% Create results table

resultsTable = table( ...
    (1:N)', ...
    imds.Labels, ...
    sharpnessValues, ...
    brightnessValues, ...
    contrastValues, ...
    coverageValues, ...
    sharpScores, ...
    brightnessScores, ...
    contrastScores, ...
    qualityScores, ...
    statuses, ...
    'VariableNames', { ...
    'ImageNumber', ...
    'DRGrade', ...
    'Sharpness', ...
    'Brightness', ...
    'Contrast', ...
    'RetinalCoveragePercent', ...
    'SharpScore', ...
    'BrightnessScore', ...
    'ContrastScore', ...
    'QualityScore', ...
    'Status'});

%% Display table

disp(resultsTable);

%% Save results

if ~isfolder("results")
    mkdir("results");
end

writetable(resultsTable, ...
    "results/quality_score_results.csv");

disp("Quality results saved.");
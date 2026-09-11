%% PART 6 - IMAGE QUALITY ASSESSMENT

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

%% Create results folder

if ~isfolder("results")
    mkdir("results");
end

%% Number of images

N = numel(imds.Files);

%% Store metrics

sharpnessValues = zeros(N,1);
brightnessValues = zeros(N,1);
contrastValues = zeros(N,1);
coverageValues = zeros(N,1);

%% Process images

for i = 1:N

    img = readimage(imds,i);

    quality = assessImageQuality(img);

    sharpnessValues(i) = quality.sharpness;

    brightnessValues(i) = quality.brightness;

    contrastValues(i) = quality.contrast;

    coverageValues(i) = quality.retinalCoverage;

end

%% Display results

for i = 1:N

    fprintf("\nImage %d\n",i);

    fprintf("Sharpness: %.2f\n", ...
        sharpnessValues(i));

    fprintf("Brightness: %.2f\n", ...
        brightnessValues(i));

    fprintf("Contrast: %.2f\n", ...
        contrastValues(i));

    fprintf("Retinal Coverage: %.2f%%\n", ...
        coverageValues(i)*100);

end
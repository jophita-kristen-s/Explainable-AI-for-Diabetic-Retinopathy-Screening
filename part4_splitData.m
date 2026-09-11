%% PART 4 - SPLIT DATA

clear;
clc;

%% Load organized dataset

imds = imageDatastore( ...
    "organized_train", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

%% Display original dataset

disp("Original dataset:");
disp(countEachLabel(imds));

fprintf("Total images: %d\n", numel(imds.Files));

%% Make results folder

if ~isfolder("results")
    mkdir("results");
end

%% Random seed for reproducibility

rng(42);

%% Get number of images

N = numel(imds.Files);

%% Randomly shuffle image indices

idx = randperm(N);

%% Split 6 / 2 / 2

trainIdx = idx(1:6);
valIdx   = idx(7:8);
testIdx  = idx(9:10);

%% Create datasets

trainDS = subset(imds, trainIdx);

valDS = subset(imds, valIdx);

testDS = subset(imds, testIdx);

%% Display sizes

fprintf("\nDataset split:\n");

fprintf("Training images:   %d\n", ...
    numel(trainDS.Files));

fprintf("Validation images: %d\n", ...
    numel(valDS.Files));

fprintf("Testing images:    %d\n", ...
    numel(testDS.Files));

%% Display labels

disp("Training labels:");
disp(trainDS.Labels);

disp("Validation labels:");
disp(valDS.Labels);

disp("Testing labels:");
disp(testDS.Labels);
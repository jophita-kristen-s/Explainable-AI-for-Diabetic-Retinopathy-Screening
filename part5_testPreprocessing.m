%% PART 5 - IMAGE PREPROCESSING TEST

clear;
clc;
close all;

%% Add preprocessing folder to MATLAB path

addpath("preprocessing");

%% Load ImageDatastore

imds = imageDatastore( ...
    "organized_train", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

%% Read first image

img = readimage(imds,1);

%% Get its label

label = imds.Labels(1);

%% Apply preprocessing

enhanced = preprocessFundus(img);

%% Display original and enhanced image

figure;

subplot(1,2,1);

imshow(img);

title("Original - Grade " + string(label));

subplot(1,2,2);

imshow(enhanced);

title("Enhanced");

%% Create results folder

if ~isfolder("results")
    mkdir("results");
end

%% Save comparison figure

exportgraphics(gcf, ...
    "results/original_vs_enhanced.png", ...
    "Resolution",300);

%% Save enhanced image

imwrite(enhanced, ...
    "results/enhanced_image_01.png");

%% Display information

fprintf("Original size: ");
disp(size(img));

fprintf("Enhanced size: ");
disp(size(enhanced));

fprintf("Enhanced image type: %s\n", ...
    class(enhanced));

disp("Part 5 preprocessing test completed.");
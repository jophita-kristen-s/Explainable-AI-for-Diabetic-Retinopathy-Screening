%% ORGANIZE DIABETIC RETINOPATHY DATASET

clear;
clc;

%% 1. Read training labels

trainTable = readtable("DR_Project/train.csv");

%% 2. Location of original images

imageFolder = "DR_Project/train";

%% 3. Create output folder

outputFolder = "organized_train";

if ~isfolder(outputFolder)
    mkdir(outputFolder);
end

%% 4. Create folders 0, 1, 2, 3 and 4

for classNumber = 0:4

    classFolder = fullfile(outputFolder, string(classNumber));

    if ~isfolder(classFolder)
        mkdir(classFolder);
    end

end

%% 5. Process every image

for i = 1:height(trainTable)

    % Get image ID
    imageID = string(trainTable.id_code(i));

    % Get DR diagnosis
    diagnosis = trainTable.diagnosis(i);

    % Original image path
    sourceFile = fullfile(imageFolder, imageID + ".png");

    % Destination folder
    destinationFolder = fullfile( ...
        outputFolder, ...
        string(diagnosis));

    % Destination image
    destinationFile = fullfile( ...
        destinationFolder, ...
        imageID + ".png");

    % Copy image
    if isfile(sourceFile)

        copyfile(sourceFile, destinationFile);

    else

        fprintf("Image not found: %s\n", imageID);

    end

end

disp("Dataset organization completed!");
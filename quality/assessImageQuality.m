function quality = assessImageQuality(img)

%% Convert image to grayscale

gray = rgb2gray(img);

%% 1. Sharpness
% Variance of Laplacian

lap = imfilter(double(gray), ...
    fspecial("laplacian"));

sharpness = var(lap(:));

%% 2. Brightness

brightness = mean(gray(:));

%% 3. Contrast

contrast = std2(gray);

%% 4. Retinal field detection

mask = imbinarize(gray);

mask = imfill(mask,"holes");

mask = bwareafilt(mask,1);

%% Calculate retinal field coverage

retinalCoverage = nnz(mask) / numel(mask);

%% Store results

quality.sharpness = sharpness;

quality.brightness = brightness;

quality.contrast = contrast;

quality.mask = mask;

quality.retinalCoverage = retinalCoverage;

end
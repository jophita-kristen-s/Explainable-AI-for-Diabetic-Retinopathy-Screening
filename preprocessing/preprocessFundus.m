function output = preprocessFundus(img)

img = im2uint8(img);

% Resize
img = imresize(img,[512 512]);

% Convert to LAB
lab = rgb2lab(img);

% Extract L channel
L = lab(:,:,1);

% Normalize
L = mat2gray(L);

% CLAHE
L = adapthisteq(L);

% Put enhanced L back
lab(:,:,1) = L * 100;

% Convert back
output = lab2rgb(lab);

% Normalize
output = im2uint8(output);

end
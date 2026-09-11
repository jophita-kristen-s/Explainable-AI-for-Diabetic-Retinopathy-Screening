function [qualityScore, status, scores] = calculateQualityScore(quality)

%% 1. Normalize Sharpness

sharpScore = min(quality.sharpness / 100, 1);

%% 2. Normalize Brightness

brightnessScore = ...
    1 - abs(quality.brightness - 128) / 128;

%% Make sure score is not negative

brightnessScore = max(brightnessScore, 0);

%% 3. Normalize Contrast

contrastScore = ...
    min(quality.contrast / 60, 1);

%% 4. Calculate weighted quality score

qualityScore = ...
    0.4 * sharpScore + ...
    0.3 * brightnessScore + ...
    0.3 * contrastScore;

%% Convert from 0-1 to 0-100

qualityScore = qualityScore * 100;

%% 5. Classify image quality

if qualityScore >= 75

    status = "GOOD";

elseif qualityScore >= 50

    status = "BORDERLINE";

else

    status = "UNGRADABLE";

end

%% Store individual normalized scores

scores.sharpScore = sharpScore;

scores.brightnessScore = brightnessScore;

scores.contrastScore = contrastScore;

end
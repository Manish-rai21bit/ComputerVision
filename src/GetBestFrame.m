function i =GetBestFrame(Mx, My, R)

exclude = inv(K)*[0; 0; 1];
Mx(:, 6) ~= exclude(1)
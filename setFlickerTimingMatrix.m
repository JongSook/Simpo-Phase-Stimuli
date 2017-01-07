function [flickerTimingMatrix] = setFlickerTimingMatrix(numOfFlicker, refreshRate, flickerFrequencies, flickerPhases, symbolDuration)

%% make stimulus image number matrix at each frame
% input:
%    numOfFlicker: Number of stimulus
%    refreshRate: Refresh rate of monitor
%    flickerFrequencies: Stimulus frequencies
%    flickerPhases: Stimulus phases
%    symbolDuration: Stilulus time

% output:
%    flickerTimingMatrix: Stimulus image number matrix at each frame



% Name of flags
includeFlagParameter

%params  
allFlickerNumber = round(refreshRate*symbolDuration);
flickerTimingMatrix = zeros(allFlickerNumber, numOfFlicker);
index = 0: allFlickerNumber-1;

for ii = 1:length(flickerFrequencies)
  for jj = 1:length(flickerPhases)
    flickerTimingMatrix(:, (ii-1)*length(flickerPhases) + jj) = mixGen(flickerFrequencies(ii), flickerPhases(jj), index);
  end
end

end

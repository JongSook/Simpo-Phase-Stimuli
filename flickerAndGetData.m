function [data, time] = flickerAndGetData(ai, samplingFrequency, refreshRate, numOfFlicker, flickerMonitor, stimImage, flickerTimingMatrix, symbolDuration, preFixationTime, postFixationTime)
%% prepare
stimulusLoopIndex = 1:size(stimImage.positions, 1);
preIndex = 1:(preFixationTime * refreshRate);
flickeringIndex = 1:(symbolDuration * refreshRate);
emptyVec = [];
tMatrix = flickerTimingMatrix + 1;

%% start
start(ai);

%% pre-flickering
for jj = preIndex
  for ii = stimulusLoopIndex
    Screen('DrawTexture', flickerMonitor, stimImage.textures(tMatrix(1, ii)), emptyVec, stimImage.positions(ii, :));
  end
  Screen('Flip', flickerMonitor);
end

%% get data on stimuli intarval
for jj = flickeringIndex
  for ii = stimulusLoopIndex
    Screen('DrawTexture', flickerMonitor, stimImage.textures(tMatrix(jj, ii)), emptyVec, stimImage.positions(ii, :));
  end
  Screen('Flip', flickerMonitor);
end

%% get data
allLength = (preFixationTime + symbolDuration +postFixationTime) * samplingFrequency;
[data, time] = getdata(ai, allLength);

%% stop
stop(ai);
end

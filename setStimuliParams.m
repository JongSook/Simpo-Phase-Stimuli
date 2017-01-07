function [flickerFreqs flickerPhases preFixationTime postFixationTime numOfFlicker] = setStimuliParams

%% set parameters about stimulus
% output:
%    flickerFreqs: Stimulus frequencies [Hz]
%    flickerPhases: Stimulus phases [rad]
%    preFixationTime: Interval time [s] before stimulus start 
%    postFixationTime: Interval time [s] after end stimulus
%    numOfFlicker: Number of stimulus


% Name of flags
includeFlagParameter



% set sitmuli parameters
preFixationTime = 1.5; % in increments of 0.5 sec
postFixationTime = 1.5; % in increments of 0.5 sec

% set stimuli frequency and phase

freqs(1,:) =  [8:20];
freqNumber = 4;
flickerFreqs = zeros(1,freqNumber);
phaseNumber = 4;


for ii=1:freqNumber
	flickerFreqs(ii) = inputCheck('Input flicker Frequency.', freqs(1,:));
end

flickerPhases = (0:phaseNumber-1).*(2*pi/phaseNumber);

numOfFlicker = freqNumber*phaseNumber;

	
end

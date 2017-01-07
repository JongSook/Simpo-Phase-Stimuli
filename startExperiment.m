function startExperiment
% experiment of multi-freq, multi-phase SSVEP 

%% SETTING
	
	% Name of flags
	includeFlagParameter
	
	% HardwareSetting
	includeHardwareSetting
	
		
	%% Experiment setting wizerd
	[...
	subject,...
	numOfTrial,...
	symbolDuration,...
	startNumber...
	] = settingWizard;
	
	
	
	%% Stimuli setting (initialize)
	[...
	flickerFreqs,...
	flickerPhases,...
	preFixationTime,...
	postFixationTime,...
	numOfFlicker...
	] = setStimuliParams;
	
	
	%% Stimuli timing (initialize)
	[flickerTimingMatrix]= setFlickerTimingMatrix(...
    numOfFlicker, refreshRate, flickerFreqs, flickerPhases, ...
    symbolDuration);
	
  
  
	%% PREPARING
	% Open the flicker window and load images
	[...
	flickerMonitor,...
	stimImage,...
	glow,...
	BGColor,...
	soundwave ...
	] = openFlickerWindow(numOfFlicker, screenNum);

	%% Reference checker board
    %RefstimImage = openRefFlickerWindow(flickerMonitor);
		%refFlickerTiming = zeros(length(flickerTimingMatrix),1);
		%refFlickerTiming(1:2:length(flickerTimingMatrix)) = 1;
		%flickerTimingMatrix = [flickerTimingMatrix refFlickerTimingMatrix];
    %stimImage.positions = [stimImage.positions; RefstimImage.positions];
   
  correctCommandsVector = randperm(numOfFlicker);
  for ii = 1:ceil(numOfTrial/numOfFlicker)-1
  	correctCommandsVector = [correctCommandsVector, randperm(numOfFlicker)];
  end
  
	%% MEASUREMENT
	trial = numOfTrial;
	while trial > 0
    
    
    %allDataLength = (preFixationTime + postFixationTime +  symbolDuration) * samplingFrequency;
    %data = zeros(allDataLength, chNumber);
    %time = zeros(allDataLength,1);
    
		correctCommands = correctCommandsVector(numOfTrial - trial + startNumber);
  	
	
    
		% Show message to let press any key.
		Screen('FillRect', flickerMonitor, BGColor)
		%Screen('DrawText', flickerMonitor, 'Press any key to start.', 320, 1000);
		Screen('DrawText', flickerMonitor, [num2str(numOfTrial - trial + 1) '/' num2str(numOfTrial)], 1760, 1000);
		Screen('DrawTexture', flickerMonitor, glow.texture, [], glow.positions(correctCommands,:))

    for ii = 1:size(stimImage.positions,1)
		    Screen('DrawTexture', flickerMonitor, stimImage.textures(1), [], stimImage.positions(ii, :))
    end
		Screen('Flip', flickerMonitor);
		
		% Create an A/D converter.
    
		ai = initAi(EEGChannels, samplingFrequency, refreshRate);
		% set(ai, 'SamplesAcquiredFcnCount', sampleRate/refreshRate);

    pause

		timeStr = yyyymmddHHMMSS;
		startSec = GetSecs;

		% START FLICKERING AND RECORDING
		[data, time] = flickerAndGetData(ai, samplingFrequency, refreshRate, numOfFlicker, flickerMonitor, stimImage,...
    	flickerTimingMatrix, symbolDuration, preFixationTime, postFixationTime);
	
		%% STOP RECORDING
		delete(ai);
		endSec = GetSecs;
	
		% Output secs.
		fprintf('\nElapsed time: %2.5f s.\n', endSec - startSec);
		%fprintf('Data acquisition time: %2.5f s.\n\n', time(round(t*samplingFrequency)));
	
		% Show blank screen.
		Screen('Flip', flickerMonitor);

  	%% display data
  		plotChannelNumber = 2
  		filterOrder = 3;
        w = [2 100] / (0.5 * samplingFrequency);
    	[B, A] = butter(filterOrder, w);
    	filteredData = filtfilt(B, A, data);
  		freq = 0: (1/symbolDuration) :(samplingFrequency/2);
  		
  		sample = (preFixationTime + (1: symbolDuration)) * samplingFrequency;
  		% time domain
  		figure(1)
      
			plot(sample, filteredData(sample, plotChannelNumber));
			%xlim([sample(1) sample(length(sample))]);
			ylim([-2.5 2.5])
    		
      % frequency domain
    	%figure(2)
			
        %	spec = fft(filteredData(sample, plotChannelNumber));
        %	plot(freq(1: (length(freq)-1)), abs(spec(1: (length(freq)-1))))
       %	xlim([0 50])
        %	ylim([0 100])
       
		
	%% SAVING
    	
           % if checkEEGData(data) ==1
                saveData(...
                data,...
                time,...
                timeStr,...
                samplingFrequency,...
                flickerFreqs,...
                flickerPhases,...
                symbolDuration,...               
                correctCommands,...
                preFixationTime,...
                postFixationTime,...
                subject)
			
          %  else
          %       trial = trial+1;
          %  end
      
      
      clear data
      clear time
	
	%% MEASUREMENT SETTING (CONTINUE)
		if trial == 1
			trial = inputCheck('Continue?', 0:100);
		
			if trial
            	%setOnetimeParams
			end
		else
			trial = trial - 1;
			sound(soundwave(1,:));
		end
	
	end   %(end while) 


	
	
	%% CLOSE FLICKER WINDOW
	closeFlickerWindow(flickerMonitor);
	clear all

end
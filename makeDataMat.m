subject = input('Input subject name: ', 's');

load(['EEG/' subject '/parameter'])

load(['EEG/' subject '/' fileName(1,:)])
dataMat = zeros([size(data) size(fileName,1)]);
labelMat = zeros(size(fileName,1),1);



for ii= 1:size(fileName,1)
 load(['EEG/' subject '/' fileName(ii,:)])

 dataMat(:,:,ii) =data;
 labelMat(ii) = correctCommands;
 %labelMat(ii) = recover(correctCommands);
 
end

data = permute(dataMat,[2 1 3]);
label = labelMat;
samplingRate = samplingFrequency(1);
frequencies = flickerFreqs(1,:);
phases = flickerPhase(1,:);
preIntervalTime = preFixationTime(1);
flickerTime = symbolDuration(1);
postIntervalTime =  postFixationTime(1);
save([subject '.mat'],'data','label','frequencies','samplingRate','phases','preIntervalTime','postIntervalTime','flickerTime')
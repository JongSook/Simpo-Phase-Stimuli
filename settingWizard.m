function [subject, trial, symbolDuration, startNumber] = settingWizard
	
%% set parameters
% output:
%    subject: subject name (for naming of save data)
%    trial: trial number
%    symbolDuration: stimulus time [s]
%    startNumber: give target number at first trial (if target numbers gived ramdomly, 'startNumber' don't work) 
	
	% Name of flags
	includeFlagParameter
  
	subject = input('Input subject name: ', 's');
	trial = inputCheck('How many trials?', 1:480);	
  symbolDuration = inputCheck(['Input the SYMBOL DURATION (sec).'], .5:.1:160);
	startNumber = inputCheck('Input start number', 1:16);
end
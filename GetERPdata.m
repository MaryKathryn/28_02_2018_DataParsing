%Get data to analyze ERPs for the following input data for a given vector of event times; 
% * Averaged 16 contacts
% * Raw data from one electrode
%Kathryn McIntosh 
%August 16th, 2018 

%Input vector must be made from codes sent to NEV file first 
%Example that this code works with this

%openNEV('read', "D:\Testing\NSP3_Lennon_joyTrain_20180816030.nev")
%rewardTimes = GetRewardTimes_2018_08_15(NEV);
    %this is a functions that returns a vector of the reward times in a 
    %NEV file. 
%openNSx('read','D:\Testing\NSP3_Lennon_joyTrain_20180816030.ns4');
%Then get data from one electrode 
%In this case the fileType is 'NS4' but you could also upload averaged data 
%if you do that make sure type is 'avShanks'




function  ERPdata = GetERPdata(data,NEV) %data can be NS4/or averaged shanks 

%If you're unsure of the sampling rate run this line  
%srate = NS4.MetaTags.SamplingFreq; %sampling freq for this session/data
%file instead of the following line

%Initialization
srate = 10000 %10k samples per second
pnts = NS4.MetaTags.DataPoints(1,2); %number of data points is in 2nd col
eventIndex = 1;
ERPdata = [];
ERPDataStart = 0;
ERPDataEnd = 0;   
wPeakFreq = 10; %peak or center frequency of the wavelet
    

%% Get a row vector of times for what ever event you want here!
%reward
rewardTimes  = GetRewardTimes_2018_08_15(NEV);
dims = size(rewardTimes);
nTrials = dims(1,2); %nTrials = number of rewards for this trial
%Take the times when a reward was given make that into a sample number (or
%index) 
rewardSamp = rewardTimes * srate; 
wpnts = 500001;  %wavelet points should match the number of samples (so the time *10k) that you will be evaluating the ERP for 
%1s before 4s after is 50 000 samps + the 1 samp the thing happened at

%% Wavelet definition 10Hz to extract ERP
wavetime   = -1:1/srate:1;
n_conv     = length(wavetime)+wpnts-1;
waveletfft = fft(exp(2*1i*pi*wPeakFreq.*wavetime) .* exp(-wavetime.^2./(2*(5/(2*pi*wPeakFreq))^2))/20,n_conv);
data10hz   = [];


if fileType == NS4
    %this means the function user passed one row of a lot of samples of raw
    %voltage data to this func. 
    
    voltageRec = NS4.Data{1,2}; %each row of voltage rec will be another electrode
    
    %% Error handling
    %make sure index - 10 000 doesnt go below 0 and that index + 40 000 doesn't go
    % above rize of the data matrix (therefore leave matrix dimensions/cause an error)
    %also get size of reward matrixto make sure we don't exceed those dims
    %later
    sizeVoltageRec = size(voltageRec); %this will be a 64 x (#samps) array
    samps = sizeVoltageRec(2); %Number of cols = number of samples for session
    sizeRewardTimes = size(rewardTimes);
    maxRewardSamp = sizeRewardTimes(2); %Last reward sample I have to plot 
    
    %%Start filling the ERP Matricies 
    
    %%%%stopped here%% edit below 
    
while rewardIndex <= maxRewardSamp &&  ERPDataEnd < samps  &&  ERPDataStart < samps
    
    ERPDataStart = rewardSamp(rewardIndex);
    ERPDataStart = ERPDataStart - 10000;
    ERPDataEnd = rewardSamp(rewardIndex);
    ERPDataEnd =  ERPDataEnd + 40000;
    
    if (ERPDataStart < 0)
        rewardIndex = rewardIndex + 1 % move on to the next reward
        
    else
        %Row is just the electrode number, and the cols go from rew-10k to
        %rew+20k samples 
        ERPdata(rewardIndex,:) = voltageRec(1,ERPDataStart:ERPDataEnd);
        rewardIndex = rewardIndex + 1; % move on to the next reward
    end 
      
end %while


    
elseif fileType == avShanks
    
    %do nothing for noe
    
else 
    %error handling
    printf('I have not writen code to handle this file type yet, sorry! - Kathryn\n')
end


end

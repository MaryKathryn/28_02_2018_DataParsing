%Plot ERP for a specified electrode
%Kathryn McIntosh 
%August 16th, 2018 


% IMPORTANT If you just started with data Data{1,1} make sure you also do Data{1,2}
% first run: rewardTimes =  GetRewardTimes_2018_08_15(NEV); then delete
% your NEV file for memory

function  ERPdata = PlotERPs_2018_08_16(NS4,etrode,rewardTimes)

%Variables 
%rewardTimes =  GetRewardTimes_2018_08_15(NEV);
%voltageRec = NS4.Data(etrode,:); %Get the whole voltage recording for that electrode
voltageRec = NS4.Data{1,2}(etrode,:); 
srate = NS4.MetaTags.SamplingFreq; %sampling freq for this session/data file 
wpnts = 30001;
pnts = NS4.MetaTags.DataPoints(1,2); %number of data points
nTrials = 10; %num rewards for aug 15th  
rewardIndex = 1;
ERPdata = [];
ERPDataStart = 0;
ERPDataEnd = 0;


%Wavelet definition
wavetime   = -1:1/srate:1;
n_conv     = length(wavetime)+wpnts-1;
waveletfft = fft(exp(2*1i*pi*10.*wavetime) .* exp(-wavetime.^2./(2*(5/(2*pi*10))^2))/10,n_conv);
data10hz   = [];

%Get data where we should find an ERP
%Want to plot 1 second of data before and 2 seconds after 

%But first, some error handling
%make sure index - 10000 doesnt go below 0 and that index + 20 0000 doesn't go
% above rize of the data matrix (therefore leave matrix dimensions/cause an error)
%also get size of reward matrixto make sure we don't exceed those dims
%later
sizeVoltageRec = size(voltageRec); 
samps = sizeVoltageRec(2); %Number of cols = number of samples for session

sizeRewardTimes = size(rewardTimes);
maxRewardSamp = sizeRewardTimes(2); %Last reward sample I have to plot 

 
%Take the times when a reward was given make that into a sample number (or
%index) 
rewardSamp = rewardTimes * srate; 

%Put the potentials from data(rewardSamp - 10 000) to data(rewardSamp + 20
%0000) into a row vector and increment row for wach reward
while rewardIndex <= maxRewardSamp &&  ERPDataEnd < samps  &&  ERPDataStart < samps
    
    ERPDataStart = rewardSamp(rewardIndex);
    ERPDataStart = ERPDataStart - 10000;
    ERPDataEnd = rewardSamp(rewardIndex);
    ERPDataEnd =  ERPDataEnd + 20000;
    
    if (ERPDataStart < 0)
        rewardIndex = rewardIndex + 1 % move on to the next reward
        
    else
        %Row is just the electrode number, and the cols go from rew-10k to
        %rew+20k samples 
        ERPdata(rewardIndex,:) = voltageRec(1,ERPDataStart:ERPDataEnd);
        rewardIndex = rewardIndex + 1; % move on to the next reward
    end 
      
end %while

sample = linspace(0,wpnts,wpnts);

for triali=1:nTrials
    
    % plot data from this trial
    subplot(nTrials,3,(triali-1)*3+1)
    plot(sample,ERPdata(triali,:))
    %set(gca,'xlim',[-250 850],'ylim',[-2.2 2.2])
    
    % plot ERP from trial 1 to current
    subplot(nTrials,3,(triali-1)*3+2)
    plot(sample,mean(ERPdata(1:triali,:),1))
    %set(gca,'xlim',[-250 850],'ylim',[-2.2 2.2])
    
    % convolve with 10 Hz wavelet
    convolution_result_fft = ifft(waveletfft.*fft(ERPdata(triali,:),n_conv)) * sqrt(5/(2*pi*10));
    convolution_result_fft = convolution_result_fft(floor(length(wavetime)/2)+1:end-floor(length(wavetime)/2));
    data10hz(triali,:) = abs(convolution_result_fft).^2;
    
    % plot 10 Hz power
    subplot(nTrials,3,(triali-1)*3+3)
    plot(sample,mean(data10hz(1:triali,:),1))
    %set(gca,'xlim',[-250 850],'ylim',[-.1 .8])
    
end


end 
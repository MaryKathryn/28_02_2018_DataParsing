%Plot all the times that a reward was given for a specified electrode
%Kathryn McIntosh 
%August 15th, 2018 

%Must have function GetRewardTimes_2018_08_15 in path to run

function PlotRewardTimes_2018_08_15(NEV,NS4,etrode)

%initialization 
index = 1;
srate = 10000;

rewardTimes =  GetRewardTimes_2018_08_15(NEV); %Array of all the times (in seconds) that a reward was given

voltageRec = NS4.Data(etrode,:); %Get the whole voltage recording for that electrode

%Now get the number of samples and number of rewardTimes for later
sizeVoltageRec = size(voltageRec); 
samps = sizeVoltageRec(2); %Number of cols = number of samples for session

sizeRewardTimes = size(rewardTimes);
maxRewardSamp = sizeRewardTimes(2); %Last reward sample I have to plot 

%Find the sample number that each of the rewards was given on 
%In our case we know sampling rate was just 10k so I can take sec*(samp/sec)
rewardSamp = rewardTimes * srate;

%Plot the voltage trace 

%linear array from 0 to # of samples in #samples steps 
sampleNumber = linspace(0,samps,samps); 

%plot sample number vs the voltage at that sample
plot(sampleNumber,voltageRec,'b');

hold on; %hold on to the current plot because we're going to plot over it

%plot arrows where a reward was received 
while index < maxRewardSamp 
    x = rewardSamp(index);
    X = [x,x]; %this is the important one, which sample did reward start on
    Y = [0,-2000];%this is just for looks/personal preference, how high do you want arrow to be?
    %annotation('arrow',X,Y);
    
    plot(X,Y);
    
    index = index + 1; 
    
end %while 

end %function

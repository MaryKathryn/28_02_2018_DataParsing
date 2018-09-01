%Find all the times that a reward was given using eventMarkers
%Kathryn McIntosh 
%August 14th, 2018 

%Run with this command: rewardTimes = GetRewardTimes_2018_08_15(NEV)

function [rewardTimes] =  GetRewardTimes_2018_08_15(NEV)

%For this to work ML Port/Line assignments must be (Port 1 Lines 1-7) and 
%(Port 2 Lines 0 to 7) otherwise codes will be fucky

%Initialization 
rewardTimes = [];
rewardNumber = 1;

% X by 1 vector of all the event markers sent from ML to Black Rock
eventMarkers = NEV.Data.SerialDigitalIO.UnparsedData; 

%Make a vector of all of the times eventMarker was 1024 (reward code)
sizeOfeventMarkers = size(eventMarkers);
maxIndex = sizeOfeventMarkers(1);
index = 1;

while index < maxIndex 
    %traverse eventMarkers and if you get a 1024 put the time at index
    %found in NEV.Data.SerialDigitalIO.TimeStampSec(1,index) the times are organized in one row
    %many cols 
    
    if eventMarkers(index) == 1024 %if at this index the event marker was the one for a reward
        
        timeOfReward = NEV.Data.SerialDigitalIO.TimeStampSec(1,index); % get the time of reward 
        
        %Add this time into the big vector of times
        rewardTimes(rewardNumber) = timeOfReward; 
        rewardNumber = rewardNumber + 1; 
        index = index + 1;
    else 
        %just move on to the next eventMarker 
        index = index + 1;
    end  %if 
    
end % while
end % function

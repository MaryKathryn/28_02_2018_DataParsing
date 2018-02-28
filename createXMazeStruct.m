function logicXMazeStruct = createXMazeStruct(logicData)

%eventially want to be able to pass in the bhv2 files and use mlread to
%extract the data 

%XMazeStruct has 3 fields, 2 of type struct and one of type cell 

%Create the XMaze, SessionInfo and Trials structs
logicXMazeStruct = struct;

tempSessionInfo = struct;
tempTrials = struct;

%Create the first row of the TrialSummary cell field
tempTrialSummary = {'Trial Number', 'Direction', 'Training Phase', 'Context', 'Goal West Color','Goal East Color','Outcome'};

%Fill the TempTrialSummary with cells of logicData (Use Trials to save time)
%names=fieldnames(XMazeStruct.Trials) gets all the names of the trials 
%Check the size of Trials to see how many times I have to loop through to
%make Trial Summaries 
%dynamic indexing of Trials XMazeStruct.Trials.(names{i}) 

%Initialize the SessionInfo fields 

%Add TrialSummary, SessionInfo and Trials as fields in the XMazeStruct
logicXMazeStruct(:).TrialSummary = tempTrialSummary;
logicXMazeStruct(:).Trials = tempTrials;
logicXMazeStruct(:).SessionInfo = tempSessionInfo;

%While you still have trials in this session, create a new struct
%Name the trial using the date in the logicData field TrialDateTime
%populate Trials as these structures are created 


%New naming section using a reference date and the current date time
%takes trial # as an input 
temp = size(logicData);
numRows = temp(2);
i=1;
while i <= numRows
    tempStruct = struct; 
    tempName = defineTrialID(i,01);
    logicXMazeStruct.Trials(:).(tempName) = tempStruct; %adds a 1x1 struct with the name that defineTrialID spat out 
    i = i+1;
end

%Populate those structs 
nameList = fieldnames(logicXMazeStruct.Trials); % now For each ID in nameList add an empty version of all of the fields

%%=======================================================================================================
%%=====================================Initializs Fields in "Trials"=====================================
%%=======================================================================================================

j=1;

while j <= numRows
    
    %initializing, using 0 and 'empty' for initialization as case to check if data didn't input properly 
    logicXMazeStruct.Trials.(nameList{j}).Context = 0; 
    logicXMazeStruct.Trials.(nameList{j}).ContextName = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).ContextMat = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).Direction = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).TrainingPhase = 0;
    
    logicXMazeStruct.Trials.(nameList{j}).GoalWestColor = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).GoalWestRew = 0;
    logicXMazeStruct.Trials.(nameList{j}).GoalWestHier = 0;
    
    logicXMazeStruct.Trials.(nameList{j}).GoalEastColor = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).GoalEastRew = 0;
    logicXMazeStruct.Trials.(nameList{j}).GoalEastHier = 0;
    
    logicXMazeStruct.Trials.(nameList{j}).GoalLeft = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).GoalRight = 'empty';
    
    logicXMazeStruct.Trials.(nameList{j}).OutcomeCorr = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).OutcomeColor = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).OutcomeHier = 0;
    logicXMazeStruct.Trials.(nameList{j}).OutcomeDirec = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).OutcomeSide = 'empty';
    logicXMazeStruct.Trials.(nameList{j}).OutcomeWord = 'empty';
    
    logicXMazeStruct.Trials.(nameList{j}).Unreal_States = {};
    logicXMazeStruct.Trials.(nameList{j}).Unreal_PosXPosYRot = [0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).Unreal_Times = 0;
    
    logicXMazeStruct.Trials.(nameList{j}).EyeSamplesBad = [0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).EyeSamples = [0,0,0,0];
    
    logicXMazeStruct.Trials.(nameList{j}).ITC18StartTime = 0;
    logicXMazeStruct.Trials.(nameList{j}).SOT_Time = 0;
    logicXMazeStruct.Trials.(nameList{j}).EOT_Time = 0;
    logicXMazeStruct.Trials.(nameList{j}).SyncPulse = [0,0];
    logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_deg = [0,0,0,0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).GoalsOnset = 0;
    logicXMazeStruct.Trials.(nameList{j}).ContextOnset = 0;
    logicXMazeStruct.Trials.(nameList{j}).DecisionOnset = 0;
    logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_deg2 = [0,0,0,0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).NonSmoothedEyes = [0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_deg2_OS = [0,0,0,0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).NonSmoothedEyes_OS = [0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_degOnScreen = [0,0,0,0,0,0];
    logicXMazeStruct.Trials.(nameList{j}).NonSmoothedEyesOnScreen = [0,0,0];
   
    j=j+1;
end


%%=======================================================================================================
%%=====================================Initializs Fields in "SessionInfo"================================
%%=======================================================================================================
    
    logicXMazeStruct.SessionInfo.MonkeyName = 'empty';
    logicXMazeStruct.SessionInfo.Date = 'empty';
    logicXMazeStruct.SessionInfo.SetupID = 'empty';
    logicXMazeStruct.SessionInfo.Context1NParams = cell(5,3);
    logicXMazeStruct.SessionInfo.Context1SParams = cell(5,3);
    logicXMazeStruct.SessionInfo.Context2NParams = cell(5,3);
    logicXMazeStruct.SessionInfo.Context2SParams = cell(5,3);
    logicXMazeStruct.SessionInfo.EyeCalibration = [0,0;0,0;0,0;0,0;0,0];
    logicXMazeStruct.SessionInfo.QuadrantCorrect = [0,0;0,0;0,0;0,0];
    logicXMazeStruct.SessionInfo.ScreenHeight = 33.6600; %predefined 
    logicXMazeStruct.SessionInfo.ScreenWidth = 44.4500; %predefined 
    logicXMazeStruct.SessionInfo.ScreenDistance = 80.6450; %predefined 
    logicXMazeStruct.SessionInfo.FileName = 'empty';

%%=================================================================================================
%%=====================================Fill Fields in "Trials"=====================================
%%=================================================================================================
    
%Example:
%MonleyLogic puts Context (number) in logicData(1).TaskObject.Attribute{1,1}{1,2}
%loop through each trial logicData(logicData(2),logicData(3)..logicData(n))

k=1;

while k <= numRows
    ContextNumber = logicData(k).TaskObject.Attribute{1,1}{1,2};
    GoalEastColor = logicData(k).TaskObject.Attribute{1,2}{1,3};
    GoalWestColor = logicData(k).TaskObject.Attribute{1,3}{1,3};
    GoalWestHier = logicData(k).TaskObject.Attribute{1,3}{1,2};
    GoalEastHier = logicData(k).TaskObject.Attribute{1,2}{1,2};
    Unreal_States = logicData(k).UEData.UE_State;  
    Unreal_Position = logicData(k).UEData.UE_Position;
    Unreal_Rotation = logicData(k).UEData.UE_Rotation;
    Unreal_Times = logicData(k).UEData.UE_Time;
    OutcomeWordNum = logicData(k).TrialError;
    

%Finding direction here from a long string of info
stringToParse = logicData(k).ObjectStatusRecord.SceneParam(1).AdapterArgs{1,2}{1,2}; %gives me a string of stuff to parse
splitUpString = strsplit(stringToParse); %now it's all split up
almostGotIt = splitUpString{5}; %access the section of that which has the direction info but also has an extra bracket
Direction = erase(almostGotIt,"}");

if Direction == '1';
    Direction = 'North';
elseif Direction == '0';
    Direction = 'South';
else
    Direction = 'error';
end

    
%Determine Context Name and Material from the number   
    if (ContextNumber) == 2 
        ContextName = 'ML_Material_1';
        ContextMat = 'Steel';
    elseif (ContextNumber) == 1
        ContextName = 'ML_Material_2';
        ContextMat = 'Wood';
        else
            ContextName = 'error';
            ContextMat = 'error';
    end
    
    
%Case statement to determine West Goal Color
   switch GoalWestColor
       case 'B'
           GoalWestColor = 'Blue';
       case 'R'
           GoalWestColor = 'Red';
       case 'G'
           GoalWestColor = 'Green';
       case 'C'
           GoalWestColor = 'Cyan';  
       otherwise
           GoalWestColor = 'error';
   end
    
   
%Case statement to determine East Goal Color
   switch GoalEastColor
       case 'B'
           GoalEastColor = 'Blue';
       case 'R'
           GoalEastColor = 'Red';
       case 'G'
           GoalEastColor = 'Green';
       case 'C'
           GoalEastColor = 'Cyan';
       otherwise
           GoalEastColor = 'error';
   end
   
   
%This one is a weird and arbitraty one that I'm just doing to make the hierarchy look like it does in monkeyLab 
if GoalWestHier == 1
    GoalWestHier = 3;
    
elseif GoalWestHier == 3
    GoalWestHier = 1; 
    
elseif GoalWestHier == 2
    GoalWestHier = 2;
    
else
    GoalWestHier = 0;
end

%Same thing for East Goal 
if GoalEastHier == 1
    GoalEastHier = 3;
    
elseif GoalEastHier == 3
    GoalEastHier = 1; 
    
elseif GoalEastHier == 2
    GoalEastHier = 2;
    
else
    GoalEastHier = 0;
end

%Find the left and right goal colors based on the Direction of travel 
if Direction == 'North'
    GoalLeft = (GoalWestColor);
    GoalRight = (GoalEastColor);
    
elseif  Direction == 'South'
    GoalLeft = (GoalEastColor);
    GoalRight = (GoalWestColor);
    
else
    GoalLeft = 'error';
    GoalRight = 'error';
    
end

% %% Determining GoalEastRew and GoalWestRew 
% 
% %for the 2 condition case only 
% 
% reward = (logicData(k).RewardRecord.EndTimes)-(logicData(k).RewardRecord.StartTimes);
% rewardTest = reward(1);
%       
% if GoalWestHier > GoalEastHier && (rewardTest >= 100) %West was correct and we went west 
%     GoalWestRew = reward;  
% 
% elseif GoalWestHier > GoalEastHier && (rewardTest < 1) %West was correct and we went east
%     GoalWestRew = reward;  
% 
% elseif GoalWestHier < GoalEastHier && (rewardTest >= 100) %East was correct and we went east
%     GoalEastRew = reward;  
%     
% elseif GoalWestHier < GoalEastHier && (rewardTest < 0) %East was correct and we went west
%     GoalEastRew = reward;   
% 
% else
%     GoalEastRew = 0;
%     GoalWestRew = 0;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%consider what would happen if you had not a full reward (3) but a 2 level reward 

%% Handling 1st row 1st trial

%Parsing state data for some reason it's the only row with a ton of stuff in it separated by '\'
if k == 1 
    Unreal_States{1} = {'OnBlackWalking'}; 
else
end

%Parsing position data the first trial first row is always weird so just set that to -1122.34,2249.29,-429.00 first. 
if k == 1 
    Unreal_Position{1} = '-1122.34,2249.29,-429.00'; 
else
end

%Parsing Time data, the first trial first row is a mess so I'm just setting it to 1ms less thanthe second time. 
if k == 1 
    rowTwoTime = logicData(1).UEData.UE_Time{2,1};
    startTimeIsoTwo = strsplit(rowTwoTime,':');
    startTimeStrTwo = startTimeIsoTwo{1,3};
    startTimeNumTwo = str2num(startTimeStrTwo);
    startTimeNum = startTimeNumTwo - 0.1; %subtract 1ms from second recorded time to get start time (instead of that row of times)
    
    %now putting everything back together 
    startTimeEnd = num2str(startTimeNum); %turn that 1ms less time back into a string
    startTime= strcat(startTimeIsoTwo{1,1},':',startTimeIsoTwo{1,2},':',startTimeEnd);
    
    Unreal_Times{1} = startTime;
else
end

%Parsing rotation data the first trial first row is always weird so just set that to 21063 first. 
if k == 1 
    Unreal_Rotation{1} = '21063'; 
else
end

%Turning X,Y,Z position ito 3 separate cols with the parse position function
Unreal_Position = parsePosition(Unreal_Position);


%Make UE_Rotation into an array of doubles 
Unreal_Rotation = cellfun(@str2double,Unreal_Rotation);


%Replacing the Z col with the Unreal Rotation information 
Unreal_Position(:, 3) = Unreal_Rotation;


%% Decoding OutcomeWord with the ML error number 

switch OutcomeWordNum
    case 0
        OutcomeWord = 'correct';
    case 1
         OutcomeWord = 'no response ';
    case 2
        OutcomeWord = 'late response';
    case 3
        OutcomeWord = 'break fixation';
    case 4
        OutcomeWord = 'no fixation';
    case 5
        OutcomeWord = 'early response';
    case 6
        OutcomeWord = 'incorrect';
    case 7
        OutcomeWord = 'lever break';
    case 8
        OutcomeWord = 'ignored';
    case 9 
        OutcomeWord = 'aborted';
    otherwise 
        OutcomeWord = 'error';
end

%% Getting OutcomeCorr from OutcomeWord Number

if OutcomeWordNum == 0 
    OutcomeCorr = 'correct';
else 
    OutcomeCorr= 'incorrect';
end
%%
    logicXMazeStruct.Trials.(nameList{k}).Context = ContextNumber; %Field name "Context" will be 1 or 2
    logicXMazeStruct.Trials.(nameList{k}).ContextName = ContextName; %ML_Material_1, ML_Material_2 or error
    logicXMazeStruct.Trials.(nameList{k}).ContextMat = ContextMat; %Steel, Wood or error
    logicXMazeStruct.Trials.(nameList{k}).Direction = Direction; %North or South 
    logicXMazeStruct.Trials.(nameList{k}).TrainingPhase = logicData(k).Block;%Defines what are the Possible trial types (as defined in the txt file)
     
    logicXMazeStruct.Trials.(nameList{k}).GoalWestColor = GoalWestColor;
%     logicXMazeStruct.Trials.(nameList{k}).GoalWestRew =
    logicXMazeStruct.Trials.(nameList{k}).GoalWestHier = GoalWestHier;
%     
    logicXMazeStruct.Trials.(nameList{k}).GoalEastColor = GoalEastColor;
%     logicXMazeStruct.Trials.(nameList{j}).GoalEastRew = 
    logicXMazeStruct.Trials.(nameList{k}).GoalEastHier = GoalEastHier;
%     
    logicXMazeStruct.Trials.(nameList{k}).GoalLeft = GoalLeft; %Color string based on direction of travel 
    logicXMazeStruct.Trials.(nameList{k}).GoalRight = GoalRight; %Color string based on direction of travel
     
    logicXMazeStruct.Trials.(nameList{k}).OutcomeCorr = OutcomeCorr;
%     logicXMazeStruct.Trials.(nameList{j}).OutcomeColor = 
%     logicXMazeStruct.Trials.(nameList{j}).OutcomeHier = 
%     logicXMazeStruct.Trials.(nameList{j}).OutcomeDirec = 
%     logicXMazeStruct.Trials.(nameList{j}).OutcomeSide = 
    logicXMazeStruct.Trials.(nameList{k}).OutcomeWord = OutcomeWord;
%     
    logicXMazeStruct.Trials.(nameList{k}).Unreal_States =  Unreal_States; % Cell array of states 
    logicXMazeStruct.Trials.(nameList{k}).Unreal_PosXPosYRot = Unreal_Position; %X and Y position and Rotation   
    logicXMazeStruct.Trials.(nameList{k}).Unreal_Times = Unreal_Times;
 
%     logicXMazeStruct.Trials.(nameList{j}).EyeSamplesBad = 
%     logicXMazeStruct.Trials.(nameList{j}).EyeSamples = 
%     
%     logicXMazeStruct.Trials.(nameList{j}).ITC18StartTime = 
%     logicXMazeStruct.Trials.(nameList{j}).SOT_Time = 
%     logicXMazeStruct.Trials.(nameList{j}).EOT_Time = 
%     logicXMazeStruct.Trials.(nameList{j}).SyncPulse = 
%     logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_deg = 
%     logicXMazeStruct.Trials.(nameList{j}).GoalsOnset = 
%     logicXMazeStruct.Trials.(nameList{j}).ContextOnset = 
%     logicXMazeStruct.Trials.(nameList{j}).DecisionOnset = 
%     logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_deg2 = 
%     logicXMazeStruct.Trials.(nameList{j}).NonSmoothedEyes = 
%     logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_deg2_OS = 
%     logicXMazeStruct.Trials.(nameList{j}).NonSmoothedEyes_OS = 
%     logicXMazeStruct.Trials.(nameList{j}).PositionMatrix_degOnScreen = 
%     logicXMazeStruct.Trials.(nameList{j}).NonSmoothedEyesOnScreen = 
%     
    k= k+1;
end


%ContextName is in logicData(1).ObjectStatusRecord.SceneParam(1).AdapterAigs{1,2}
% In a line that looks like this: 
%HCTASKPRESTARTTRIAL {fBob 0} {bIsNorth 1} {bContTrials 1} {bUseLocAsStart 1} {bSerialGoals 0} {bUse
                           %Fog 0} {bUseCues 0} {Textures ML_Steel} {GoalsColor Blue/Red} {strGoalID}


%% Example Params for Trials

% Context: 1
% ContextName: 'ML_Material_2'
% ContextMat: 'Wood'
% Direction: 'North'
% TrainingPhase: 11

% GoalWestColor: 'Cyan'
% GoalWestRew: 0
% GoalWestHier: 3

% GoalEastColor: 'Green'
% GoalEastRew: 0.6000
% GoalEastHier: 1

% GoalLeft: 'Cyan'
% GoalRight: 'Green'

% OutcomeCorr: 'Incorrect'
% OutcomeColor: 'Cyan'
% OutcomeHier: 3
% OutcomeDirec: 'West'
% OutcomeSide: 'Left'
% OutcomeWord: 'Incorrect'

% Unreal_States: {604×1 cell}
% Unreal_PosXPosYRot: [604×3 double]
% Unreal_Times: [604×1 double]

% EyeSamplesBad: [4315×3 double]
% EyeSamples: [4089×4 double]

% ITC18StartTime: 5.9574e+06
% SOT_Time: 5.9574e+06
% EOT_Time: 5.9574e+06
% SyncPulse: [8789×2 double]
% PositionMatrix_deg: [4089×6 double]
% GoalsOnset: 5.9574e+06
% ContextOnset: 5.9574e+06
% DecisionOnset: 5.9574e+06
% PositionMatrix_deg2: [4089×6 double]
% NonSmoothedEyes: [4089×3 double]
% PositionMatrix_deg2_OS: [4089×6 double]
% NonSmoothedEyes_OS: [4089×3 double]
% PositionMatrix_degOnScreen: [4089×6 double]
% NonSmoothedEyesOnScreen: [4089×3 double]

%% Example Params for SessionInfo
%          MonkeyName: 'Woody'
%                Date: '17-Mar-2015'
%             SetupID: '02'
%     Context1NParams: {5×3 cell}
%     Context1SParams: {5×3 cell}
%     Context2NParams: {5×3 cell}
%     Context2SParams: {5×3 cell}
%      EyeCalibration: [2×5 double]
%     QuadrantCorrect: [2×4 double]
%        ScreenHeight: 33.6600
%         ScreenWidth: 44.4500
%      ScreenDistance: 80.6450
%            FileName: 'W_20150317_XMaze.mat'



%%



%testLoop
% j=1
% while j <= numRows
%     fprintf(nameList{j});
%     j=j+1;
% end


%Old Naming section using date and time 
% temp = size(logicData)
% numRows = temp(2)
% i=1
% while i <= numRows 
% 
% %turn the TrialDateTime into a string, logic data row changes every time 
% tempName = num2str(logicData(i).TrialDateTime)
% 
% %remove decimal points
% tempName = erase(tempName,".")
% %remove spaces
% tempName= tempName(~isspace(tempName))
% 
% %append the ID_ part of the name field 
% tempName = strcat('ID_',tempName)
% 
% %make the 1x1 ID structure
% tempStruct = struct
% 
% %add the new ID structure into logicXMazeStruct.Trials
% logicXMazeStruct.Trials(:).(tempName) = tempStruct
% 
% i = i+1
% end
%%

%Delete the temporary structures

%just looking at behavioural codes  
%r = 1;
% 
% while r <= numRows
%     
%     codeInNum = logicData(r).BehavioralCodes.CodeNumbers(2);
%     codeInStr = num2str(codeInNum);
%     fprintf(codeInStr);
%     fprintf('\n');
%    
%     r= r+1;
%     
% end

%% Parse position function
%function parsedStruct = parsePosition(initialStruct)
% 
% %split comma-dilimited sets (cells in cells)
% parsedStructCells = cellfun(@(x)regexp(x,',','split'),initialStruct,'UniformOutput',0) 
% 
% %vertically concatinate the cells, turn 211x1 cell (of 1x3 cells) into a
% %211x3 cell
% parsedStructVC =vertcat(parsedStructCells{:})
% 
% %turn 211x3 cell into 211x3 double 
% parsedStruct = cellfun(@str2double,parsedStructVC);
% 
% end
% 


end



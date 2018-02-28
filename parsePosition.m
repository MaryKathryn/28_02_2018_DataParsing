function parsedStruct = parsePosition(initialStruct)

%split comma-dilimited sets (cells in cells)
parsedStructCells = cellfun(@(x)regexp(x,',','split'),initialStruct,'UniformOutput',0); 


%vertically concatinate the cells, turn 211x1 cell (of 1x3 cells) into a
%211x3 cell
parsedStructVC =vertcat(parsedStructCells{:});

%turn 211x3 cell into 211x3 double 
parsedStruct = cellfun(@str2double,parsedStructVC);

end

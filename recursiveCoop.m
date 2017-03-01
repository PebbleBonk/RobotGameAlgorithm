function reachableStates = recursiveCoop(initStates, visStates, board, lvl )
%CREATEROUTE Summary of this function goes here
%   Detailed explanation goes here

    % init the return value
    reachableStates = visStates;
    
    % See how many robots yet to move:
    initStateCout = size(initStates, 1);
    
    % only one left, simnple cooperation:
    if initStateCout == 1 
        newVisStates = cooperate(initStates, visStates, board);
        reachableStates = mergeCooperation(visStates, newVisStates,lvl+1);
        
    % More than one left, recursive iteration:
    else
        for i =1:initStateCout
            % Select robot moving:
            mover = initStates(i,:);
            tBoard = board;
            
            % Select stationary robots i.e.
            % the robots yet to move:
            newStates = initStates;
            newStates(i,:) = [];
            
            % Place stationary robots:
            for j=1:size(newStates,1)
                tBoard = placeRobot(newStates(j,1:2), rboard);
            end
            
            % Find states the movable robot can reach:
            newVisStates = cooperate(mover, visStates, tBoard);
           
            
            % Forward these spaces to the robot next in turn:
            recVis = recursiveCoop (newStates, newVisStates, board);

            % Combine results saving only the best ones:
            bestOfRound = mergeCooperation(newVisStates, recVis,lvl+i);
            reachableStates = mergeCooperation(reachableStates, bestOfRound, lvl+i);
        end
    end
end


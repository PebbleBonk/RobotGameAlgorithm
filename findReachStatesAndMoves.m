function revVis = findReachStatesAndMoves( curState, board, visitedStates, level)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
        
        
    moves = [[0,1];[1,0];[-1,0];[0,-1]];

    % Check every direction:
    for d = 1:4

        % Move to the next state according to the rules
        nxtState = moveAgent(curState(1:2), board, moves(d,:));

        % Check whether state has been visited before
        alreadyVisited = inArray(nxtState, visitedStates(:,1:2));

        
        % State hasn't been visited before
        if ~prod(nxtState == curState(1:2)) && ~alreadyVisited
            visitedStates = [visitedStates; [nxtState,level]];

            vis = findReachableStates(nxtState, board, visitedStates, level);

            visitedStates = vis;

        % State has been visited before but this route has been shorter
        elseif alreadyVisited  &&  visitedStates(alreadyVisited,3) > level
            vis = findReachableStates(nxtState, board, visitedStates, level);
            
            visitedStates = vis;
            visitedStates(alreadyVisited,3) = level;
        end

        
    end       

    end
    revVis = visitedStates;
    
end

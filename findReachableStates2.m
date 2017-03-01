function revVis = findReachableStates2( agent, board, visitedStates, path)
%FINDREACHABLESTATES2 Summary of this function goes here
%   Detailed explanation goes here
%   TODO: crashes if agent can't move
%   (impossible in real game, but generatable)

    % Recursion limit set to 10 recursive layers:
    if length(path) < 20
        
    moves = [[0,1];[1,0];[-1,0];[0,-1]];
    
    % Check every direction:
    for d = 1:4
        % Add the current move (direction) to the path
        % syntax: [agent id, direction], e.g. 'a1a2'
        % means that agent with id 'a' has made two 
        % moves, one left and one up.
        tPath = strcat([path, agent.Id, int2str(d)]);
        
        % Move to the next state according to the rules
        % Returns a 2x1 matrix
        nxtState = moveAgent(getState(agent), board, moves(d,:));
        
        nState = State(nxtState(1), nxtState(2), tPath, agent.Id);
        
        % Check whether state has been visited before
        alreadyVisited = inArray(nState, visitedStates);
        

        % State hasn't been visited before
        if ~prod(nxtState == getState(agent)) && ~alreadyVisited
            visitedStates = [visitedStates; nState];
            nAgent = agent.Move(nxtState(1), nxtState(2));
            vis = findReachableStates2(nAgent, board, visitedStates, tPath);

            visitedStates = vis;

        % State has been visited before but this route has been shorter
        elseif alreadyVisited  &&  length(visitedStates(alreadyVisited).PathToReach) > length(path)
            nAgent = agent.Move(nxtState(1), nxtState(2));
            visitedStates(alreadyVisited).PathToReach = tPath;
            vis = findReachableStates2(nAgent, board, visitedStates, tPath);
            
            visitedStates = vis;
        end

        
    end       

    end
    revVis = visitedStates;
    
%     shortestPath = 999;
%     for i=1:size(revVis,1)
%         if revVis(i).pathLength < shortestPath && revVis(i).pathLength ~= 0
%             shortestPath = revVis(i).pathLength;
%         end    
%     end
    
end


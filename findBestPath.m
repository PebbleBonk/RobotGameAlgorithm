function bestPath = findBestPath( agents, board, mainAgent, destState, path, level )
%FINDBESTPATH Finds the shortest set of moves to get mainAgent to destState
%
%   agents as array size of 4xn with syntax:
%   [x-coord, y-cood, 'id', 'mobile']
%
% 1.	Repeat for all the agents
% 2.		Find all reachable states
% 3.		If agent == main agent And final state in reachable states:
% 3.1			If count(best path) > count(new path):
% 3.1.1			best path = new path
% 4.		Else if recursion ok
% 4.1			Loop through states found in step 2.
% 4.1.1			Repeat recursively from step 1. 
%                with agents = all agents - current agent
% 4.1.2			If count(best path) > count(new path):
% 4.1.2.1				best path = new path			
% 5.	Return best path

% Initiate return value
bestPath = [];

% Inititate the agents for possible recursion
recurAgents = repmat(Agent(),size(agents));



% === 1. Repeat for all the agents ===
for aMovI=1:size(agents,1)
    
    % If the agent has moved in previous recursion
    % there is no need to move it now, as all the
    % reachable states have been found out:
    if ~agents(aMovI).Mobile
        continue
    end
    
% === 2. Find all reachable states ===
    % Place all stationary agents:
    tBoard = board;
    ac = 1;
    for aStatI=1:size(agents,1)
        if aStatI ~= aMovI
            tBoard = placeRobot(agents(aStatI).getState, tBoard);
            % Add agents to be moved next recursion:
            recurAgents(ac) = [agents(aStatI).mobilize];
            ac = ac+1;
        end
    end
    
    % Find the reachable states for the moving agent
    movingAgent = agents(aMovI);
    initState = State(movingAgent.X,movingAgent.Y,'','a');
    rStates = findReachableStates2(movingAgent, board, ...
                                                   initState, 0);
                                               
%     [rStates, shortestPath] = findReachableStates2(movingAgent, board, ...
%                                                    initState, 0);
    
% []?TODO: rename getState -> getCoords in  Agent class
% [] TODO: Revise recursion limits:
    pt= length(path);
    if pt > 10 || level > 4
        recursionOk = 0;
    else
        recursionOk = 1;
    end
    
% === 3. If agent == main agent And final state in reachable states: ===
    if agents(aMovI) == mainAgent && inArray(destState, rStates)
        % 3.1 If count(best path) > count(new path):
        newPath = rStates(inArray(destState, rStates)).PathToReach;
        if (length(bestPath) > length(newPath) || isempty(bestPath)) && ...
                ~isempty(newPath)
            % 3.1.1 best path = new path
            bestPath = newPath;
        end

% === 4. Else if recursion ok ===
    elseif recursionOk
        level = level+1;
        % 4.1 Loop through states found in step 2.
        for sI=1:size(rStates,1)
            
            % 4.1.1	Repeat recursively from step 1. 
            %       with agents = all agents - current agent
            % The current observable reached state.
            % Set agent immobile so it wont move...
            curAgent = agents(aMovI).Move(rStates(sI).X,rStates(sI).Y);
            recurAgents(ac) = curAgent.immobilize;
            
            curPath = strcat([path, rStates(sI).PathToReach]);
            
            if isempty(rStates(sI).PathToReach)
                continue
            end
            
            recBestPath = findBestPath(recurAgents, board, ...
                                       mainAgent, destState, curPath, level );
            
            % Combine the path to currently observable node
            % with the path to final state
            totalNewPath = strcat(curPath, recBestPath); 
            
            % 4.1.2 If count(best path) > count(new path):
            if (length(bestPath) > length(totalNewPath) || ...
                    isempty(bestPath)) && ~isempty(recBestPath)
                % 4.1.2.1 best path = new path
                
                bestPath = totalNewPath;
            end
        end
    end
end

% === 5. Return best path ===

end


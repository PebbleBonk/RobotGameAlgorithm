function reachableStates = cooperate( robot1State, robot2States, board )
%COOPERATE Summary of this function goes here
%   Returns a 4xn matrix with columns 1,2 being
%   The x and y coordinates of the states robot
%   1 can reach, column 3 being the number of
%   moves it takes for it to get there and 
%   column 4 being the index of the state where
%   robot 2 was when robot 1 started moving.

    % Initial state
    reachableStates = [robot1State,0];
    plo = 0;
    
    % Loop through different robot 2 locations:
    for i = 1:size(robot2States,1)
        r2s = robot2States(i,:);
        
        if r2s(1:2) == robot1State(1:2)
            continue
        end
            
        
        % Place the other robot:
        tBoard = placeRobot([r2s(1), r2s(2)], board);
        
        % See where you can get using this location:
        initState = robot1State;
        visitedStates = reachableStates(1:3);
        rStates = findReachableStates(initState, tBoard, visitedStates,0);
        
        
        if plo
            figure
            plotBoard(board)
            plot (r2s(1),r2s(2),'bo')

            plot(rStates(:,1), rStates(:,2), 'g*')
            plot(reachableStates(:,1), reachableStates(:,2), 'r+')
            plot(initState(1), initState(2),'ro')     
        end
        
        % Combine the already visited wih new and better ones:
        rStatesCon = [rStates, ones(size(rStates,1),1)*i];
        reachableStates = mergeBest(reachableStates,rStatesCon);
    end



end


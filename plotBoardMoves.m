function [] = plotBoardMoves( moveArray, board )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    figure;
    
    subplot(1,2,1);
    plotBoard(board);
    hold on;
    
    subplot(1,2,2);
    plotBoard(board);
    hold on;

    for i=1:size(moveArray,1)

        % Extract the move observed:
        %   (1): The x-coordinate of the reached state
        %   (2): The y-coordinate of the reached state
        %   (3): Least moves required to reach the state
        %   (4): Agent reaching the state more efficiently
        move = moveArray(i,:);

        % Print the movements of first agent 
        % as red and the second as green
        if move(4) == 0
           pointType = 'r';
        else
           pointType = 'g';
        end

        % plot the point as a circle if it is
        % the original place of the agent
        if move(3) == 0
            pointType = strcat(pointType, 'o');
        else
            pointType = strcat(pointType, '*');
        end

        % Plot the reached states on to the board
        % as well as the number of moves 
        % required to reach the state
        subplot(1,2,1)
        plot(move(1), move(2), pointType);
        subplot(1,2,2)
        text(move(1), move(2), int2str(move(3)));
    end


end


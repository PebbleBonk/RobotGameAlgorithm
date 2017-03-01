function board = createBoard( boardSize, walls )
%CREATEBOARD creates board size of squared(boardSize) and walls
%   Board has four states:
%     1 = Transition state (passable)
%    -1 = Transition state (unpassable)
%     0 = Reachable state (empty) 
%     R = Reachable state (with end state), R as positive, unique integer < 1

    % Note that: available states always: x,y % 2 = 0

    % Plank board:
    board = zeros(boardSize*2+1);

    % Board edges:
    board(1,:) = -1;
    board(boardSize*2+1,:) = -1;
    board(:,1) = -1;
    board(:,boardSize*2+1) = -1;

    % Additional walls:
    for i = 1:size(walls,1)
        board(walls(i,1), walls(i,2)) = -1;
    end
end

function newBoard = placeRobot( place, board )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    dirs = [[0,1];[1,0];[-1,0];[0,-1]];

    for i = 1:4
       board(place(1)+dirs(i,1), place(2)+dirs(i,2)) = -1; 
    end

    newBoard = board;
end


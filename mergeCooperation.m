function bestMoves = mergeCooperation( origMoves, coopMoves, coopLevel )
%MERGECOOPERATIONS Merges the cooperation moves, returning the best one
%
%   Input variables:
%   origMoves: a 4xn matrix containing reachable states of first agent
%   and the move count to reach the said states, 
%
%   coopMoves: a nx4 matrix containing reachable states of seconf agent
%   move count to said states and the state where agent1 was when 
%   state was reached.
%   
%   Return values:
%   Returns a nx4 matrix, containing the best moves for all the
%   states both robots could reach with cooperation where:
%       [1]: x-coordinate of the reachable state
%       [2]: y-coordinate of the reachable state
%       [3]: The amount of moves needed to reach the state
%       [4]: Which agent reaches the state more efficiently


    % Init the return value with -1.
    % Thus the default is -1, 
    bestOrigMoves = origMoves;

    bestCoopMoves = ones(size(coopMoves))*-1;
    
    for i = 1:size(coopMoves,1)
        origIndex = coopMoves(i,4);
        
        if origIndex > 0
            origMoveCount = origMoves(origIndex,3);
            totalMoveCount = coopMoves(i,3)+origMoveCount;
        else
            totalMoveCount = coopMoves(i,3);
        end
        
        bestCoopMoves(i,:) = [coopMoves(i,1:2), totalMoveCount,coopLevel];

    end

    bestMoves = mergeBest(bestOrigMoves, bestCoopMoves);
    
end


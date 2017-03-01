function state = moveAgent( state, board, dir )
%MOVEAGENT moves the agent to given direction, returns the state agent ends
%up
%   Detailed explanation goes here

    % next transition state:
    nts = state+dir;
    notBlocked = 1;

    while board(nts(1), nts(2)) >= 0 && notBlocked
        state = state+dir*2;
        
        % check that the state isn't occupied:
        notBlocked = board(state(1), state(2)) < 100;
        
        nts = state+dir;
    end

end


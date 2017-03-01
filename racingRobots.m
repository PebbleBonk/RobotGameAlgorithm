%% Create board:

walls = [[6,7];[7,6];[4,3]];
board = createBoard(4, walls);
%% Plotting the board:
plotBoard(board)

%% Creating a real life playing board:
trueWallsHor =[[5,2];[21,2];
               [9,4];[29,4];
               [5,6];[23,6];
               [15,8];
               [7,14];[29,14];
               [15,16];[19,16];[23,16];
               [13,18];[15,18];[19,18];
               [5,20];[29,20];
               [9,22];[23,22];
               [21,26];
               [13,28];
               [7,30];[29,30];
               [15,32];[23,32]];
           
trueWallsVer =[[2,13];[4,5];[8,15];[10,3];[12,17];[14,9];[16,15];
               [2,25];[4,21];[8,29];[10,23];[12,27];[16,19];
               [18,15];[22,15];[24,7];[28,15];[30,3];[32,9];
               [18,19];[20,25];[24,23];[28,31];[30,19];[32,23]];
           
trueWalls = [trueWallsHor;trueWallsVer];
trueBoard = createBoard(16, trueWalls);
%% Plotting the board:
plotBoard(trueBoard)


%% Recursive episode end find test

agent = [4,6,0];
endStates = findReachableStates(agent, board, agent,0);

%% NEW Recursive episode end find test 2

agent = Agent('a',4,6,1);

visStates = State(4,6,'','a');
endStates2 = findReachableStates2(agent, board, visStates ,'');
esl = zeros(size(endStates2));
for es =1:size(endStates2,1)
    esl(es) = endStates2(es).pathLength;
end


%% NEW HOLY FUCK IF THIS WORKS!!!
a1 = Agent('r', 4,6,1);
a2 = Agent('b', 2,8,1);
a3 = Agent('y', 4,4,1);
agnts = [a1; a2; a3];

goal = State(6,6,'','');
bestPathToEnd = findBestPath( agnts, board, a2, goal,'',0 );


%% Plot the endstates
plotBoard(board)

plot(endStates(:,1), endStates(:,2), 'g*')
plot(agent(1), agent(2),'ro')


%% Co-operation Step 1: Init, first bot moves

r1s = [4,6,0]; % State of the first robot
r2s = [2,8,0]; % State of the second robot

% Place the other robot:
tBoard = placeRobot([r2s(1), r2s(2)], board);

r1_endStates = findReachableStates(r1s, tBoard, r1s, 0);

% convert to general form:
r1_endStates = [r1_endStates, zeros(size(r1_endStates, 1),1)];

% plot the board:
plotBoardMoves([r1_endStates, zeros(size(r1_endStates,1))],board)


%% Cooperation Step 2: Other bot moves
tic
r2_endStates = cooperate(r2s, r1_endStates, board );
toc

%% Cooperation merge test

r1r2_bestEndStates = mergeCooperation(r1_endStates, r2_endStates,1);
plotBoardMoves(r1r2_bestEndStates,board);







%% Agent move test
moves = [[0,1];[1,0];[-1,0];[0,-1]];

agent = [4,6];

curState = agent;
visitedStates = curState;
moved = 1;

while moved %~inArray(curState, visitedStates)
    moved = 0;
    for d = 1:4
        nxtState = moveAgent(curState, board, moves(d,:));

        if ~prod(nxtState == curState) && ~(inArray(nxtState, visitedStates))
            curState = nxtState;
            visitedStates = [visitedStates; curState];
            moved = 1;
        end
        
    end
        
end

plot(visitedStates(:,1), visitedStates(:,2), 'co')
plot(agent(1), agent(2),'ro')
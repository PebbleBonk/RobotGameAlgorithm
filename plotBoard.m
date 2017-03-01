function [] = plotBoard( board )
%PLOTBOARD plots the given board as vector 
%   Detailed explanation goes here

    %figure;

    % edges:
    plot([1,1], [1,size(board,1)], 'b');
    hold on;
    plot([1,1], [size(board,1),1], 'b');
    plot([1,size(board,1)], size(board), 'b');
    plot([size(board,1),1], size(board), 'b');

    % Grid for easier observation:
    for x = 1:size(board,1)
        if mod(x,2) == 1
            plot([x,x], [1,size(board,1)], 'b--')
        end
    end
    
    for y = 1:size(board,1)
        if mod(y,2) == 1 
            plot([1,size(board,1)],[y,y], 'b--')
    
        end
    end
    
    
    % additional walls:
    for x = 2:size(board,1)-1
        for y = 2:size(board,1)-1
            
            
            if (mod(x,2) == 0 || mod(y,2) == 0) && board(x,y) == -1
                %[[x+mod(y,2), y+mod(x,2)];[x-mod(y,2), y-mod(x,2)]]
                plot([x+mod(y,2), x-mod(y,2)], ...
                     [y+mod(x,2), y-mod(x,2)], 'k', 'LineWidth',2)
            end
            
            if board(x,y) == 10
                plot(x,y,'or')
            end
        end
    end

      axis ij
      axis equal
      axis([1 size(board,1) 1 size(board,1)])
end


function mergedArray = mergeBest( array1, array2 )
%MERGEBEST Selects the best row based on values in 3rd column!
%   Detailed explanation goes here

    % Tiny optimisation by sorting:
    %array1 = sort(array1,1);

    mergedArray = [array1;array2];
    mergedArray =  sortrows(mergedArray,[1,2,3]);

    i = 1;
    while i > 0
        if mergedArray(i,1:2) == mergedArray(i+1,1:2)
            %same = [mergedArray(i,1:2), mergedArray(i+1,1:2)]
            %mergedArray(i,3) = min(mergedArray(i,3),mergedArray(i+1,3));
            %mergedArray(i,3:end) = mergedArray(i+1,3:end);
            mergedArray(i+1,:) = [];
        else
            i=i+1;
        end

        if i == size(mergedArray,1)
            i = -1; % Break
        end
    end
    t=3;
end


function valueFound = inArray( value, array )
%INARRAY Returns index of found value or 0 if not found
%   Detailed explanation goes here
    valueFound = 0;
    for i = 1:size(array, 1)
        if array(i,:) == value
            valueFound = i;
        end
    end
end


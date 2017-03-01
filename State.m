classdef State
    %UNTITLED12 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        X
        Y
        PathToReach
        AgentID
    end
    
    methods
        % Construct
        function obj = State(x, y, path, agentID)
            if nargin > 0
                obj.X = x;
                obj.Y = y;
                obj.PathToReach = path;
                obj.AgentID = agentID;
            end
        end
        
        % == operator override
        function tf = eq(obj1,obj2)
            if obj1.X == obj2.X && obj1.Y == obj2.Y
                tf = true;
            else
                tf = false;
            end
        end
        
        % get the path length in moves.
        % i.e. length(PathToreach)/2
        function r = pathLength(obj)
            r = round(length(obj.PathToReach)/2);
        end
        
        % Get coordinates as [x,y]
        function r = getCoords(obj)
            r = [obj.X, obj.Y];
        end
    end
    
end


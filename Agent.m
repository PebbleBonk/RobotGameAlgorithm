classdef Agent
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Id
        X
        Y
        Mobile
    end
    
	methods
        % Construct
        function obj = Agent(id, x, y, mobile)
            if nargin > 0
                obj.Id = id;
                obj.X = x;
                obj.Y = y;
                obj.Mobile = mobile;
            end
        end
        
        % Moving
        function r = Move(obj, x, y)
                obj.X = x;
                obj.Y = y;
                r = obj;
        end
        
        % Get the current state
        function r = getState(obj)
            r = [obj.X,obj.Y];
        end
        
        % Immobilize
        function r = immobilize(obj)
            obj.Mobile = 0;
            r = obj;
        end
        
        % Mobilize
        function r = mobilize(obj)
            obj.Mobile = 1;
            r = obj;
        end
        
        
         % == operator override
        function tf = eq(obj1,obj2)
            if obj1.Id == obj2.Id
                tf = true;
            else
                tf = false;
            end
        end
    end
    
    
end


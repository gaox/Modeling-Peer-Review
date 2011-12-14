% ThurnerScientist Class
%
% Description
% ThurnerScientist is the scientists described in Thurner's paper. They are
% either rational reviewers, correct reviewers or random reviewers.
%
% ThurnerScientist Properties:
% CORRECT_REFEREE   - Identify the correct referee.
% RANDOM_REFEREE    - Identify the random referee.
% RATIONAL_REFEREE  - Identify the rational referee.
% type              - One of the value listed above.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

%------------- BEGIN CODE --------------

classdef ThurnerScientist < Scientist

    properties (Constant)
        CORRECT_REFEREE = 1;
        RANDOM_REFEREE = 2;
        RATIONAL_REFEREE = 3;
    end
    
    properties
        type;
    end
    
    methods
        function obj = ThurnerScientist(id, intelligence, type)
        % Constructor: Construct the ThurnerScientist object, return the obj
        %              handle.
        %
        % Input:
        %   id              - the unique id of the scientist.
        %   intelligence    - the initial intelligence of the scientist.
        %   type            - the type of the referee, correct, random or
        %                     rational.
        % Output:
        %   obj             - the handle of the created ThurnerScientist object.
            if nargin > 0
                obj.id = id;
                obj.intelligence = intelligence;
                obj.type = type;
            end
        end
    end
    
end

%------------- END OF CODE --------------

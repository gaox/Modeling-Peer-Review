% Scientist Class
%
% Description
% Scientist produce paper, submit paper and review papers.
% This class inherit from handle class in order to pass pointer instead
% of value.
%
% Scientist Properties:
% id            - The unique value to identify the scientist.
% intelligence  - Namely, the IQ of a scientist, this will influcen the 
%                 paper quality produced by the scientist.
%
% Scientist Methods:
% produce_paper - The scientist finish writing a paper.
% submit_paper  - Submit the paper to a journal.

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
            if nargin > 0
                obj.id = id;
                obj.intelligence = intelligence;
                obj.type = type;
            end
        end
    end
    
end

%------------- END OF CODE --------------

% Simulator Class
%
% Description
% Simulator provide the method to simulate the peer review process. The
% detailed implementation could be based on agent based model.
%
% Simulator Properties:
% None. Currently it only defines the interface needed to be implement.
%
% Simulator Methods:
% simulate       - Simulate the world, i.e. scientist produces paper, submit 
%                  paper and review paper, journal accepts paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

%------------- BEGIN CODE --------------

classdef Simulator < handle
    
    properties
    end
    
    methods (Abstract)
        simulate(world);
        % simulate: Provide the algorithm to simulate the peer review.
        %
        % Input:
        %   world           - the academic environment, including
        %                     scientists who produce paper, submit paper, 
        %                     and review paper, and journals.
    end
    
end

%------------- END OF CODE --------------

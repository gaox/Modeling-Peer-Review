% World Class
%
% Description
% World is academic environment. Scientists live in the world, they write
% paper and submit to journals for publication.
%
% World Properties:
% scientists     - Scientists produce papers.
% journals       - Journal review papers and publish papers.
% time           - How long the simulation will last.
%
% World Methods:
% simulate_world - Simulate the peer review in the world.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

%------------- BEGIN CODE --------------

classdef World < handle

    properties
        scientists;
        journals;
        
        time;
    end
    
    methods (Abstract)
        simulate_world(obj, simulator);
    end
    
end

%------------- END OF CODE --------------

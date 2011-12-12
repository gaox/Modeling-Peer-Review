% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef Journal < handle
    
    % Journal Class
    %
    % Description
    % Journal receives paper, organize referees to review paper and decide
    % which paper to accept for publication.
    %
    % Properties of Journal
    % id          : The unique value to identify the journal.
    % impact      : The importance of the journal, can be seen as a impact
    %               factor.
    
    properties
        id;
        impact;
    end
    
    methods
        function obj = Journal(id, impact)
            if nargin > 0
                obj.id = id;
                obj.impact = impact;
            end
        end
        
        function accept = review_paper(obj, paper, reviewer)
            accept = reviewer.review(obj, paper);
        end
    end
    
end

%------------- END OF CODE --------------

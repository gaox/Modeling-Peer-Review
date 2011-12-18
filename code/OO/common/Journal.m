% Journal Class
%
% Description
% Journal receives paper, organize referees to review paper and decide
% which paper to accept for publication.
%
% Journal Properties:
% id          - The unique value to identify the journal.
%
% Journal Methods:
% review_paper - Arrange reviewers to review paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef Journal < handle
    
    properties
        id;
    end
    
    methods
        function obj = Journal(id)
        % Constructor: Construct the Journal object, return the obj handle.
        %
        % Input:
        %   id              - id identifies the journal uniquely.
        %   impact          - impact of the journal, put here for further use.
        % Output:
        %   obj             - the handle of the created Journal object.
            if nargin > 0
                obj.id = id;
            end
        end
        
        function accept = review_paper(obj, paper, reviewer)
        % review_paper: Arrange reviewers to review paper.
        %
        % Input:
        %   paper           - the paper to be reviewed.
        %   reviewer        - reviewer provide the algorithm to review the
        %                     paper.
        % Output:
        %   accept          - 1 if the paper is accepted, 0 if rejected.
            accept = reviewer.review(obj, paper);
        end
    end
    
end

%------------- END OF CODE --------------

% Reviewer Class
%
% Description
% Reviewer provide the method to choose reviewer for the journal to
% review papers and make the decision to accept or reject papers.
%
% Reviewer Properties:
% None. This class only provides a method to choose reviewers and make
% accept or reject decisions, so it only provides an interface called
% review.
%
% Reviewer Methods:
% review - Choose reviewer for the journal and review papers.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef Reviewer < handle
    
    properties
    end
    
    methods (Abstract)
        accept = review(obj, journal, paper)
        % review: An abstract method. Any algorithm to submit a paper
        %         must implement the certain algorithm.
        %
        % Input:
        %   journal         - the Reviewer choose referees for the journal
        %   paper           - the handle of the reviewed paper.
        % Output:
        %   accept          - 1 if the paper is accepted, 0 if rejected.
    end
    
end

%------------- END OF CODE --------------

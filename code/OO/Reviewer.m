% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef Reviewer < handle
    
    % Reviewer Class
    %
    % Description
    % Reviewer provide the method to choose reviewer for the journal to
    % review papers and make the decision to accept or reject papers.
    %
    % Properties of Reviewer
    % None. This class only provides a method to choose reviewers and make
    % accept or reject decisions, so it only provides an interface called
    % review.
    %
    % Methods of Reviewer
    % review: Choose reviewer for the journal and review papers.
    
    properties
    end
    
    methods (Abstract)
        % review: An abstract method. Any algorithm to submit a paper
        %         must implement the certain algorithm.
        %
        % Input:
        %   journal         - the Reviewer choose referees for the journal
        %   paper           - the handle of the reviewed paper.
        % Output:
        %   accept          - 1 if the paper is accepted, 0 if rejected.
        accept = review(obj, journal, paper)
    end
    
end

%------------- END OF CODE --------------

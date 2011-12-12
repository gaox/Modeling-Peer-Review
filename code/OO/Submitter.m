% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef Submitter < handle
    
    % Submitter Class
    %
    % Description
    % Submitter provide the method to submit papers. The design of this 
    % class is based on the visitor pattern.
    % This class inherit from handle class in order to pass pointer instead
    % of value.
    %
    % Properties of Submitter
    % None. This class only provides a method to sutmit paper for the
    % scientist, so it only provides an interface called submit.
    %
    % Methods of Submitter
    % submit: Produce the a paper for the scientist.
    
    properties
    end
    
    methods (Abstract)
        % sutmit: An abstract method. Any algorithm to submit a paper
        %         must implement the certain algorithm.
        %
        % Input:
        %   paper           - the handle of a paper.
        % Output:
        %   journal         - the journal the paper submitted to.
        journal = submit(obj, paper)
    end
    
end

%------------- END OF CODE --------------

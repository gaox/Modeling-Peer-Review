% Submitter Class
%
% Description
% Submitter provide the method to submit papers. The design of this 
% class is based on the visitor pattern.
% This class inherit from handle class in order to pass pointer instead
% of value.
%
% Submitter Properties:
% None. This class only provides a method to sutmit paper for the
% scientist, so it only provides an interface called submit.
%
% Submitter Methods:
% submit - Produce the a paper for the scientist.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef Submitter < handle
    
    properties
    end
    
    methods (Abstract)
        journal = submit(obj, paper)
        % sutmit: An abstract method. Any algorithm to submit a paper
        %         must implement the certain algorithm.
        %
        % Input:
        %   paper           - the handle of a paper.
        % Output:
        %   journal         - the journal the paper submitted to.
    end
    
end

%------------- END OF CODE --------------

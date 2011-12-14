% Producer Class
%
% Description
% Producer provide the method to produce papers. The design of this 
% class is based on the visitor pattern.
% This class inherit from handle class in order to pass pointer instead
% of value.
%
% Producer Properties:
% None. This class only provides a method to generate paper for the
% scientist, so it only provides an interface called produce.
%
% Producer Methods:
% produce - Produce the a paper for the scientist.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef Producer < handle
    properties
    end
    
    methods (Abstract)
        paper = produce(obj, scientist)
        % produce: An abstract method. Any algorithm to produce a paper
        %          must implement the certain algorithm.
        %
        % Input:
        %   scientist       - the handle of a scientist.
        % Output:
        %   paper           - the paper produced for the scientist.
    end
    
end

%------------- END OF CODE --------------

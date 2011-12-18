% GaussianProducer Class
%
% Description
% GaussianProducer provide the method to produce papers. The design of  
% this class is based on the visitor pattern.
% This class inherit from the abstract class Producer.
%
% GaussianProducer Properties:
% stddev    - The standard deviation of the gaussian distribution.
%
% GaussianProducer Methods:
% produce   - Produce the a paper for the scientist, the quality obeys 
%             gaussian distribution.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef GaussianProducer < Producer

    properties
        stddev;
    end
    
    methods
        function obj = GaussianProducer(stddev)
        % Constructor: Construct the Scientist object, return the obj
        %              handle.
        %
        % Input:
        %   intelligence    - the initial intelligence of the scientist.
        % Output:
        %   obj             - the handle of the created scientist object.
            if nargin > 0
                obj.stddev = stddev;
            end
        end
        
        function paper = produce(obj, scientist)
        % produce: Produce the paper, the quality of the paper is in
        % gaussian distribution, the mean value is the intelligence of the 
        % scientist, with a small standard deviation. The paper
        % also receives an author_id equal to the id of the scientist.
        %
        % Input:
        %   scientist       - the handle of a scientist.
        % Output:
        %   paper           - the paper produced for the scientist.
            quality = ceil(normrnd(scientist.intelligence, obj.stddev));
            paper = ThurnerPaper(scientist.id, quality);
        end
    end
    
end

%------------- END OF CODE --------------

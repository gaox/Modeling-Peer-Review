% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef GaussianProducer < Producer
    
    % GaussianProducer Class
    %
    % Description
    % GaussianProducer provide the method to produce papers. The design of  
    % this class is based on the visitor pattern.
    % This class inherit from the abstract class Producer.
    %
    % Properties of GaussianProducer
    % stddev    : The standard deviation of the gaussian distribution.
    %
    % Methods of GaussianProducer
    % produce   : Produce the a paper for the scientist, the quality obeys 
    %             gaussian distribution.
    
    properties
        stddev;
    end
    
    methods
        % Constructor: Construct the Scientist object, return the obj
        %              handle.
        % Input:
        %   intelligence    - the initial intelligence of the scientist.
        % Output:
        %   obj             - the handle of the created scientist object.
        function obj = GaussianProducer(stddev)
            if nargin > 0
                obj.stddev = stddev;
            end
        end
        
        % produce: Produce the paper, the quality of the paper is in
        % gaussian distribution, the mean value is the intelligence of the 
        % scientist, with a small standard deviation. The paper
        % also receives an author_id equal to the id of the scientist.
        %
        % Input:
        %   scientist       - the handle of a scientist.
        % Output:
        %   paper           - the paper produced for the scientist.
        function paper = produce(obj, scientist)
            quality = ceil(normrnd(scientist.intelligence, obj.stddev));
            paper = Paper(scientist.id, quality);
        end
    end
    
end

%------------- END OF CODE --------------

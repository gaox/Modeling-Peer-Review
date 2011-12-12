% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef Paper < handle
    
    % Paper Class
    %
    % Description
    % Paper represents the production of the scientist's research. The
    % scientist will submit the paper object to journal for reviewing the
    % publication.
    %
    % Properties of Paper
    % author_id : The standard deviation of the gaussian distribution.
    % quality   : An integer value to represent the quality of the paper
    % id        : A unique id to identify the paper.
    %
    
    properties
        author_id;
        quality;
        id;
    end
    
    methods
        % Constructor: Construct the Paper object, return the obj handle.
        %
        % Input:
        %   author_id       - author_id identifies the author of the paper.
        % Output:
        %   obj             - the handle of the created Paper object.
        function obj = Paper(author_id, quality)
            if nargin > 0
                obj.author_id = author_id;
                obj.quality = quality;
            end
        end
    end
    
end

%------------- END OF CODE --------------

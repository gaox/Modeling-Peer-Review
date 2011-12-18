% Paper Class
%
% Description
% Paper represents the production of the scientist's research. The
% scientist will submit the paper object to journal for reviewing the
% publication.
%
% Paper Properties:
% author_id - The identification of the author.
% id        - A unique id to identify the paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef Paper < handle
    
    properties
        author_id;
        id;
    end
    
    methods
        function obj = Paper(author_id)
        % Constructor: Construct the Paper object, return the obj handle.
        %
        % Input:
        %   author_id       - author_id identifies the author of the paper.
        % Output:
        %   obj             - the handle of the created Paper object.
            if nargin > 0
                obj.author_id = author_id;
            end
        end
    end
    
end

%------------- END OF CODE --------------

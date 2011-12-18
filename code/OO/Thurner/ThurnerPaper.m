% ThurnerPaper Class
%
% Description
% ThurnerPaper represents the production of the scientist's research. The
% scientist will submit the paper object to journal for reviewing the
% publication. The paper has a quality attribute defined in Thurner's
% paper.
%
% ThurnerPaper Properties:
% quality    - The quality of the paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 17-Dec-2011

%------------- BEGIN CODE --------------

classdef ThurnerPaper < Paper
    
    properties
        quality;
    end
    
    methods
        function obj = ThurnerPaper(author_id, quality)
        % Constructor: Construct the ThurnerPaper object, return the obj handle.
        %
        % Input:
        %   author_id       - author_id identifies the author of the paper.
        %   quality         - the quality of the paper.
        % Output:
        %   obj             - the handle of the created ThurnerPaper object.
            if nargin > 0
                obj.author_id = author_id;
                obj.quality = quality;
            end
        end
    end
    
end

%------------- END OF CODE --------------

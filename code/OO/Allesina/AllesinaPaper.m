% AllesinaPaper Class
%
% Description
% AllesinaPaper has three attributes based on the three Beta distribution
% of the scientist.
%
% AllesinaPaper Properties:
% topic          - The topic value of the paper.
% quality        - The quality value of the paper.
% novelty        - The novelty value of the paper.
% num_revision   - Times the paper has been revised.
%
% AllesinaPaper Methods:
% revise         - Improve the quality and novelty of the paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef AllesinaPaper < Paper
    
    properties
        topic;
        quality;
        novelty;
        
        num_revision;
    end
    
    methods
        function obj = AllesinaPaper(author_id, topic, quality, novelty)
            obj.author_id = author_id;
            obj.topic = topic;
            obj.quality = quality;
            obj.novelty = novelty;
            obj.num_revision = 0;
        end
        
        function revise(obj)
            obj.quality = h(obj.quality, 0.1, obj.num_revision);
            obj.novelty = h(obj.novelty, 0.1, obj.num_revision);
            obj.num_revision = obj.num_revision + 1;
        end
    end
    
    methods (Static)
        function value = h(a, b, c)
            value = a + b / c * (1 - a) * rand(1);
        end
    end
end

%------------- END OF CODE --------------

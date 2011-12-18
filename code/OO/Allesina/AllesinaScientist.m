% AllesinaScientist Class
%
% Description
% AllesinaScientist produce paper, submit paper and review papers.
% This class inherit from handle class in order to pass pointer instead
% of value. The AllesinaScientist has three beta distribution attributes.
%
% AllesinaScientist Properties:
% topic_a       - Parameter for Beta distribution.
% topic_b       - Parameter for Beta distribution.
% quality_a     - Parameter for Beta distribution.
% quality_b     - Parameter for Beta distribution.
% novelty_a     - Parameter for Beta distribution.
% novelty_b     - Parameter for Beta distribution.
%
% AllesinaScientist Methods:
% produce_paper - The scientist finish writing a paper.
% submit_paper  - Submit the paper to a journal.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef AllesinaScientist < Scientist
    
    properties
        topic_a;
        topic_b;
        quality_a;
        quality_b;
        novelty_a;
        novelty_b;
    end
    
    methods
        function obj = AllesinaScientist(id, ...
                                         topic_a, topic_b, ...
                                         quality_a, quality_b, ...
                                         novelty_a, novelty_b)
            if nargin > 0
                obj.id = id;
                obj.topic_a = topic_a;
                obj.topic_b = topic_b;
                obj.quality_a = quality_a;
                obj.quality_b = quality_b;
                obj.novelty_a = novelty_a;
                obj.novelty_b = novelty_b;
            end
        end
    end
    
end

%------------- END OF CODE --------------

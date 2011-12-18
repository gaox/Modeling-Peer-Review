% AllesinaJournal Class
%
% Description
% The AllesinaScientist has three beta distribution attributes.
%
% AllesinaJournal Properties:
% topic_a       - Parameter for Beta distribution.
% topic_b       - Parameter for Beta distribution.
% quality_a     - Parameter for Beta distribution.
% quality_b     - Parameter for Beta distribution.
% novelty_a     - Parameter for Beta distribution.
% novelty_b     - Parameter for Beta distribution.
% impact        - The impact of the journal.
%
% AllesinaJournal Methods:
% set_impact    - Calculate the impact for the journal.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef AllesinaJournal < Journal
    
    properties
        topic_a;
        topic_b;
        quality_a;
        quality_b;
        novelty_a;
        novelty_b;
        
        impact;
    end
    
    methods
        function obj = AllesinaJournal(id, ...
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
                obj.set_impact();
            end
        end
        
        function set_impact(obj)
            v_q = (obj.quality_a) / (obj.quality_a + obj.quality_b);
            v_n = (obj.novelty_a) / (obj.novelty_a + obj.novelty_b);
            v_t = (obj.topic_a) / (obj.topic_a + obj.topic_b);
            obj.impact = v_q * v_n * 1 / AllesinaZeta(obj.topic_a, obj.topic_b, v_t);
        end
    end
    
end

%------------- END OF CODE --------------

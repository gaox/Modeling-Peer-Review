% AllesinaProducer Class
%
% Description
% AllesinaProducer provide the method to produce papers. The design of  
% this class is based on the visitor pattern.
% This class inherit from the abstract class Producer.
%
% AllesinaProducer Methods:
% produce   - Produce the a paper for the scientist.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef AllesinaProducer < Producer
    
    properties
    end
    
    methods (Static)
        function paper = produce(scientist)
            topic = betarnd(scientist.topic_a, scientist.topic_b);
            quality = betarnd(scientist.quality_a, scientist.quality_b);
            novelty = betarnd(scientist.novelty_a, scientist.novelty_b);
            paper = AllesinaPaper(scientist.id, topic, quality, novelty);
        end
    end
    
end

%------------- END OF CODE --------------

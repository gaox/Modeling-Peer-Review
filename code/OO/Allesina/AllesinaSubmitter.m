% AllesinaSubmitter Class
%
% Description
% AllesinaSubmitter. Submit paper by ranking acceptance probability.
%
% AllesinaSubmitter Properties:
% journal_pool   - Available journals for publication.
% num_journal    - Number of journals in the world.
%
% AllesinaSubmitter Methods:
% submit         - Submit a paper to the journal with a high probability of
%                  acceptance.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef AllesinaSubmitter < Submitter
    
    properties
        journal_pool;
        num_journal;
    end
    
    methods
        function obj = AllesinaSubmitter(journal_pool)
            obj.journal_pool = journal_pool;
            obj.num_journal = length(journal_pool);
        end
        
        function journal = submit(obj, paper)
            pros = zeros(1, obj.num_journal);
            for i = 1:obj.num_journal
                pros(i) = AllesinaACPro(obj.journal_pool(i), paper);
            end
            [~, index] = sort(pros, 'descend');
            choice = randi(20, 1);
            journal = obj.journal_pool(index(choice));
        end
    end
    
end

%------------- END OF CODE --------------

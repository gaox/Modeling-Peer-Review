% RandomReviewer Class
%
% Description
% RandomReviewer provide the method to choose reviewer for the journal to
% review papers and make the decision to accept or reject papers. The
% algorithm is used in Thurner's model.
%
% RandomReviewer Properties:
% num_reviewer_pool   - The total number of reviewers. All the scientists
%                       in the world can review paper.
% num_reviewer_chosen - The number of reviewers needed to review one
%                       paper.
% reviewers           - Reference to all available reviewers.
% min_threshold       - Minimum quality can be accepted by rational
%                       reviewers.
%
% RandomReviewer Methods:
% review              - Randomly choose (I must be kidding you) reviewer 
%                       for the journal and review papers.
% choose_reviewer     - Choose the reviewers randomly.
% 
% See also:
% http://arxiv.org/abs/1008.4324

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

%------------- BEGIN CODE --------------

classdef RandomReviewer < Reviewer
    
    properties
        num_reviewer_pool;
        num_reviewer_chosen;
        reviewers;
        
        min_quality;
        min_threshold = 90;
    end
    
    methods
        function obj = RandomReviewer(num_reviewer_pool, ...
                                      num_reviewer_chosen, ...
                                      reviewers)
        % Constructor: Construct the RandomReviewer object, return the obj
        %              handle.
        %
        % Input:
        %   num_reviewer_pool      - the total number of reviewers.
        %   num_reviewer_chosen    - the number of reviewers needed to 
        %                            review one paper.
        %   reviewers              - reference to all available reviewers.
        %
        % Output:
        %   obj                    - the handle of the created reviewer object.
            if nargin > 0
                obj.num_reviewer_pool = num_reviewer_pool;
                obj.num_reviewer_chosen = num_reviewer_chosen;
                obj.reviewers = reviewers;
            end
        end
        
        function accept = review(obj, ~, paper)
        % review: Randomly choose reviewers to review the paper. If the
        %         reviewer's decision ties, accept it randomly.
        %
        % Input:
        %   journal         - the Reviewer choose referees for the journal
        %   paper           - the handle of the reviewed paper.
        % Output:
        %   accept          - 1 if the paper is accepted, 0 if rejected.
            reviewers_chosen = obj.choose_reviewer(paper);
            decision = 0;
            for i = 1:obj.num_reviewer_chosen
                index = reviewers_chosen(i);
                if obj.reviewers(index).type == ThurnerScientist.RATIONAL_REFEREE
                    if paper.quality <= obj.reviewers(index).intelligence && ...
                            paper.quality >= obj.min_threshold
                        decision = decision + 1;
                    end
                elseif obj.reviewers(index).type == ThurnerScientist.CORRECT_REFEREE
                    if (paper.quality >= obj.min_quality)
                        decision = decision + 1;
                    end
                else
                    decision = decision + randi(2, 1) - 1;
                end
            end
            if decision > obj.num_reviewer_chosen / 2
                accept = 1;
            elseif decision < obj.num_reviewer_chosen / 2
                accept = 0;
            else
                accept = randi(2, 1) - 1;
            end
        end
        
        function reviewers_chosen = choose_reviewer(obj, paper)
        % choose_reviewer: Randomly choose the reviewers to review the paper. 
        %                  The reviewer should not be the author himself.
        %                  The algorithm is based on Knuth shuffle.
        %
        % Input:
        %   paper            - the handle of the reviewed paper.
        % Output:
        %   reviewers_chosen - the chosen reviewers.
            reviewers_pool = 1:obj.num_reviewer_pool;
            pool_size = obj.num_reviewer_pool;
            reviewers_chosen = zeros(1, obj.num_reviewer_chosen);
            for i = 1:obj.num_reviewer_chosen
                index = randi(pool_size, 1);
                if reviewers_pool(index) == paper.author_id;
                    reviewers_pool(index) = reviewers_pool(pool_size);
                    pool_size = pool_size - 1;
                    index = randi(pool_size, 1);
                end
                reviewers_chosen(i) = reviewers_pool(index);
                reviewers_pool(index) = reviewers_pool(pool_size);
                pool_size = pool_size - 1;
            end
        end
    end
    
end

%------------- END OF CODE --------------

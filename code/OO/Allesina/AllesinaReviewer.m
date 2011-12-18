% AllesinaReviewer Class
%
% Description
% AllesinaReviewer provide the method to choose reviewer for the journal to
% review papers and make the decision to accept or reject papers. The
% algorithm is used in Thurner's model.
%
% AllesinaReviewer Properties:
% num_reviewer_pool   - The total number of reviewers. All the scientists
%                       in the world can review paper.
% num_reviewer_chosen - The number of reviewers needed to review one
%                       paper.
% reviewers           - Reference to all available reviewers.
%
% AllesinaReviewer Methods:
% review              - Reviewr review the paper.
% choose_reviewer     - Choose the reviewers by rank.
% decide              - Editor decide if accept the paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef AllesinaReviewer < Reviewer
    
    properties
        num_reviewer_pool;
        num_reviewer_chosen;
        reviewers;
    end
    
    methods
        function obj = AllesinaReviewer(num_reviewer_pool, ...
                                        num_reviewer_chosen, ...
                                        reviewers)
        % Constructor: Construct the AllesinaReviewer object, return the obj
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
        
        function reviewers_chosen = choose_reviewer(obj, paper)
            score = zeros(1, obj.num_reviewer_pool);
            for i = 1:obj.num_reviewer_pool
                score(i) = 1 / AllesinaZeta(obj.reviewers.topic_a, ...
                                            obj.reviewers.topic_b, paper.topic);
            end
            [~, ind] = sort(score, 'descend');
            
            reviewers_pool = ind(1, 20);
            pool_size = 20;
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
    
    methods (Static)
        function score = review(paper, scientist)
            v_t = AllesinaZeta(scientist.topic_a, scientist.topic_b, paper.topic);
            v_q = AllesinaZeta(scientist.quality_a, scientist.quality_b, paper.quality);
            v_n = AllesinaZeta(scientist.novelty_a, scientist.novelty_b, paper.novelty);
            score = [v_t, v_q, v_n];
        end
        
        function accept = decide(journal, scores, paper)
            score = mean(scores);
            tp = AllesinaPaper(paper.author_id, score(1), score(2), score(3));
            pro = AllesinaACPro(journal, tp);
            if rand(1) <= pro
                accept = 1;
            else
                accept = 0;
            end
        end
    end
end

%------------- END OF CODE --------------

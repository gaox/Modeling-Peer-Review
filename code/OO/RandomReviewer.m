% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef RandomReviewer < Reviewer
    
    % RandomReviewer Class
    %
    % Description
    % Reviewer provide the method to choose reviewer for the journal to
    % review papers and make the decision to accept or reject papers.
    %
    % Properties of RandomReviewer
    % num_reviewer_pool   : the total number of reviewers. All the scientists
    %                       in the world can review paper.
    % num_reviewer_chosen : the number of reviewers needed to review one
    %                       paper.
    % reviewers           : reference to all available reviewers.
    %
    % Methods of RandomReviewer
    % review              : Randomly choose (I must be kidding you) reviewer 
    %                       for the journal and review papers.
    
    properties
        num_reviewer_pool;
        num_reviewer_chosen;
        reviewers;
    end
    
    methods
        % Constructor: Construct the RandomReviewer object, return the obj
        %              handle.
        % Input:
        %   num_reviewer_pool      - the total number of reviewers.
        %   num_reviewer_chosen    - the number of reviewers needed to 
        %                            review one paper.
        %   reviewers              - reference to all available reviewers.
        %
        % Output:
        %   obj                    - the handle of the created reviewer object.
        function obj = RandomReviewer(num_reviewer_pool, ...
                                      num_reviewer_chosen, ...
                                      reviewers)
            if nargin > 0
                obj.num_reviewer_pool = num_reviewer_pool;
                obj.num_reviewer_chosen = num_reviewer_chosen;
                obj.reviewers = reviewers;
            end
        end
        
        % review: Randomly choose reviewers to review the paper. If the
        %         reviewer's decision ties, accept it randomly.
        %
        % Input:
        %   journal         - the Reviewer choose referees for the journal
        %   paper           - the handle of the reviewed paper.
        % Output:
        %   accept          - 1 if the paper is accepted, 0 if rejected.
        function accept = review(obj, ~, paper)
            reviewers_chosen = obj.choose_reviewer(paper);
            decision = 0;
            for i = 1:obj.num_reviewer_chosen
                index = reviewers_chosen(i);
                if paper.quality >= obj.reviewers(index).intelligence
                    decision = decision + 1;
                end
            end
            if decision > obj.num_reviewer_chosen / 2
                accept = 1;
            elseif decision < obj.num_reviewer_chosen / 2
                accept = 0;
            else
                accept = randi(2, 1) - 1;
            end
        end % end of function
        
        % choose_reviewer: Randomly choose the reviewers to review the paper. 
        %                  The reviewer should not be the author himself.
        %                  The algorithm is based on Knuth shuffle.
        % Input:
        %   paper            - the handle of the reviewed paper.
        % Output:
        %   reviewers_chosen - the chosen reviewers.
        function reviewers_chosen = choose_reviewer(obj, paper)
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
    end % end of methods
    
end

%------------- END OF CODE --------------

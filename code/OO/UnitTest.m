% This file contains all the test case used in the development.
% Scripts are organized in cell mode in order to be called on demand.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

%% Test the Producer
clear;
a_producer = GaussianProducer(10);
a_author = Scientist(1, 100);
a_paper = a_author.produce_paper(a_producer);
fprintf('paper quality %d\n', a_paper.quality);

%% Test the Submitter
clear;
% assign to the largest index to preallocate meomry for the array.
for i = 5:-1:1
    authors(i) = Scientist(1, 100);
end

% impact factor does not make sense now.
a_journal = Journal(1, 0);

a_producer = GaussianProducer(10);
a_submitter = NaiveSubmitter(a_journal);
a_reviewer = RandomReviewer(5, 2, authors);

for i = 1:5
    a_paper = authors(1).produce_paper(a_producer);
    fprintf('paper %d: quality %d\n', i, a_paper.quality);
    a_journal = authors(1).submit_paper(a_paper, a_submitter);
    fprintf('paper %d: submitted to journal %d\n', i, a_journal.id);
    accept = a_journal.review_paper(a_paper, a_reviewer);
    if accept == 1
        fprintf('paper %d accepted!\n', i);
    else
        fprintf('paper %d rejected...\n', i);
    end
end


%% ------------- END OF CODE --------------
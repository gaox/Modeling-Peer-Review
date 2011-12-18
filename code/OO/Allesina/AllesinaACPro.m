% AllesinaACPro
% Caculate the acceptance probability.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

function pro = AllesinaACPro(journal, paper)
    v_t = AllesinaZeta(journal.topic_a, journal.topic_b, paper.topic);
    v_q = quad(@(t)betapdf(t, journal.quality_a, journal.quality_b), 0, paper.quality);
    v_n = quad(@(t)betapdf(t, journal.novelty_a, journal.novelty_b), 0, paper.novelty);
    pro = v_t * v_q * v_n;
end

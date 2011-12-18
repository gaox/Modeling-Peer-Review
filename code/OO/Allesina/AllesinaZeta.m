% AllesinaACPro
% Zeta function used in Allesina's paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

function value = AllesinaZeta(alpha, beta, x)
    if x >= 0.1 && x <= 0.9
        value = quad(@(t)betapdf(t, alpha, beta), x - 0.1, x + 0.1);
    elseif x < 0.1
        value = quad(@(t)betapdf(t, alpha, beta), 0, x + 0.1) + ...
                quad(@(t)betapdf(t, alpha, beta), 0.9 + x, 1);
    else
        value = quad(@(t)betapdf(t, alpha, beta), x - 0.1, 1) + ...
                quad(@(t)betapdf(t, alpha, beta), 0, 1 - x + 0.1);
    end
end

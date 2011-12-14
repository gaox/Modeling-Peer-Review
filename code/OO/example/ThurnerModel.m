% Run the simulation of Thurner's model.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

f_random = 0;
f_rational = 0;

lambda = 0;
alpha = 0;

MAX_TIMESTEP = 500;
SCIENTIST_NUM = 1000;
JOURNAL_NUM = 1;

tic;

distcomp.feature( 'LocalUseMpiexec', false );
matlabpool open 4;

for i = f_random
    parfor j = 1:length(f_rational)
        if (i + f_rational(j) > 1)
            continue;
        end
        world = ThurnerWorld(SCIENTIST_NUM, ...
                             JOURNAL_NUM, ...
                             MAX_TIMESTEP, ...
                             f_rational(j), ...
                             i, ...
                             1 - f_rational(j) - i, ...
                             lambda, ...
                             alpha);
        simulator = ThurnerSimulator();
        world.simulate_world();
    end
end

matlabpool close;

toc;

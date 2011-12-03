f_random = 0;
f_rational = 0:0.1:0.7;
alpha = 0;

MAX_TIMESTEP = 500;
SCIENTIST_NUM = 1000;

tic;
distcomp.feature( 'LocalUseMpiexec', false );
matlabpool open 4;

for i = f_random
    parfor j = 1:length(f_rational)
        if (i + f_rational(j) > 1)
            continue;
        end
        simulate(MAX_TIMESTEP, SCIENTIST_NUM, i, f_rational(j), alpha);
    end
end

matlabpool close;
toc

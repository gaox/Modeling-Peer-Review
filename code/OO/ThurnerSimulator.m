% Simulator Class
%
% Description
% Simulator provide the method to simulate the peer review process. The
% detailed implementation could be based on agent based model.
%
% Simulator Properties:
% None. This class only provides a method to simulate the peer review model
% in the academic world, so it only provide an interface called simulate.
% 
% Simulator Methods:
% simulate - Simulate the world, i.e. scientist produces paper, submit paper
%            and review paper, journal accepts paper.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

%------------- BEGIN CODE --------------

classdef ThurnerSimulator < Simulator
    
    properties
    end
    
    methods (Static)
        function simulate(world)
            avg_quality = zeros(1, world.time);
            std_quality = 0;
            moving_avg = zeros(1, 2);
            for t = 1:world.time
                accept_quality = zeros(1, world.num_scientists);
                accept_num = 0;
                if (t > 1)
                    moving_avg(2) = moving_avg(1) * world.lambda ...
                                 + (1 - world.lambda) * mean(avg_quality(1:t-1));
                else
                    moving_avg(2) = 0;
                end
                world.reviewer.min_quality = moving_avg(2) + world.alpha * std_quality;
                for i = 1:world.num_scientists
                    paper = world.scientists(i).produce_paper(world.producer);
                    journal = world.scientists(i).submit_paper(paper, world.submitter);
                    accept = journal.review_paper(paper, world.reviewer);
                    if accept
                        accept_num = accept_num + 1;
                        accept_quality(accept_num) = paper.quality;
                    end
                end
                if accept_num > 0
                    accept_quality = accept_quality(1, accept_num);
                    avg_quality(t) = mean(accept_quality);
                    std_quality = std(accept_quality);
                else
                    avg_quality(t) = 0;
                    std_quality = 0;
                end
                fprintf('year %d\n', t);
            end
            save('avg_quality', 'avg_quality');
            plot(1:500, avg_quality);
        end
    end
    
end

%------------- END OF CODE --------------

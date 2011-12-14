% World Class
%
% Description
% World is academic environment. Scientists live in the world, they write
% paper and submit to journals for publication.
%
% World Properties:
% scientists     - Scientists produce papers.
% journals       - Journal review papers and publish papers.
% time           - How long the simulation will last.
%
% World Methods:
% simulate_world - Simulate the peer review in the world.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 14-Dec-2011

%------------- BEGIN CODE --------------

classdef ThurnerWorld < World
    
    properties (Constant)
        MEAN_IQ = 100;
        STDDEV_IQ = 10;
        
        STDDEV_QUALITY = 5;
        
        REFEREE_PER_PAPER = 2;
    end
    
    properties
        num_scientists;
        num_journals;
        
        f_rational;
        f_random;
        f_correct;
        
        lambda;
        alpha;
        
        producer;
        submitter;
        reviewer;
    end
    
    methods
        function obj = ThurnerWorld(num_scientists, num_journals, time, ...
                                    f_rational, f_random, f_correct, ...
                                    lambda, alpha)
            if nargin > 0
                obj.num_scientists = num_scientists;
                obj.num_journals = num_journals;
                obj.time = time;
                obj.f_rational = f_rational;
                obj.f_random = f_random;
                obj.f_correct = f_correct;
                obj.lambda = lambda;
                obj.alpha = alpha;
                obj.scientists = ThurnerScientist.empty(1, 0);
                obj.journals = Journal.empty(1, 0);
                for i = obj.num_scientists:-1:1
                    intel = ceil(normrnd(ThurnerWorld.MEAN_IQ, ThurnerWorld.STDDEV_IQ));
                    if i <= f_correct * num_scientists
                        obj.scientists(i) = ThurnerScientist(i, intel, ...
                                            ThurnerScientist.CORRECT_REFEREE);
                    elseif i <= (f_correct + f_random) * num_scientists
                        obj.scientists(i) = ThurnerScientist(i, intel, ...
                                            ThurnerScientist.RANDOM_REFEREE);
                    else
                        obj.scientists(i) = ThurnerScientist(i, intel, ...
                                            ThurnerScientist.RATIONAL_REFEREE);
                    end
                end
                for i = obj.num_journals:-1:1
                    obj.journals(i) = Journal(i, 0);
                end
                obj.producer = GaussianProducer(ThurnerWorld.STDDEV_QUALITY);
                obj.submitter = NaiveSubmitter(obj.journals);
                obj.reviewer = RandomReviewer(num_scientists, ...
                                              ThurnerWorld.REFEREE_PER_PAPER, ...
                                              obj.scientists);
            end
        end
        
        function simulate_world(obj)
            ThurnerSimulator.simulate(obj);
        end
    end
    
end

%------------- END OF CODE --------------

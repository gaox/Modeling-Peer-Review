% ThurnerWorld Class
%
% Description
% ThurnerWorld is a mashup of all components in the peer review world
% described in Thurner's paper. The readers are high suggested to read the
% original paper for all the details.
%
% ThurnerWorld Properties:
% MEAN_IQ               - Average intelligence of scientist.
% STDDEV_IQ             - Standard deviation of intelligence of scientist.
% STDDEV_QUALITY        - Standard deviation of quality produced by
%                         scientist.
% REFEREE_PER_PAPER     - Number of reviewer for one paper.
% num_scientists        - Number of scientists in the world.
% num_journals          - Number of journals in the world.
% f_rational            - Fraction of rational scientists.
% f_random              - Fraction of random scientists.
% f_correct             - Fraction of correct scientists.
% lambda                - For computing the moving average.
% alpha                 - The parameter for changing the minimum
%                         requirement of accepted papers.
% producer              - Algorithm to produce paper.
% submitter             - Algorithm to submit paper.
% reviewer              - Algorithm to review paper.
% 
% ThurnerWorld Methods:
% simulate_world - Simulate the peer review in the world.
%
% See also:
% http://arxiv.org/abs/1008.4324

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
        % Constructor: Construct the ThurnerWorld object, return the obj
        %              handle.
        %
        % Output:
        %   obj             - the handle of the created scientist object.
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
                    intel = normrnd(ThurnerWorld.MEAN_IQ, ThurnerWorld.STDDEV_IQ);
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

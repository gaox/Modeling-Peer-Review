% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef Scientist < handle
    
    % Scientist Class
    %
    % Description
    % Scientist produce paper, submit paper and review papers.
    % This class inherit from handle class in order to pass pointer instead
    % of value.
    %
    % Properties of Scientist
    % id          : The unique value to identify the scientist.
    % intelligence: Namely, the IQ of a scientist, this will influcen the 
    %               paper quality produced by the scientist.
    
    properties
        id;
        intelligence;
    end
    
    methods
        % Constructor: Construct the Scientist object, return the obj
        %              handle.
        % Input:
        %   intelligence    - the initial intelligence of the scientist
        % Output:
        %   obj             - the handle of the created scientist object
        function obj = Scientist(id, intelligence)
            if nargin > 0
                obj.id = id;
                obj.intelligence = intelligence;
            end
        end
        
        % produce_paper: 
        % Input:
        %   producer        - the producer provides the algorithm to
        %                     produce a paper for the calling author.
        % Output:
        %   paper           - the paper produced for the scientist.
        function paper = produce_paper(obj, producer)
            paper = producer.produce(obj);
        end
        
    end
    
    methods (Static)
        % submit_paper: 
        % Input:
        %   paper           - the paper to be submitted.
        %   submitter       - the sutmitter provides the algorithm to
        %                     decide to which journal the paper is submitted.
        % Output:
        %   journal         - the journal submitted to.
        function journal = submit_paper(paper, submitter)
            journal = submitter.submit(paper);
        end
    end
end

%------------- END OF CODE --------------

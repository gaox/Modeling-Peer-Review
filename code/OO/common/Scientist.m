% Scientist Class
%
% Description
% Scientist produce paper, submit paper and review papers.
% This class inherit from handle class in order to pass pointer instead
% of value.
%
% Scientist Properties:
% id            - The unique value to identify the scientist.
%
% Scientist Methods:
% produce_paper - The scientist finish writing a paper.
% submit_paper  - Submit the paper to a journal.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 13-Dec-2011

%------------- BEGIN CODE --------------

classdef Scientist < handle
    
    properties
        id;
    end
    
    methods
        function obj = Scientist(id)
        % Constructor: Construct the Scientist object, return the obj
        %              handle.
        %
        % Input:
        %   id              - the unique id of the scientist.
        % Output:
        %   obj             - the handle of the created scientist object.
            if nargin > 0
                obj.id = id;
            end
        end
        
        function paper = produce_paper(obj, producer)
        % produce_paper: The scientist finish writing a paper.
        %
        % Input:
        %   producer        - the producer provides the algorithm to
        %                     produce a paper for the calling author.
        % Output:
        %   paper           - the paper produced for the scientist.
            paper = producer.produce(obj);
        end
        
    end
    
    methods (Static)
        function journal = submit_paper(paper, submitter)
        % submit_paper: Submit the paper to a journal.
        %
        % Input:
        %   paper           - the paper to be submitted.
        %   submitter       - the sutmitter provides the algorithm to
        %                     decide to which journal the paper is submitted.
        % Output:
        %   journal         - the journal submitted to.
            journal = submitter.submit(paper);
        end
    end
end

%------------- END OF CODE --------------

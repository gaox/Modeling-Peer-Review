% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 12-Dec-2011

%------------- BEGIN CODE --------------

classdef NaiveSubmitter < Submitter

    % NaiveSubmitter Class
    %
    % Description
    % NaiveSubmitter provide a naive method to submit papers. There is only
    % one journal, therefore the NaiveSubmitter simply submit the paper to
    % that journal.
    %
    % Properties of NaiveSubmitter
    % journal   : The only journal in the world for publication.
    %
    % Methods of NaiveSubmitter
    % submit    : Produce the a paper for the scientist, the quality obeys 
    %             gaussian distribution.
    
    properties
        journal;
    end
    
    methods
        % Constructor: Construct the NaiveSubmitter object, return the obj
        %              handle.
        % Input:
        %   journal         - the only journal can be submitted to.
        % Output:
        %   obj             - the handle of the created submitter object.
        function obj = NaiveSubmitter(journal)
            if nargin > 0
                obj.journal = journal;
            end
        end
        
        % submit: Sutmit the paper to the only journal.
        %
        % Input:
        %   paper           - the handle of a paper to be submitted.
        % Output:
        %   journal         - the journal to be submitted to.
        function journal = submit(obj, ~)
            journal = obj.journal;
        end
    end
    
end

%------------- END OF CODE --------------

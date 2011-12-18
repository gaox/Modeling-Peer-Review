% NaiveSubmitter Class
%
% Description
% NaiveSubmitter provide a naive method to submit papers. There is only
% one journal, therefore the NaiveSubmitter simply submit the paper to
% that journal.
%
% NaiveSubmitter Properties:
% journal   - The only journal in the world for publication.
%
% NaiveSubmitter Methods:
% submit    - Submit the paper to the only journal.

% Author: Xiang Gao
% ETH Zurich, Dept. of Computer Science
% Email: gaox@ethz.ch 
% Created: December 2011
% Last revision: 18-Dec-2011

%------------- BEGIN CODE --------------

classdef NaiveSubmitter < Submitter
    
    properties
        journal;
    end
    
    methods
        function obj = NaiveSubmitter(journal)
        % Constructor: Construct the NaiveSubmitter object, return the obj
        %              handle.
        %
        % Input:
        %   journal         - the only journal can be submitted to.
        % Output:
        %   obj             - the handle of the created submitter object.
            if nargin > 0
                obj.journal = journal;
            end
        end
        
        function journal = submit(obj, ~)
        % submit: Sutmit the paper to the only journal.
        %
        % Input:
        %   paper           - the handle of a paper to be submitted.
        % Output:
        %   journal         - the journal to be submitted to.
            journal = obj.journal;
        end
    end
    
end

%------------- END OF CODE --------------

function phytreetool(varargin)
%PHYTREETOOL visualize and edit phylogenetic trees.
%
%   WARNING: PHYTREETOOL will be removed in a future release. 
%            Use PHYTREEVIEWER instead. 
%
%   PHYTREETOOL is an interactive tool that allows to edit phylogenetic
%   trees. The GUI allows to do branch pruning, reorder, renaming, distance
%   exploration and read/write NEWICK formatted files.
%   
%   PHYTREETOOL(TREE) loads a phylogenetic tree object into the GUI. 
%
%   PHYTREETOOL(FILENAME) loads a NEWICK file into the GUI. 
% 
%   Example:
%      
%       phytreetool('pf00002.tree')
%       
%   See also BIRDFLUDEMO, HIVDEMO, PHYTREE, PHYTREE/PLOT, PHYTREE/VIEW,
%   PHYTREEREAD, PHYTREEWRITE, PHYTREEVIEWER.

% Copyright 2003-2012 The MathWorks, Inc.

warning('bioinfo:seqalignviewer:incompatibility',...
        'PHYTREETOOL will be removed in a future release. Use PHYTREEVIEWER instead.')

phytreeviewer(varargin{:});
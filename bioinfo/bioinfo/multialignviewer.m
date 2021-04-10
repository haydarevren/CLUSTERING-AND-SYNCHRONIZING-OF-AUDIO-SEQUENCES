function varargout = multialignviewer(varargin)
%MULTIALIGNVIEWER visualize and edit a sequence alignment.
%
%   WARNING: MULTIALIGNVIEWER will be removed in a future release. 
%            Use SEQALIGNVIEWER instead. 
%
%   MULTIALIGNVIEWER is an interactive tool for viewing sequence alignment
%   results.
%
%   MULTIALIGNVIEWER(ALIGNMENT) loads a group of previously aligned
%   sequences into the viewer. ALIGNMENT can be a structure with a field
%   Sequence, a character array, or a filename.
%
%   MULTIALIGNVIEWER(...,'ALPHABET',ALPHA) specifies the aligned sequences
%   are amino acids ('AA') or nucleotides ('NT'). The default is AA. If
%   ALPHABET is not specified, MULTIALIGNVIEWER will guess the alphabet
%   type.
%
%   MULTIALIGNVIEWER(...,'SEQHEADERS',NAMES) passes a list of names to
%   label the sequences in the interactive tool. NAMES can be a vector of
%   structures with the fields 'Header' or 'Name', or a cell array of
%   strings. In both cases the number of elements provided must comply with 
%   the number of sequences in ALIGNMENT.
% 
%   Example:
% 
%       multialignviewer('aagag.aln')
%
%   See also BIRDFLUDEMO, FASTAREAD, GETHMMALIGNMENT, MULTIALIGN,
%   MULTIALIGNREAD, SEQALIGNVIEWER, SEQVIEWER. 

%    Copyright 2003-2012 The MathWorks, Inc. 

warning('bioinfo:phytreetool:incompatibility',...
        'MULTIALIGNVIEWER will be removed in a future release. Use SEQALIGNVIEWER instead.')

[varargout{1:nargout}] = seqalignviewer(varargin{:});

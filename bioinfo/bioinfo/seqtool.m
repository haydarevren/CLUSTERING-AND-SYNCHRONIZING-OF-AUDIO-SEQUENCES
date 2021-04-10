function varargout = seqtool(varargin)
%SEQTOOL visualize biological sequences.
%
%   WARNING: SEQTOOL will be removed in a future release. Use SEQVIEWER
%            instead.  
%
%   SEQTOOL is an interactive tool for viewing biological sequences.
%
%   SEQTOOL(SEQ) loads a sequence SEQ into the GUI. SEQ can be a structure
%   with a field Sequence, a character array, or a filename with an
%   extension of .gbk, .gpt, .fasta, .fa, or .ebi.
%
%   SEQTOOL(...,'ALPHABET',ALPHA) opens a sequence of alphabet ALPHA.
%   SEQTOOL uses 'AA' as default except when all symbols in the sequence
%   are in {'A' 'C' 'G' 'T' '-'}, then it uses 'NT'. Use 'AA' to force for
%   an amino acid sequence.
%
%   Examples:
%       S = getgenbank('M10051')
%       seqtool(S)
%
%       % open two sequences in a FASTA file
%       seqtool('hexaNT.fasta')
%
%   See also AA2NT, AACOUNT, AMINOLOOKUP, BASECOUNT, BASELOOKUP,
%   DIMERCOUNT, EMBLREAD, FASTAREAD, FASTAWRITE, GENBANKREAD, GENETICCODE,
%   GENPEPTREAD, GETEMBL, GETGENBANK, GETGENPEPT, NT2AA, PROTEINPLOT, 
%   SEQALIGNVIEWER, SEQCOMPLEMENT, SEQDISP, SEQRCOMPLEMENT, SEQREVERSE,
%   SEQSHOWORFS, SEQSHOWWORDS, SEQVIEWER, SEQWORDCOUNT.

% Copyright 2003-2012 The MathWorks, Inc.

warning('bioinfo:seqviewer:incompatibility',...
        'SEQTOOL will be removed in a future release. Use SEQVIEWER instead.')

[varargout{1:nargout}] = seqviewer(varargin{:});
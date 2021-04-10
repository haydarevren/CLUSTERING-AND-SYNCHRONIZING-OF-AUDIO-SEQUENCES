function write(obj,filename,varargin)
%WRITE writes the contents of a BioRead object.
%
%   WRITE(OBJ,FILENAME) writes the contents of a BioRead object to file
%   FILENAME. FILENAME is a string containing the base name of the file and
%   it can be prepended by an absolute or relative path. If the path is
%   missing the file is written in the same directory as the source file is
%   (when the object is indexed) or in the current directory (when the data
%   is in memory).
%
%   WRITE(...,'FORMAT',F) specifies the type of file format. Available
%   options are 'fasta','fastq'. Default is 'fasta' when the 'Quality'
%   property is empty, otherwise, default is 'fastq'.
%
%   WRITE(...,'OVERWRITE',TRUE) allows overwrite an existing file as long
%   as system file permissions are available. Default is FALSE. WRITE also
%   deletes the respective index file (.IDX) that becomes stale.

checkScalarInput(obj);
details = getAdapterDetails(obj);

if details.InMemory && isempty(obj.Quality)
    format = 'fasta';
else
    format = 'fastq';
end

% Parse optional PVPs and/or set defaults
[format, overwrite] = parse_inputs(format,varargin{:});

% Validate filename (if no file extension given one is added)
[outfilePath, outfileName, outfileExt] = fileparts(filename);
if ~isempty(outfileExt)
   if ~strcmpi(['.' format],outfileExt)
       error('bioinfo:BioRead:write:InvalidFileExtension','File extension is different to the default format or the specified format.')
   end
end
outfileExt = ['.' format];

% If no file path specified, we use the same location where the source is,
% for objects in memory we use the current path
if isempty(outfilePath) && ~isempty(details.FileName)
    outfilePath = fileparts(details.FileName);
end

outfilePathName = fullfile(outfilePath,outfileName);
filename = [outfilePathName, outfileExt];
fileToCheck = [outfilePathName,'.',format,'.idx'];

if overwrite
    if stricmp(filename,details.FileName)
        error('bioinfo:BioRead:write:OutputFileInvalid','Output file is the same as the data source file of this object.')
    end    
    if exist(fileToCheck,'file')
        delete(fileToCheck)
        if exist(fileToCheck,'file')
            error('bioinfo:BioRead:write:CannotDeleteFile','Cannot delete potentially stale file: %s',fileToCheck)
        end
    end
else
    if exist(filename,'file')
        error('bioinfo:BioRead:write:OutputFileExists','Output file (%s) already exists.',filename)
    end
    if exist(fileToCheck,'file')
            warning('bioinfo:BioRead:write:StaleFile','Potential stale file: %s.',fileToCheck)
    end  
end

if strcmp(details.FileFormat,'sam') || strcmp(details.FileFormat,'bam')
    bioinfoprivate.bamaccessmex('bam2bam',details.FileName,details.FileFormat,filename,format,uint32([details.SubsetIndex]))
    return;
end

if details.InMemory 
    if isempty(obj.Sequence) || (strcmp(format,'fastq') && isempty(obj.Quality))
        error('bioinfo:BioRead:write:EmptyProperties','Object properties cannot be empty.')
    end
end    

fid = fopen(filename,'wt');
if fid<0
   error('bioinfo:BioRead:write:CannotOpenTextFile','Cannot open text file for writing: %s',filename)
end

blockSize = 1000;
try
    if strcmp(format,'fastq')
        for i = 1:blockSize:obj.NSeqs
            t = (get(getSubset(obj,i:min(i+blockSize,obj.NSeqs)),{'Header','Sequence','Quality'}));
            tmp = [t{1} t{2} t{3}]';
            fprintf(fid,'@%s\n%s\n+\n%s\n',tmp{:});
        end
    else
        for i = 1:blockSize:obj.NSeqs
            t = (get(getSubset(obj,i:min(i+blockSize,obj.NSeqs)),{'Header','Sequence'}));
            tmp = [t{1} t{2}]';
            fprintf(fid,'>%s\n%s\n',tmp{:});
        end
    end
catch ME
    fclose(fid);
    error('bioinfo:BioRead:write:CannotWriteToTextFile','Cannot add more records to file: %s',filename)
end
fclose(fid);
end

function [format, overwrite] = parse_inputs(format,varargin)
% Parse input PV pairs.

% default values
overwrite = false;

if rem(nargin, 2) == 0
    error(message('bioinfo:BioRead:write:IncorrectNumberOfArguments', mfilename));
end
okargs = {'format', 'overwirte'};
for j=1:2:nargin-1
    [k, pval] = bioinfoprivate.pvpair(varargin{j}, varargin{j+1}, okargs, mfilename);
    switch(k)
        case 1  % format
            [~,format] = bioinfoprivate.optPartialMatch(pval,{'fasta','fastq'}, okargs{k}, mfilename); 
         case 2 % overwrite
            overwrite = bioinfoprivate.opttf(pval);
    end
end
end
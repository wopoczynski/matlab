function A = goannotread(file,varargin)
%Zmodyfikowana przez Ola Gruca
% GOANNOTREAD parses Gene Ontology Annotated files and returns annotations
%
%   ANNOTATION = GOANNOTREAD(FILE) converts the contents of FILE into an
%   array of structs, ANNOTATION. Files should have the structure specified
%   in http://www.geneontology.org/GO.format.annotation.shtml
%
%   GOANNOTREAD(...,'FIELDS',FIELDNAMES) allows you to specify the fields
%   to be read from the annotation file. FIELDNAMES can be a single string
%   or a cell array of strings. The default is to read all fields. Valid
%   fieldnames are:
%
%   Database
%	DB_Object_ID
%	DB_Object_Symbol
%	Qualifier
%	GOid
%	DBReference
%	Evidence
%	WithFrom
%	Aspect
%	DB_Object_Name
%	Synonym
%	DB_Object_Type
%	Taxon
%	Date
%	Assigned_by
%
%   More detailed information about these fields can be found in the
%   reference page for this function and at
%   http://www.geneontology.org/GO.format.annotation.shtml
%
%   GOANNOTREAD(...,'ASPECT',ASPECT) allows you to specify which aspects
%   are read from the annotation file. ASPECT should be a character array
%   containing one of more characters corresponding to valid aspects. Valid
%   aspects are: P (biological process), F (molecular function) or C
%   (cellular component). The default is to read all aspects ('CFP').
%
%   Many annotation files can be found here:
%   http://www.geneontology.org/GO.current.annotations.shtml
%
%   Example:
%        % Note that the SGD file must first be downloaded and unzipped from
%        % http://www.geneontology.org/GO.current.annotations.shtml.
%        SGDGenes = goannotread('gene_association.sgd');
%        S = struct2cell(SGDGenes);
%        genes = S(3,:)'
%
%   See also CNSGENEEXPDEMO, GENEONT, GENEONT.GENEONT.GETANCESTORS,
%   GENEONT.GENEONT.GETDESCENDANTS, GENEONT.GENEONT.GETMATRIX,
%   GENEONT.GENEONT.GETRELATIVES, GENEONT.GENEONT.SUBSREF,
%   GENEONTOLOGYDEMO, NUM2GOID.

%   Copyright 2005-2008 The MathWorks, Inc.
%   $Revision: 1.1.10.7 $  $Date: 2008/06/16 16:31:54 $

%
% 1) DB               - the database contributing the gene_association file,mandatory,cardinality 1
% 2) DB_Object_ID     - a unique identifier in DB for the item being annotated,mandatory, cardinality 1
% 3) DB_Object_Symbol - symbol to which DB_Object_ID is matched,mandatory,  cardinality 1
% 4) Qualifier 	      - flags that modify the interpretation of an annotation,not mandatory,cardinality 0, 1, >1;
% 5) GOid             - the GO identifier for the term attributed to the DB_Object_ID,mandatory,cardinality 1
% 6) DB:Reference	  - the unique identifier appropriate to DB for the authority for the attribution of the GOid to the DB_Object_ID,mandatory,cardinality 1, >1
% 7) Evidence		  - one of IMP, IGI, IPI, ISS, IDA, IEP, IEA, TAS,NAS, ND, IC, RCA,mandatory,cardinality 1
% 8) With (or) From   - one of: DB:gene_symbol,DB:gene_symbol[allele_symbol],DB:gene_id,DB:protein_name,DB:sequence_id,GO:GO_id, not mandatory,cardinality 0, 1, >1
% 9) Aspect			  - one of P (biological process), F (molecular function) or C (cellular component),mandatory,cardinality 1
%10) DB_Object_Name   - name of gene or gene product,not mandatory,cardinality 0, 1 [white space allowed]
%11) Synonym          - Gene_symbol,not mandatory,cardinality 0, 1
%12) DB_Object_Type	  - one of gene, transcript, protein,protein_structure, complex,mandatory, cardinality 1
%13) Taxon			  - taxonomic identifier(s),mandatory, cardinality 1,2
%14) Date			  - Date on which the annotation was made; format is YYYYMMDD,mandatory, cardinality 1
%15) Assigned_by	  - The database which made the annotation,mandatory, cardinality 1


bioinfochecknargin(nargin,1,mfilename);
[fields,aspect] = parse_inputs(varargin{:});
% read in the file
fid = fopen(file);
if(fid == -1)
    error('Bioinfo:goannotread:CannotOpenFile',...
        'Could not open %s.',...
        file);
end

pos = 0;
line = fgetl(fid);
while (~isempty(regexp(line,'^!', 'once')) || ~isempty(regexp(line,'^#', 'once')))
    pos = ftell(fid);
    line = fgetl(fid);
end

firstline = strread(line,'%s',1,'delimiter','\n');
columncount = length(regexp(firstline{1},'(.*?\t)')); % 14 for gene annotation files 6 for gene2go
fseek(fid,pos,'bof');
allAspects = isequal(aspect.validAspects,aspect.selectedAspects);
if columncount >= 14
    % original format was 14 columns. One more was added.
    if columncount> 15
        unKnownFormat = true;
    else
        unKnownFormat = false;
    end
    try
        f = {'Database','DB_Object_ID','DB_Object_Symbol','Qualifier','GOid','DBReference','Evidence','WithFrom','Aspect','DB_Object_Name','Synonym','DB_Object_Type','Taxon','Date','Assigned_by','Annotation_Extension','Gene_Product_Form_ID','Unknown1','Unknown2','Unknown3'};
        goidFieldNum = 5;
        aspectFieldNum = 9;
        returnAspect = true;
        if strcmpi(fields,'all')
            
            matches = true(size(f));
        else
            
            [matches,loc] = ismember(lower(fields),lower(f));
            if any(loc == 0)
                badField = (loc == 0);
                error('Bioinfo:goannotread:UnknownField','Unknown field %s',fields{badField});
            end
            matches = ismember(lower(f),lower(fields));
            if matches(goidFieldNum)
                goidFieldNum = sum(matches(1:goidFieldNum));
            else
                goidFieldNum = 0;
            end
            if ~allAspects
                if ~matches(aspectFieldNum)
                    returnAspect = false;
                end
                matches(aspectFieldNum) = true;
                aspectFieldNum = sum(matches(1:aspectFieldNum));
            end
        end
        formatString = '';
        for counter = 1:numel(f)
            if matches(counter)
                formatString = [formatString '%s']; %#ok<AGROW>
            else
                formatString = [formatString '%*s']; %#ok<AGROW>
            end
            
        end
        
        f = f(matches);
        if ~returnAspect
            f(aspectFieldNum) = [];
        end
        theData = textscan(fid,formatString, 'delimiter', '\t');
        %         aspects = theData{9};
        %         mask = strcmp(aspects,'F');
        d = [theData{:}];
    catch theException
        fclose(fid);
        if unKnownFormat
            error('Bioinfo:goannotread:NonAnnotationFile','%s is not a recognized gene annotation file',file);
        else
            rethrow(theException)
        end
        
    end
elseif columncount == 6 % old format
    f = {'TaxonomyID','GeneID','GOid','Evidence','Qualifier','GOterm','PubMed'};
    
    % parse the annotation file
    theData = textscan(goann,'%s%s%s%s%s%s%s', 'delimiter', '\t');
    % Field Names
    d = [theData{:}];
else
    fclose(fid);
    error('Bioinfo:goannotread:NonAnnotationFile','%s is not a recognized gene annotation file',file);
    
end
fclose(fid);
if ~allAspects
    mask = ~ismember(upper(d(:,aspectFieldNum)),cellstr(aspect.selectedAspects'));
    if ~returnAspect
        d(:,aspectFieldNum) = [];
    end
    d(mask,:) =[];
end
if goidFieldNum >0
    goids = char(d(:,goidFieldNum));
    d(:,goidFieldNum) = num2cell(str2num(goids(:,4:10))); %#ok
end
A = cell2struct(d,f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fields,aspect] = parse_inputs(varargin)
% Parse the varargin parameter/value inputs

% Check that we have the right number of inputs
if rem(nargin,2)== 1
    error(sprintf('Bioinfo:%s:IncorrectNumberOfArguments',mfilename),...
        'Incorrect number of arguments to %s.',mfilename);
end

% The allowed inputs
okargs = {'fields','aspect'};

% Set default values
fields = 'all';
aspect.validAspects  = 'CFP';
aspect.selectedAspects = aspect.validAspects;
% Loop over the values
for j=1:2:nargin
    % Lookup the pair
    [k, pval] = pvpair(varargin{j}, varargin{j+1}, okargs, mfilename);
    switch(k)
        case 1  % Fields -- check these later when we know the type of file
            if ~ischar(pval) && ~iscellstr(pval)
                error('Bioinfo:goannotread:FieldsNotString',...
                    'Unrecognized frame number.')
            end
            if isempty(pval)
                error('Bioinfo:goannotread:EmptyField',...
                    'FIELDNAME is empty.')
            end
            if ischar(pval)
                pval = {pval};
            end
            fields = sort(upper(pval));
        case 2  % Aspect
            if ~ischar(pval)
                error('Bioinfo:goannotread:AspectNotChar',...
                    'Unrecognized frame number.')
            end
            aspect.selectedAspects = sort(upper(pval));
            if isempty(intersect(aspect.selectedAspects,aspect.validAspects)) ||...
                    ~isempty(setdiff(aspect.selectedAspects,aspect.validAspects))
                error('Bioinfo:goannotread:InvalidAspect',...
                    'Invalid Aspect. Possible balues are ''C'', ''F'', and ''P''.')
            end
    end
end


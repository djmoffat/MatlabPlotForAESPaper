function list = listFilesInDir(directory, fileType)
%%
% Written by Dave Moffat 24/1/15
% Usage list = listFilesInDir(directory, fileType)
% Takes a directory and returns a list of all files with a given type
% Arguments:
% directory = directory to search in eg. '~'
% fileType = the string file type eg. 'wav'
% list = list of file names

if(nargin < 2)
	fileType = 'all';      % all files types
end

list = dir(directory);

i = 1;
size(list,1);
while i <= size(list,1)
%     list(i).name
%     disp(list(i).name);
    nameSplit = strsplit(list(i).name, '.');
%     si = size(nameSplit,2)
%     ns = nameSplit{2}
%     boolIn = ~strcmp(nameSplit{2},'')

    
    if( size(nameSplit,2) > 1 & or(strcmp(nameSplit(end),fileType),(strcmp(fileType,'all') & ~strcmp(nameSplit{2},''))))
        file = fullfile(directory,list(i).name);
    else
        list(i) = [];
        i = i-1;
    end
    %     end
    i = i + 1;
end




end

% In order to use this database, one has to download the Matlab toolbox 
% "jsonlab" from 
% https://uk.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files

%%
% Call

>> ex1

% to generate a structure including data for Example 1. To convert it into 
% json format and write it into an ASCII file, call

>> sdp_json = savejson('sdp',sdp1);  %the output is a character array
>> fileID = fopen('myfile.txt','w');
>> fprintf(fileID,'%s\n',sdp_json)

% To read the json format from myfile.txt and convert it back into a Matlab 
% structure, call

>> sdp_json = fileread('myfile.txt');
>> my_sdp_structure = loadjson(sdp_json);

%%

% SDP2POEMA reads SDPA sparse format and returns POEMA Matlab structure
% POEMA2JSON converts POEMA Matlab structure to POEMA json format
% POEMA2SPARSE converts POEMA Matlab structure to sparse matrices





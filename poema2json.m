function poema2json(name); 
%POEMA2JSON converts SDP POEMA Matlab structure to POEMA json format
%
% Input: name of the SDP problem in the folder problems/MATLAB_POEMA/
%
% Output: txt file in json format in folder problems/JSON/
%  
% This file is a part of POEMA database distributed under GPLv3 license
% Copyright (c) 2020 by EC H2020 ITN 813211 (POEMA) 
% Coded by Michal Kocvara, m.kocvara@bham.ac.uk
% Last Modified: 18 Apr 2020

load(['problems/MATLAB_POEMA/',name]);

sdp_json = savejson([],sdp);
fileID = fopen(['problems/JSON/',name,'.json'],'w');
fprintf(fileID,'%s\n',sdp_json);





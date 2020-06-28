function poema2sdpa(poe, fname);
%POEMA2SPARSE converts SDP POEMA Matlab structure to sparse matrices
%
% Input: SDP problem in the POEMA Matlab structure
%        name of the SDPA file on output 
%
% This file is a part of POEMA database distributed under GPLv3 license
% Copyright (c) 2020 by EC H2020 ITN 813211 (POEMA)
% Coded by Michal Kocvara, m.kocvara@bham.ac.uk
% Last Modified: 28 July 2020

fid = fopen(fname,'wt');

fprintf(fid,'%d\n',poe.nvar);
fprintf(fid,'%d\n',poe.constraints.nlmi);
g=sprintf('%d ', poe.constraints.msizes);
fprintf(fid,'%s\n',g);
g=sprintf('%d ', poe.objective);
fprintf(fid,'%s\n',g);

for i=1:size(poe.constraints.lmi_symat,1)
    tmp = poe.constraints.lmi_symat(i,:);
    fprintf(fid,'%5d %5d %5d %5d %16f \n',tmp(2),tmp(3),tmp(4),tmp(5),tmp(1));
end

fclose(fid);

end
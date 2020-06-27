function sdpdata = poema2sparse(poema_struct); 
%POEMA2SPARSE converts SDP POEMA Matlab structure to sparse matrices
%
% Input: SDP problem in the POEMA Matlab structure
%
% Output: a Matlab structure with data matrices stored as Matlab sparse
% matrices
%  
% This file is a part of POEMA database distributed under GPLv3 license
% Copyright (c) 2020 by EC H2020 ITN 813211 (POEMA) 
% Coded by Michal Kocvara, m.kocvara@bham.ac.uk
% Last Modified: 18 Apr 2020


sdpdata = poema_struct;

sdpdata = rmfield(sdpdata,'objective');
sdpdata.constraints = rmfield(sdpdata.constraints,'lmi_symat');
if isfield(sdpdata.constraints,'lsi_mat'), sdpdata.constraints = rmfield(sdpdata.constraints,'lsi_mat'); end
if isfield(sdpdata.constraints,'lsi_vec'), sdpdata.constraints = rmfield(sdpdata.constraints,'lsi_vec'); end
if isfield(sdpdata.constraints,'nlsi'), sdpdata.constraints = rmfield(sdpdata.constraints,'nlsi'); end
if isfield(sdpdata.constraints,'nlmi'), sdpdata.constraints = rmfield(sdpdata.constraints,'nlmi'); end
if isfield(sdpdata.constraints,'msizes'), sdpdata.constraints = rmfield(sdpdata.constraints,'msizes'); end
if isfield(sdpdata.constraints,'lsi_op'), sdpdata.constraints = rmfield(sdpdata.constraints,'lsi_op'); end
sdpdata = rmfield(sdpdata,'constraints');

sdpdata.c = sparse(poema_struct.objective);

% convert LMI matrices into Matlab sparse format
alldata = poema_struct.constraints.lmi_symat';
matblk = find(poema_struct.constraints.msizes);
na = length(matblk);
nx = poema_struct.nvar;
sdpdata.nlmi = poema_struct.constraints.nlmi;
sdpdata.msizes = poema_struct.constraints.msizes;
sdpdata.nlin = poema_struct.constraints.nlsi;
sdpdata.lsi_op = poema_struct.constraints.lsi_op;
A = cell(na,nx+1);
for iii=1:length(matblk)
    iblk = matblk(iii);
    dim = poema_struct.constraints.msizes(iblk);
    idxentries = find(alldata(3,:)==iblk);
    thisblock = alldata(:,idxentries); 
    thisblock = circshift(thisblock,-1);
    if (any(thisblock(3,:)<1 | thisblock(3,:)>dim | thisblock(4,:)<1 | ...
            thisblock(4,:)>dim))
        error(sprintf('Block %d have indices not matching its dim=%d.',iblk,dim));
    end
    % if i>j --> lower triangle which is not allowed
    if (any(thisblock(3,:)>thisblock(4,:)))
        error(sprintf('Block %d have elements outside upper triangle.',iblk));
    end
    % extract each of the matrices in this block
    for i = 0:nx
        idx = find(thisblock(1,:)==i);
        if (isempty(idx))
            A{iblk,i+1} = sparse(dim,dim);
        else
            M = sparse(thisblock(3,idx),thisblock(4,idx),thisblock(5,idx),dim,dim);
            A{iblk,i+1} = M+triu(M,1)';
        end
    end
end

sdpdata.A = A;

l = poema_struct.constraints.lsi_mat;
sdpdata.C = sparse(l(:,2),l(:,3),l(:,1));

sdpdata.d = sparse(poema_struct.constraints.lsi_vec);

end
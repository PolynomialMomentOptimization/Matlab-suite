sdp=sdpa2poema('problems/SDPA/buck5.dat-s');
sdp.lowrank = [1 1];
sdp.lmirank = [0 1];
save 'problems/MATLAB_POEMA/buck5' sdp
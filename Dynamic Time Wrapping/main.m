restoredefaultpath;
clear all;
close all;

v1 = [0.69 0.72 0.72 0.76 0.81 0.82 0.84 0.87;
      0.26 0.26 0.30 0.38 0.38 0.30 0.26 0.25];


v2 = [0.10 0.17 0.24 0.31 0.36 0.40 0.42 0.46 0.50 0.57 0.64 0.71 0.74 0.77 0.81 0.83 0.86 0.90 0.95 0.99;
      0.30 0.38 0.49 0.54 0.54 0.47 0.37 0.29 0.25 0.26 0.26 0.26 0.31 0.38 0.38 0.32 0.25 0.25 0.24 0.25];
  
[result, start_frame, end_frame] =  dtw2( v1, v2);
% Filename:  'DisProf_OCLUStest_2G2D.m'

% This script is written to test the Disprof Clustering algorithm.  Testing
% will be on both the 'Fathom' toolbox function 'f_disprof_clust' and also
% the 'clust_X' toolbox function 'f_mst_clust'.  The data used for the
% testing are as follows:

%       - Simulated data from 'OCLUS_OverlapEffect_DataSim.m'
%       - Simulated data have TWO GROUPS and TWO DIMENSIONS


% This file is designed to be used in batch job-submission on the CIRCE
% resources at USF - Tampa.

% Created by:       Joshua Kilborn
% Date Finalized:   22-September-2015 
% Date Edited:      n/a    

% *************************************************************************
% *************************************************************************

% Add paths for datafiles and toolboxes so that the script can be run on
% the CIRCE resources:

% Matlab Function Toolboxes:
addpath('/work/j/jpk/Toolboxes/Fathom');    % Add 'Fathom' toolbox
addpath('/work/j/jpk/Toolboxes/clust_X');   % Add 'clust_X' toolbox
addpath('/work/j/jpk/Toolboxes/Darkside');  % Add 'Darkside' toolbox

% Simulated Test Data:
addpath('/work/j/jpk/OCLUS_Data');          % Add simulated datafiles

% Set the parralel processing pool:
c = parcluster('local');
c.NumWorkers = 50;
parpool(c, c.NumWorkers);

% *************************************************************************
% Load & Test the simulated data:
% *************************************************************************

% Load the dataset:
load('OCLUS_Overlap_TestData_2G2D.mat');

% Clean up the workspace:
clear fname pee

% Set new file name for output data:
fname = 'OCLUS_Overlap_Results_2G2D';

% Test both DisProf Clustering methods (with MSTs and with UPGMA):
[disp2G2D,mst2G2D] = ds_disprof_testOCLUS(S,'euc',1000); 

% Clean up workspace:
clear ans c
                                           
% Save ALL of the results to the server:
save(['/work/j/jpk/OCLUS_TestingResults/' fname],'-v7.3');

% *************************************************************************

% Stop the parrallel processing pool:
delete(gcp);
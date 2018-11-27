%% Main file to obtain UL channel from the outdoor experiment
%
%  Cheng-Ming Chen, Andrea P. Guevara 2018
%

clear 
close 

%Scenario parameters
%BTS
NumBSAnt      = 32;         % Number of antennas per array
NumArray      = 2;          % Number of arrays
NumBSTotalAnt = NumBSAnt*NumArray; % Total number of antennas in the system

%UE
NumRealUE     = 12;         % Number UE per row
Rows = 3;                   % Number of rows deployed

%System
NumReal = 100;              % Number of subcarriers collected
  
H = functionProcesData(NumBSTotalAnt,Rows,NumReal,NumRealUE);

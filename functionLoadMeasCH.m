%% LoadMeasCH v1
%
%  Cheng-Ming Chen, 2018
%
%  ------------
%  Instructions
%  ------------
%
%  File to load channel from raw data.
%
%  This file  is used only for loading the channel, and keep all the variables in the workspace
%  to save time not keep loading the same data everytime
%
%  we have 100 subcarriers as one subcarrier per RB
%  the collection is from 64 antennas, but that can be a parameter if you collect 32 or 16
%
function [CHResponseReal,CHResponseImag] = functionLoadMeasCH(NumBSAnt,RowNum)

folder = [''];
common_filename = [' Scenario  run 1 '];
Row = ['_Row',num2str(RowNum)];
filenameReal   = [folder,'NumAnt ',num2str(NumBSAnt),common_filename,'Real',num2str(Row),'.csv'];
filenameImag   = [folder,'NumAnt ',num2str(NumBSAnt),common_filename,'Imag',num2str(Row),'.csv'];

CHResponseReal = dlmread(filenameReal);
CHResponseImag = dlmread(filenameImag);

end

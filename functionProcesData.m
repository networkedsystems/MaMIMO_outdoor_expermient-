%% Main file to process the data load in CHr and CHi
%
%  Cheng-Ming Chen, Andrea P. Guevara 2018
%
%  ------------
%  Instructions
%  ------------
%
% Process the data in a single 3D matrix H as folows:
% H[Number of Antennas, Number of Realizations, Number of UE].

function [H] = functionProcesData(NumBSTotalAnt,row, NumReal,NumRealUE)

H = zeros(NumBSTotalAnt,NumReal,NumRealUE*row);
H_aux = zeros(NumBSTotalAnt,NumReal,NumRealUE*row);
for r = 1:row

        % load outdoor measured channel
        [CHr,CHi] = functionLoadMeasCH(NumBSTotalAnt,r);

        % Number of subcarriers per realization
        [NumAll, ~] = size(CHr);
        % map to 6 locations in a row
        NumUEAntInSet = 6; 
        % number of realization in time
        NumSub = 100;
        NumRealiz = floor(NumAll/NumBSTotalAnt/NumUEAntInSet/NumSub);

        TotalReal = NumRealiz*NumSub;
        % total number of realizations, number of total BS antennas for two arrays, number of UE
        % antennas
        CPLEXCH = zeros(NumBSTotalAnt,TotalReal,NumRealUE);

        % subcarrier, BS antenna, realization, location
        % reorder channel into matrix, separate realization and BS antennas
        CplexCH = CHr+1i.*CHi;
        for UEAntIdx = 1:NumUEAntInSet    
            for real = 1:NumRealiz
                for BSAntIdx = 1:NumBSTotalAnt                     
                    % pick only one antenna for each location
                    CH = CplexCH(((BSAntIdx-1)*NumSub+1:BSAntIdx*NumSub)+(real-1)*NumBSTotalAnt*NumSub+(UEAntIdx-1)*NumBSTotalAnt*NumSub*NumRealiz,:);
                    CPLEXCH(BSAntIdx,((real-1)*NumSub+1:real*NumSub),(UEAntIdx-1)*2+1:UEAntIdx*2) = CH;
                end
            end            
        end
        %Group all the users
        H_aux(:,:,((r-1)*NumRealUE+1):r*NumRealUE) = CPLEXCH(:,1000:NumReal+1000-1,:);        
end

%Separate users per cell
for r = 1:row
    %Cell 1
    H(:,:,((r-1)*NumRealUE/2+1):r*NumRealUE/2) = H_aux(:,:,((r-1)*NumRealUE+1):(r-1/2)*NumRealUE);
    %Cell 2
    H(:,:,((r-1)*NumRealUE/2+3/2*NumRealUE+1):r*NumRealUE/2+3/2*NumRealUE) = H_aux(:,:,(r-1/2)*NumRealUE+1:r*NumRealUE);
end
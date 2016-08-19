tic
Ntime = 2^12;
[S_PCA, H1_PCA, H2_PCA, DMJD_time]=textread('Dlcname','%s %s %s %f');
[S_std, H1_std, H2_std, MJD_time]=textread('./aux_rex/Dlc_HID_2003','%s %s %s %f');
[Hardness_std, Hardness_std_error, Intensity_std, Intensity_std_error, ~] = ...
    textread('./aux_rex/DHID_PCU2_results_2003', '%f %f %f %f %f');
N_PCA = length( S_PCA );
N_std = length( S_std);
S_PCA_simp = cell(N_PCA, 1);
S_std_simp = cell(N_std, 1);
exp_PCA = '_C0-13_(.+)\.lc';      %include A\B\C\D
exp_std = '^(.+)/std';      

Intensity=zeros(1,N_PCA);    Intensity_error=zeros(1,N_PCA);
Hardness=zeros(1,N_PCA);     Hardness_error=zeros(1,N_PCA);
Phaselag1_BLN=zeros(1,N_PCA);    Phaselag1_error_BLN=zeros(1,N_PCA);
Phaselag1_RED=zeros(1,N_PCA);    Phaselag1_error_RED=zeros(1,N_PCA);
Phaselag2_BLN=zeros(1,N_PCA);    Phaselag2_error_BLN=zeros(1,N_PCA);
Phaselag2_RED=zeros(1,N_PCA);    Phaselag2_error_RED=zeros(1,N_PCA);
Rms_BLN=zeros(1,N_PCA);      Rms_BLN_error=zeros(1,N_PCA);
Rms_RED=zeros(1,N_PCA);      Rms_RED_error=zeros(1,N_PCA);
Rms_All=zeros(1,N_PCA);      Rms_All_error=zeros(1,N_PCA);
Obs_time=zeros(1,N_PCA);
for i=1:N_PCA
   [S_PCA_simp(i), ~] = regexp(S_PCA{i}, exp_PCA, 'tokens', 'match');
end
for i=1:N_std
    [S_std_simp(i), ~] = regexp(S_std{i}, exp_std, 'tokens', 'match');
end


for i=1:N_PCA
    End_char = S_PCA_simp{i}{1}(end);
    if ~isempty(intersect(End_char, 'ABCDE'))
       S_PCA_simp{i} = S_PCA_simp{i}{1}(1:(end-1));
    end
    for j=1:N_std
        if strcmp(S_std_simp{j}, S_PCA_simp{i})
            break;
        end
    end
    Hardness(i)=Hardness_std(j);   Hardness_error(i)=Hardness_std_error(j);
    Intensity(i)=Intensity_std(j);  Intensity_error(i)=Intensity_std_error(j);
    Obs_time(i) = obstime(S_PCA{i});
    [Phaselag1_BLN(i), Phaselag1_error_BLN(i)] = phaselag(S_PCA{i}, H1_PCA{i}, 0, 1);
    [Phaselag1_RED(i), Phaselag1_error_RED(i)] = phaselag(S_PCA{i}, H1_PCA{i}, 1, 10);
    [Phaselag2_BLN(i), Phaselag2_error_BLN(i)] = phaselag(S_PCA{i}, H2_PCA{i},0, 1);
    [Phaselag2_RED(i), Phaselag2_error_RED(i)] = phaselag(S_PCA{i}, H2_PCA{i}, 1, 10);
    [Rms_BLN(i), Rms_BLN_error(i)] = Miyamoto(S_PCA{i}, 0, 1);
    [Rms_RED(i), Rms_RED_error(i)] = Miyamoto(S_PCA{i}, 1, 10);
    [Rms_All(i), Rms_All_error(i)] = Miyamoto(S_PCA{i}, 0, 20);
end


Phase_results_2003=[Hardness; Hardness_error; Intensity; Intensity_error; ...
    Phaselag1_BLN; Phaselag1_error_BLN; Phaselag1_RED; Phaselag1_error_RED;...
    Phaselag2_BLN; Phaselag2_error_BLN; Phaselag2_RED; Phaselag2_error_RED;...
    Rms_BLN; Rms_BLN_error; Rms_RED; Rms_RED_error;...
    Rms_All; Rms_All_error];
fid=fopen('DPhaselag_results_2003','w');
fprintf(fid,'%5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f\n',...
    Phase_results_2003);
fclose(fid);

fid=fopen('DObstime_2003','w');
fprintf(fid,'%5.8f\n',Obs_time);
fclose(fid);
% 
% % fitsread(strcat(['./aux_rex/'],H1_std{1}),'binarytable');
% 

toc


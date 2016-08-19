tic

Ntime = 2^12;
[S2, f2, f2_down, f2_up, H2]=textread('fdownup2','%s %f %f %f %s');        %first harmonic 
[S0, f0, f0_down, f0_up, H0]=textread('fdownup0','%s %f %f %f %s');        %half basic 
[S_PCA, f_QPO, f_down, f_up, H1_PCA, H2_PCA]=textread('fdownup1','%s %f %f %f %s %s');
[S_std, H1_std, H2_std, MJD_time]=textread('./aux_rex/Dlc_HID_QPO','%s %s %s %f');
[Hardness_std, Hardness_std_error, Intensity_std, Intensity_std_error] = ...
    textread('./aux_rex/DHID_PCU2_results_QPO', '%f %f %f %f');
N_PCA = length( S_PCA );
N_std = length( S_std );
S_PCA_simp = cell(N_PCA, 1);
S_std_simp = cell(N_std, 1);
exp_PCA = '_C0-13_(.+)\.lc';      %include A\B\C\D
exp_std = '^(.+)/std';      

Obs_time=zeros(1,N_PCA);
Hardness=zeros(1,N_PCA);     Hardness_error=zeros(1,N_PCA);
Intensity=zeros(1,N_PCA);    Intensity_error=zeros(1,N_PCA);
Phaselag1_BLN=zeros(1,N_PCA);    Phaselag1_error_BLN=zeros(1,N_PCA);
Phaselag1_RED=zeros(1,N_PCA);    Phaselag1_error_RED=zeros(1,N_PCA);
Phaselag2_BLN=zeros(1,N_PCA);    Phaselag2_error_BLN=zeros(1,N_PCA);
Phaselag2_RED=zeros(1,N_PCA);    Phaselag2_error_RED=zeros(1,N_PCA);
QPO_Phi1=zeros(1,N_PCA);    QPO_Phi1_error=zeros(1,N_PCA);
QPO_Phi2=zeros(1,N_PCA);    QPO_Phi2_error=zeros(1,N_PCA);

Timelag1_BLN=zeros(1,N_PCA);    Timelag1_error_BLN=zeros(1,N_PCA); 
Timelag1_RED=zeros(1,N_PCA);    Timelag1_error_RED=zeros(1,N_PCA);
Timelag2_BLN=zeros(1,N_PCA);    Timelag2_error_BLN=zeros(1,N_PCA);
Timelag2_RED=zeros(1,N_PCA);    Timelag2_error_RED=zeros(1,N_PCA);
QPO_Timelag1=zeros(1,N_PCA);    QPO_Timelag1_error=zeros(1,N_PCA);
QPO_Timelag2=zeros(1,N_PCA);    QPO_Timelag2_error=zeros(1,N_PCA);

Rms_BLN=zeros(1,N_PCA);      Rms_BLN_error=zeros(1,N_PCA);
Rms_RED=zeros(1,N_PCA);      Rms_RED_error=zeros(1,N_PCA);
Rms_QPO=zeros(1,N_PCA);      Rms_QPO_error=zeros(1,N_PCA);
Rms_All=zeros(1,N_PCA);      Rms_All_error=zeros(1,N_PCA);

BLN_Co1=zeros(1,N_PCA);      BLN_Co1_error=zeros(1,N_PCA);
BLN_Co2=zeros(1,N_PCA);      BLN_Co2_error=zeros(1,N_PCA);
RED_Co1=zeros(1,N_PCA);      RED_Co1_error=zeros(1,N_PCA);
RED_Co2=zeros(1,N_PCA);      RED_Co2_error=zeros(1,N_PCA);
QPO_Co1=zeros(1,N_PCA);      QPO_Co1_error=zeros(1,N_PCA);
QPO_Co2=zeros(1,N_PCA);      QPO_Co2_error=zeros(1,N_PCA);
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
    
    [Phaselag1_BLN(i), Phaselag1_error_BLN(i), BLN_Co1(i), BLN_Co1_error(i)] = phaselag(S_PCA{i}, H1_PCA{i}, 0, 0.8);
    [Phaselag1_RED(i), Phaselag1_error_RED(i), RED_Co1(i), RED_Co1_error(i)] = phaselag(S_PCA{i}, H1_PCA{i}, 1, 10);
    [Phaselag2_BLN(i), Phaselag2_error_BLN(i), BLN_Co2(i), BLN_Co2_error(i)] = phaselag(S_PCA{i}, H2_PCA{i},0, 0.8);
    [Phaselag2_RED(i), Phaselag2_error_RED(i), RED_Co2(i), RED_Co2_error(i)] = phaselag(S_PCA{i}, H2_PCA{i}, 1, 10);
    [QPO_Phi1(i), QPO_Phi1_error(i), QPO_Co1(i), QPO_Co1_error(i)] = phaselag(S_PCA{i}, H1_PCA{i}, f_down(i), f_up(i));
    [QPO_Phi2(i), QPO_Phi2_error(i), QPO_Co2(i), QPO_Co2_error(i)] = phaselag(S_PCA{i}, H2_PCA{i}, f_down(i), f_up(i));
    
    Timelag1_BLN(i)=Phaselag1_BLN(i)/(pi*0.83125);    Timelag1_error_BLN(i)=Phaselag1_error_BLN(i)/(pi*0.83125); 
    Timelag1_RED(i)=Phaselag1_RED(i)/(pi*11);            Timelag1_error_RED(i)=Phaselag1_error_RED(i)/(pi*11); 
    Timelag2_BLN(i)=Phaselag2_BLN(i)/(pi*0.83125);       Timelag2_error_BLN(i)=Phaselag2_error_BLN(i)/(pi*0.83125); 
    Timelag2_RED(i)=Phaselag2_RED(i)/(pi*11);            Timelag2_error_RED(i)=Phaselag2_error_RED(i)/(pi*11); 
    QPO_Timelag1(i)=QPO_Phi1(i)/(pi*(f_down(i)+f_up(i)));
    QPO_Timelag1_error(i)=QPO_Phi1_error(i)/(pi*(f_down(i)+f_up(i)));
    QPO_Timelag2(i)=QPO_Phi2(i)/(pi*(f_down(i)+f_up(i)));
    QPO_Timelag2_error(i)=QPO_Phi2_error(i)/(pi*(f_down(i)+f_up(i)));
    
    [Rms_BLN(i), Rms_BLN_error(i)] = Miyamoto(S_PCA{i}, 0, 0.8);
    [Rms_RED(i), Rms_RED_error(i)] = Miyamoto(S_PCA{i}, 1, 10);
    [Rms_QPO(i), Rms_QPO_error(i)] = Miyamoto(S_PCA{i}, f_down(i), f_up(i));
    [Rms_All(i), Rms_All_error(i)] = Miyamoto(S_PCA{i}, 0, 20);
    i
end

HID_result=[Hardness; Hardness_error; Intensity; Intensity_error; Obs_time];
Phaselag_result=[Phaselag1_BLN; Phaselag1_error_BLN; Phaselag1_RED; Phaselag1_error_RED;...
                 Phaselag2_BLN; Phaselag2_error_BLN; Phaselag2_RED; Phaselag2_error_RED;...
                 QPO_Phi1; QPO_Phi1_error; QPO_Phi2; QPO_Phi2_error];
Timelag_result=[Timelag1_BLN; Timelag1_error_BLN; Timelag1_RED; Timelag1_error_RED;...
                Timelag2_BLN; Timelag2_error_BLN; Timelag2_RED; Timelag2_error_RED;...
                QPO_Timelag1; QPO_Timelag1_error; QPO_Timelag2; QPO_Timelag2_error];
Coherence_result=[BLN_Co1; BLN_Co1_error; RED_Co1; RED_Co1_error;...
                  BLN_Co2; BLN_Co2_error; RED_Co2; RED_Co2_error;...
                  QPO_Co1; QPO_Co1_error; QPO_Co2; QPO_Co2_error];

fid=fopen('DQ_HID_result','w');
fprintf(fid,'%5.8f %5.8f %5.8f %5.8f %5.8f\n', HID_result);
fclose(fid);
              
fid=fopen('DQ_Phaselag_result','w');
fprintf(fid,'%5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f\n',...
    Phaselag_result);
fclose(fid);

fid=fopen('DQ_Timelag_result','w');
fprintf(fid,'%5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f\n',...
    Timelag_result);
fclose(fid);

fid=fopen('DQ_Coherence_result','w');
fprintf(fid,'%5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f %5.8f\n',...
    Coherence_result);
fclose(fid);

toc


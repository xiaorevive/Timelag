%%%% load data %%%%
[S, f_QPO, f_left, f_right]=textread('DQPO_lc','%s %f %f %f');
[QPO_Hardness, QPO_Hardness_error, QPO_Intensity, QPO_Intensity_error, ~]=...
    textread('DQ_HID_result','%f %f %f %f %f');
[Phaselag1_BLN, Phaselag1_error_BLN, Phaselag1_RED, Phaselag1_error_RED, Phaselag2_BLN, Phaselag2_error_BLN, ...
    Phaselag2_RED, Phaselag2_error_RED, QPO_Phi1, QPO_Phi1_error, QPO_Phi2, QPO_Phi2_error]=...
    textread('DQ_Phaselag_result','%f %f %f %f %f %f %f %f %f %f %f %f');
[Timelag1_BLN, Timelag1_error_BLN, Timelag1_RED, Timelag1_error_RED, Timelag2_BLN, Timelag2_error_BLN, ...
    Timelag2_RED, Timelag2_error_RED, QPO_Timelag1, QPO_Timelag1_error, QPO_Timelag2, QPO_Timelag2_error]=...
    textread('DQ_Timelag_result','%f %f %f %f %f %f %f %f %f %f %f %f');
[BLN_Co1, BLN_Co1_error, RED_Co1, RED_Co1_error, BLN_Co2, BLN_Co2_error, ...
    RED_Co2, RED_Co2_error, QPO_Co1, QPO_Co1_error, QPO_Co2, QPO_Co2_error]=...
    textread('DQ_Coherence_result','%f %f %f %f %f %f %f %f %f %f %f %f');

%%%%%%%%%%%%%% intensity与QPO Freq  +  Hardness与 QPO Freq   %%%%%%%%%%%%%%%
figure('color','white');
set(gcf,'Units','centimeters','Position',[1 1 16.5 8]);
subplot(1,2,1);
hold on;
plot(f_QPO,QPO_Hardness,'k.','markerfacecolor','k');
plot([f_QPO';f_QPO'],[QPO_Hardness'-QPO_Hardness_error';QPO_Hardness'+QPO_Hardness_error'],'k');
plot([f_left';f_right'],[QPO_Hardness';QPO_Hardness'],'k');
xlim([0 7]);                        % QPO Frequency
ylim([0.2 0.7]);                    % Hardness
set(gca,'Box','on');
set(gca,'Position',[0.1 0.15  0.38  0.83]);
set(gca,'xminortick','on','yminortick','on');
xlabel('QPO Frequency (Hz)','FontSize',12);
ylabel('Hardness Ratio','FontSize',12);
hold off;
subplot(1,2,2);
hold on;
plot(f_QPO,QPO_Intensity,'k.','markerfacecolor','k');
plot([f_QPO';f_QPO'],[QPO_Intensity'-QPO_Intensity_error';QPO_Intensity'+QPO_Intensity_error'],'k');
plot([f_left';f_right'],[QPO_Intensity';QPO_Intensity'],'k');
xlim([0 7]);                         % QPO Frequency
ylim([50 100]);                      % Intensity
set(gca,'Box','on');
set(gca,'Position',[0.6 0.15 0.38 0.83]);
set(gca,'xminortick','on','yminortick','on');
xlabel('QPO Frequency (Hz)','FontSize',12);
ylabel('PCU2 Count Rate','FontSize',12);
hold off;
annotation('textbox',[0.12 0.92 0.05 0.03],'Interpreter','latex',...
    'String',{'(A)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
annotation('textbox',[0.62 0.92 0.05 0.03],'Interpreter','latex',...
    'String',{'(B)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure('color','white');
set(gcf,'Units','centimeters','Position',[1 1 16.5 12.5]);
%%% subpolt 1. %%%%%%%%%%%%%%%%%% Coherence & Intensity 的演化%%%%%%%%%%%%%%
subplot(2,2,1);
hold on
xerrorbarxy(QPO_Intensity, QPO_Intensity_error, QPO_Co1, QPO_Co1_error, '.k');
xerrorbarxy(QPO_Intensity, QPO_Intensity_error, QPO_Co2, QPO_Co2_error, '.b');
ylabel('QPO Coherence','FontSize',12);
xlim([50 100]);                        % Intensity
ylim([0 1]);                           % Coherence
set(gca,'xtick',0:200:1000,'xticklabel','');
set(gca,'xminortick','on','yminortick','on');
set(gca,'Position',[0.1 0.54 0.38 0.44]);
hold off
%%% subpolt 3. %%%%%%%%%%%%%% 作图 Phase lag & Intensity %%%%%%%%%%%%%%%%%%%
subplot(2,2,3);
hold on
xerrorbarxy(QPO_Intensity, QPO_Intensity_error, QPO_Phi1, QPO_Phi1_error, '.k');
xerrorbarxy(QPO_Intensity, QPO_Intensity_error, QPO_Phi2, QPO_Phi2_error, '.b');
set(gca,'Position',[0.1 0.1 0.38 0.44]);
ylabel('QPO Phase Lag (rad)','FontSize',12);
xlabel('PCU2 Count Rate (cts/s)','FontSize',12);
xlim([50 100]);                       % Intensity
ylim([-0.6 0.2]);                        % Phaselag
set(gca,'xtick',50:10:100,'ytick',-0.6:0.2:0);      % ytick decrease
set(gca,'xminortick','on','yminortick','on');
hold off
%%% subpolt 2. %%%%%%%%%%%%%%%%%  作图 Hardness & Coherence   %%%%%%%%%%%%%%
subplot(2,2,2);
hold on
xerrorbarxy(QPO_Hardness, QPO_Hardness_error, QPO_Co1, QPO_Co1_error, '.k');
xerrorbarxy(QPO_Hardness, QPO_Hardness_error, QPO_Co2, QPO_Co2_error, '.b');
ylabel('QPO Coherence','fontsize',12);
xlim([0.2 0.7]);                      % Hardness
ylim([0 1]);                          % Coherence
set(gca,'xtick',0.2:0.1:0.7, 'XTickLabel','');
set(gca,'Position',[0.6 0.54  0.38  0.44]);
set(gca,'xminortick','on','yminortick','on');
hold off
%%% subpolt 4. %%%%%%%%%%%%%%%%%   Hardness  &   Phaselag  %%%%%%%%%%%%%%%%
subplot(2,2,4);
hold on
xerrorbarxy(QPO_Hardness, QPO_Hardness_error, QPO_Phi1, QPO_Phi1_error, '.k');
xerrorbarxy(QPO_Hardness, QPO_Hardness_error, QPO_Phi2, QPO_Phi2_error, '.b');
xlabel('Hardness Ratio','FontSize',12);
ylabel('QPO Phase Lag (rad)','FontSize',12);
xlim([0.2 0.7]);                  % Hardness
ylim([-0.6 0.2]);                    % Phaeslag
set(gca,'Position',[0.6 0.1  0.38  0.44]);
set(gca,'xminortick','on','yminortick','on');
set(gca,'xtick',0.2:0.1:0.7,'ytick',-0.6:0.2:0);    % ytick decrease
hold off

annotation('textbox',[0.12 0.93 0.05 0.03],'Interpreter','latex',...
    'String',{'(A)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
annotation('textbox',[0.62 0.93 0.05 0.03],'Interpreter','latex',...
    'String',{'(C)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
annotation('textbox',[0.12 0.48 0.05 0.03],'Interpreter','latex',...
    'String',{'(B)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
annotation('textbox',[0.62 0.48 0.05 0.03],'Interpreter','latex',...
    'String',{'(D)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');

%%%%%%%%%%%%%%%%%%%%  Phaselag \timelag 与  f_QPO  的关系  %%%%%%%%%%%%%%%%%
figure('color','white');
set(gcf,'Units','centimeters','Position',[1 1 16.5 8]);
subplot(1,2,1);
hold on;
plot(f_QPO,QPO_Phi1,'k.','markerfacecolor','k');
plot([f_QPO';f_QPO'],[QPO_Phi1'-QPO_Phi1_error';QPO_Phi1'+QPO_Phi1_error'],'k');
plot([f_left';f_right'],[QPO_Phi1';QPO_Phi1'],'k');
plot(f_QPO,QPO_Phi2,'b.','markerfacecolor','b');
plot([f_QPO';f_QPO'],[QPO_Phi2'-QPO_Phi2_error';QPO_Phi2'+QPO_Phi2_error'],'b');
plot([f_left';f_right'],[QPO_Phi2';QPO_Phi2'],'b');
ylim([-0.6 0.2]);                  %Phaselag range
xlim([0 7]);                    %QPO Frequency
set(gca,'Box','on');
set(gca,'Position',[0.1 0.15  0.38  0.83]);
set(gca,'xminortick','on','yminortick','on');
set(gca,'xtick',0:1:7,'ytick',-0.6:0.2:0.2);
xlabel('QPO Frequency (Hz)','FontSize',12);
ylabel('Phase Lag (rad)','FontSize',12);
hold off;

subplot(1,2,2);
hold on;
plot(f_QPO,QPO_Timelag1,'k.','markerfacecolor','k');
plot([f_QPO';f_QPO'],[QPO_Timelag1'-QPO_Timelag1_error';QPO_Timelag1'+QPO_Timelag1_error'],'k');
plot([f_left';f_right'],[QPO_Timelag1';QPO_Timelag1'],'k');
plot(f_QPO,QPO_Timelag2,'b.','markerfacecolor','b');
plot([f_QPO';f_QPO'],[QPO_Timelag2'-QPO_Timelag2_error';QPO_Timelag2'+QPO_Timelag2_error'],'b');
plot([f_left';f_right'],[QPO_Timelag2';QPO_Timelag2'],'b');
xlim([0 7]);                    %QPO Frequency
set(gca,'xtick',0:1:7);
set(gca,'Box','on');
set(gca,'Position',[0.6 0.15 0.38 0.83]);
set(gca,'xminortick','on','yminortick','on');
xlabel('QPO Frequency (Hz)','FontSize',12);
ylabel('Time Lag (s)','FontSize',12);
hold off;
annotation('textbox',[0.12 0.92 0.05 0.03],...
    'String',{'(A)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
annotation('textbox',[0.62 0.92 0.05 0.03],...
    'String',{'(B)'},'FontSize',12,...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');



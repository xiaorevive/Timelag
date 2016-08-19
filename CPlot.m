[H, H_e, I, I_e, PB1, PB1_e, PR1, PR1_e, PB2, PB2_e, PR2, PR2_e, RB, RB_e, RR, RR_e, RA, RA_e]...
    =textread('DPhaselag_results_2004','%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
Time_start = load('DMJDtime_2004');                    % length == 272
% Ratio_PB = PB2./PB1;                                 %  no meaning 
% Ratio_PB_error = ((PB2_e.^2)./(PB1.^2)+((PB2.^2).*(PB1_e.^2))./(PB1.^4)).^(1/2);
% Ratio_PR = PR2./PR1;
% Ratio_PR_error = ((PR2_e.^2)./(PR1.^2)+((PR2.^2).*(PR1_e.^2))./(PR1.^4)).^(1/2);
% 

%%%% Fig 1. HID_bin
figure('color','white');
xerrorbarxy(H, H_e, I, I_e,'.r');
set(gca,'yscale','log','xscale','log');
xlabel('Hardness','fontsize',12);
ylabel('PCU2 Count Rate (cts/s)','fontsize',12);
ylim([4 1000]);
set(gca,'fontsize',12);
set(gca,'position',[0.13 0.15 0.84 0.79]);
set(gca,'yscale','log','xscale','log');
set(gca,'xtick',[0.001 0.01 0.1 1],'xticklabel',{'0.001','0.01','0.1','1'});
annotation('textbox',[0.2 0.25  0.3 0.02],...
    'String',{'8.17-14.76~keV~VS~2-6~keV'},'FontSize',12,'interpreter','latex',...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');


% %% Fig 2. Phaselag VS Intensity
figure('color','white');
set(gcf,'Units','centimeters','Position',[10 10 20 18]);
subplot(2,2,1)
xerrorbarxy(PB1, PB1_e, I, I_e, 'b.');
set(gca,'position',[0.1 0.6 0.38 0.38]);
xlabel('Phaselag (rad)','fontsize',12);
ylabel('Intensity (cts/s)','fontsize',12);
legend('BLN (H1 VS Soft)'); 
set(gca,'yscale','log');


subplot(2,2,2)
xerrorbarxy(PR1, PR1_e, I, I_e, 'b.');
set(gca,'position',[0.6 0.6 0.38 0.38]);
xlabel('Phaselag (rad)','fontsize',12);
ylabel('Intensity (cts/s)','fontsize',12);
legend('RED (H1 VS Soft)'); 
set(gca,'yscale','log');


subplot(2,2,3)
xerrorbarxy(PB2, PB2_e, I, I_e, 'r.');
set(gca,'position',[0.1 0.1 0.38 0.38]);
xlabel('Phaselag (rad)','fontsize',12);
ylabel('Intensity (cts/s)','fontsize',12);
legend('BLN (H2 VS Soft)'); 
set(gca,'yscale','log');


subplot(2,2,4)
xerrorbarxy(PR2, PR2_e, I, I_e, 'r.');
set(gca,'position',[0.6 0.1 0.38 0.38]);
xlabel('Phaselag (rad)','fontsize',12);
ylabel('Intensity (cts/s)','fontsize',12);
legend('RED (H2 VS Soft)'); 
set(gca,'yscale','log');


%%% Fig 3. RMS_all VS Intensity & Hardness
figure('color','white');
set(gcf,'Units','centimeters','Position',[10 10 20 18]);
[AX, Hand_1, Hand_2] = plotyy(RA, I, RA, H);
xlabel('RMS Amplitude','fontsize',12);
set(get(AX(1),'ylabel'),'string','Intensity','fontsize',12);
set(get(AX(2),'ylabel'),'string','Hardness','fontsize',12);
set(Hand_1,'marker','s','markerfacecolor','b','linestyle','none');
set(Hand_2,'marker','^','markerfacecolor','g','linestyle','none');
set(gca,'xminortick','on','yminortick','on');
legend({'Intensity (2-20 keV)','Hardness(16-20 keV VS 2-5.7 keV)'});

% %% Fig 4. Hardness VS Phaselag
figure('color','white');
set(gcf,'Units','centimeters','Position',[10 10 20 18]);
subplot(2,2,1)
xerrorbarxy(H, H_e, PB1, PB1_e, 'b.');
set(gca,'position',[0.1 0.6 0.38 0.38]);
ylabel('Phaselag (rad)','fontsize',12);
xlabel('Hardness (cts/s)','fontsize',12);
legend('BLN (H1 VS Soft)'); 
set(gca,'xminortick','on','yminortick','on');
ylim([-0.4 0.4]);

subplot(2,2,2)
xerrorbarxy(H, H_e, PR1, PR1_e, 'b.');
set(gca,'position',[0.6 0.6 0.38 0.38]);
ylabel('Phaselag (rad)','fontsize',12);
xlabel('Hardness (cts/s)','fontsize',12);
legend('RED (H1 VS Soft)'); 
set(gca,'xminortick','on','yminortick','on');
ylim([-0.4 0.4]);


subplot(2,2,3)
xerrorbarxy(H, H_e, PB2, PB2_e, 'r.');
set(gca,'position',[0.1 0.1 0.38 0.38]);
ylabel('Phaselag (rad)','fontsize',12);
xlabel('Hardness (cts/s)','fontsize',12);
legend('BLN (H2 VS Soft)'); 
set(gca,'xminortick','on','yminortick','on');
ylim([-0.4 0.4]);


subplot(2,2,4)
xerrorbarxy(H, H_e, PR2, PR2_e, 'r.');
set(gca,'position',[0.6 0.1 0.38 0.38]);
ylabel('Phaselag (rad)','fontsize',12);
xlabel('Hardness','fontsize',12);
legend('RED (H2 VS Soft)');
set(gca,'xminortick','on','yminortick','on');
ylim([-0.6 0.4]);


% 
% %% Fig 4. Hardness VS Phaselag(BLN, RED)
% figure('color','white')
% xerrorbarxy(H, H_e, PB1, PB1_e,'b.');
% xlabel('Hardness','fontsize',12);
% ylabel('Phase Lag','fontsize',12);
% legend('Outburst 2003');
% 
% %% Fig 5. Intensity VS H2/H1
% figure('color','white')
% xerrorbarxy(I, I_e, Ratio_PB, Ratio_PB_error,'b.');
% ylabel('Hard2/Hard1 Lags Ratio','fontsize',12);
% xlabel('Intensity','fontsize',12);
% legend('Outburst 2003');

% 
% %% Fig 2. Phaselag_BLN VS Obs_number
% figure('color','white')
% plot(PB,'.');
% ylim([-0.4 0.4]);
% xlabel('Obs Number (1~275)','fontsize',12);
% ylabel('Phase Lag (BLN, H1~S)','fontsize',12);
% annotation('textbox',[0.2 0.25  0.3 0.02],...
%     'String',{'5.71-8.17~keV~VS~2-6~keV 0-1~Hz'},'FontSize',12,'interpreter','latex',...
%     'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
% 
% %%% Fig 3. Phaselag_RED VS Obs_number
% figure('color','white')
% plot(PR,'.');
% ylim([-0.4 0.4]);
% xlabel('Obs Number (1~275)','fontsize',12);
% ylabel('Phase Lag (RED, H1~S)','fontsize',12);
% annotation('textbox',[0.2 0.25  0.3 0.02],...
%     'String',{'5.71-8.17~keV~VS~2-6~keV 1-10~Hz'},'FontSize',12,'interpreter','latex',...
%     'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');




% %% Fig 1. All      % no meaning
% figure('color','white');
% set(gcf,'Units','centimeters','Position',[10 10 20 18]);
% subplot(5,1,1)
% xploty(Time_start-52700, I_std, I_std_e, '-k');
% ylabel('Intensity(cts/s)','fontsize' ,12);
% set(gca,'xticklabel','','position',[0.13 0.80 0.84 0.18]);
% set(gca,'xminortick','on','yminortick','on');
% 
% subplot(5,1,2)
% xploty(Time_start-52700, PB1, PB1_e, '-b');
% ylabel({'Phase Lag','(BLN, H1)'},'fontsize' ,12);
% ylim([-0.4 0.4])
% set(gca,'xticklabel','','position',[0.13 0.62 0.84 0.18]);
% set(gca,'xminortick','on','yminortick','on');
% 
% subplot(5,1,3)
% xploty(Time_start-52700, PR1, PR1_e, '-b');
% ylabel({'Phase Lag','(RED, H1)'},'fontsize' ,12);
% set(gca,'xticklabel','','position',[0.13 0.44 0.84 0.18]);
% set(gca,'xminortick','on','yminortick','on');
% ylim([-0.4 0.4])
% 
% subplot(5,1,4)
% xploty(Time_start-52700, PB2, PB2_e, '-r');
% ylabel({'Phase Lag','(BLN, H2)'},'fontsize' ,12);
% set(gca,'xticklabel','','position',[0.13 0.26 0.84 0.18]);
% set(gca,'xminortick','on','yminortick','on');
% ylim([-0.4 0.4])
% 
% subplot(5,1,5)
% xploty(Time_start-52700, PR2, PR2_e, '-r');
% ylabel({'Phase Lag','(RED, H2)'},'fontsize' ,12);
% xlabel('Time (MJD, since-52700)','fontsize',12)
% set(gca,'position',[0.13 0.08 0.84 0.18]);
% set(gca,'xminortick','on','yminortick','on');
% ylim([-0.4 0.4])
% 

% %%% Fig 4. Phaselag_BLN VS Obs_number       % no meaning
% figure('color','white')
% plot(PB2,'.');
% ylim([-0.4 0.6]);
% xlabel('Obs Number (1~275)','fontsize',12);
% ylabel('Phase Lag (BLN, H2~S)','fontsize',12);
% annotation('textbox',[0.2 0.25  0.3 0.02],...
%     'String',{'8.17-14.76~keV~VS~2-6~keV 0-1~Hz'},'FontSize',12,'interpreter','latex',...
%     'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
% 
% %%% Fig 5. Phaselag_RED VS Obs_number
% figure('color','white')
% plot(PR2,'.');
% ylim([-0.4 0.4]);
% xlabel('Obs Number (1~275)','fontsize',12);
% ylabel('Phase Lag (RED, H2~S)','fontsize',12);
% annotation('textbox',[0.2 0.25  0.3 0.02],...
%     'String',{'8.17-14.76~keV~VS~2-6~keV 1-10~Hz'},'FontSize',12,'interpreter','latex',...
%     'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');


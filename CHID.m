[S, HH, Int, MJDtime]=textread('Dlc_HID_QPO','%s %s %s %f');
N_lc=length(S);
Intensity=zeros(1,N_lc);
Intensity_error=zeros(1,N_lc);
Hardness=zeros(1,N_lc);
Hardness_error=zeros(1,N_lc);

for i=1:N_lc
    [Hardness(i),Hardness_error(i),Intensity(i),Intensity_error(i)]=HID3(S{i},HH{i},Int{i});
end

HID_PCU2_results=[Hardness;Hardness_error;Intensity;Intensity_error];
fid=fopen('DHID_PCU2_results_QPO','w');
fprintf(fid,'%5.8f %5.8f %5.8f %5.8f\n',HID_PCU2_results);
fclose(fid);
fid=fopen('DMJDtime_sorted_QPO','w');
fprintf(fid,'%5.8f\n',MJDtime);
fclose(fid);

%%%%%% PLOT
%%%%% HID 
figure('color','white')
set(gcf,'Units','centimeters','Position',[10 10 14 10]);
hold on
xerrorbarxy(Hardness,Hardness_error,Intensity,Intensity_error,':.k');
plot(Hardness,Intensity,'.:k');
xlabel('Hardness','fontsize',12);
ylabel('PCU2 Count Rate (cts/s)','fontsize',12);
xlim([0.1 0.5]);
ylim([500 2500]);
set(gca,'fontsize',12);
set(gca,'position',[0.13 0.15 0.84 0.79]);
set(gca,'xminortick','on','yminortick','on');
annotation('textbox',[0.55 0.88  0.5 0.02],...
    'String',{'HID of QPO Observation','8.2-14.76~keV~VS~2-6~keV'},'FontSize',12,'interpreter','latex',...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');
hold off

%%% Intensity & Hardness VS MJD %%
figure('color','white')
set(gcf,'Units','centimeters','Position',[10 10 14 12]);
subplot(2,1,1)
xploty(MJDtime-51462,Intensity,Intensity_error,'-ob');
ylabel('PCU2 Count Rate (cts/s)','fontsize',12);
set(gca,'xticklabel','');
set(gca,'position',[0.14 0.53 0.82 0.43]);
set(gca,'xminortick','on','yminortick','on');
subplot(2,1,2)
xploty(MJDtime-51462,Hardness,Hardness_error,'-ob');
ylabel('Hardness (H2/S)','fontsize',12);
xlabel('Time (MJD-since 51462)','fontsize',12);
ylim([0.1 0.5])
set(gca,'position',[0.14 0.1 0.82 0.43]);
set(gca,'ytick',0.1:0.1:0.4);
set(gca,'xminortick','on','yminortick','on');
annotation('textbox',[0.6 0.88  0.5 0.02],...
    'String',{'XTE~J1859+226~QPO','Outburst~1999'},'FontSize',12,'interpreter','latex',...
    'FontName','L M Roman Caps10','FitBoxToText','off', 'LineStyle','none');



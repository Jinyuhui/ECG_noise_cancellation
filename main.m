clear;
clc;
close all;
load('ECG_database.mat');

wn=wn./200;WN_data=WN_data./200;
bwn=bwn./200;BWN_data=BWN_data./200;
emn=emn./200;EMN_data=EMN_data./200;
Data1=Data1./200;

%select kind of noise
catagory=2;%1:wn; 2:bwn; 3:emn

if (catagory==1)
    %WN
    xn=wn;
    dn=WN_data;
    %LMS
    fe=max(eig(xn*xn.'));
    mu_LMS=1/fe;
    M_LMS=2;%order of the filter
    [en_LMS,yn_LMS,wn_LMS] = myLMS(dn,xn,mu_LMS,M_LMS);
    %NLMS
    mu_NLMS=2;
    M_NLMS=1;%order of the filter
    [en_NLMS,yn_NLMS,wn_NLMS] = myNLMS(dn,xn,mu_NLMS,M_NLMS,0.07);
    %RLS
    M_RLS=3;%order of the filter
    lamda=0.9999;
    [en_RLS, yn_LMS, wn_RLS] = myRLS(dn,xn,lamda,M_RLS);
elseif (catagory==2)
    %BWN
    xn=bwn;
    dn=BWN_data;
    %LMS
    fe=max(eig(xn*xn.'));
    mu_LMS=2/fe;
    M_LMS=3;%order of the filter
    [en_LMS,yn_LMS,wn_LMS] = myLMS(dn,xn,mu_LMS,M_LMS);
    %NLMS
    mu_NLMS=0.02;
    M_NLMS=1;%order of the filter
    [en_NLMS,yn_NLMS,wn_NLMS] = myNLMS(dn,xn,mu_NLMS,M_LMS,1);
    %RLS
    M_RLS=3;%order of the filter
    lamda=0.99999;
    [en_RLS, yn_LMS, wn_RLS] = myRLS(dn,xn,lamda,M_RLS);
else
    %EMN
    xn=emn;
    dn=EMN_data;
    %LMS
    fe=max(eig(xn*xn.'));
    mu_LMS=20/fe;
    M_LMS=1;%order of the filter
    [en_LMS,yn_LMS,wn_LMS] = myLMS(dn,xn,mu_LMS,M_LMS);
    %NLMS
    mu_NLMS=0.02;
    M_NLMS=1;%order of the filter
    [en_NLMS,yn_NLMS,wn_NLMS] = myNLMS(dn,xn,mu_NLMS,M_NLMS,1);
    %RLS
    M_RLS=3;%order of the filter
    lamda=0.99999;
    [en_RLS, yn_LMS, wn_RLS] = myRLS(dn,xn,lamda,M_RLS);            
end

figure(1)
set(0,'defaultfigurecolor','w');
x=1:1:LENGTH;
subplot(411);plot(dn','b','Linewidth',1.5);axis([0,LENGTH,min(dn)-0.1,max(dn)+0.1]);
title('Corrupted ECG','FontSize',22,'FontWeight','bold');
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);
subplot(412);plot(en_LMS','b','Linewidth',1.5);axis([0,LENGTH,-0.3,0.8]);
title('LMS filter response','FontSize',22,'FontWeight','bold');
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);
subplot(413);plot(en_NLMS','b','Linewidth',1.5);axis([0,LENGTH,-0.3,0.8]);
title('NLMS filter response','FontSize',22,'FontWeight','bold');
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);
subplot(414);plot(en_RLS','b','Linewidth',1.5);axis([0,LENGTH,-0.3,0.8]);
title('RLS filter response','FontSize',22,'FontWeight','bold');
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);

figure(2)
x=1:1:LENGTH;
error1=Data1-en_LMS';
error2=Data1-en_NLMS';
error3=Data1-en_RLS';
if (catagory==1)
    subplot(131);
    plot(x,error1,'m',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-0.02,0.015]);
    title('Error magnitude of LMS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
    subplot(132);
    plot(x,error2,'r',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-0.02,0.015]);
    title('Error magnitude of NLMS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
    subplot(133);
    plot(x,error3,'b',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-0.02,0.015]);
    title('Error magnitude of RLS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
elseif (catagory==2)
    subplot(131);
    plot(x,error1,'m',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-1,1.5]);
    title('Error magnitude of LMS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
    subplot(132);
    plot(x,error2,'r',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-1,1.5]);
    title('Error magnitude of NLMS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
    subplot(133);
    plot(x,error3,'b',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-1,1.5]);
    title('Error magnitude of RLS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
else
    subplot(131);
    plot(x,error1,'m',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-2,2]);
    title('Error magnitude of LMS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
    subplot(132);
    plot(x,error2,'r',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-2,2]);
    title('Error magnitude of NLMS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
    subplot(133);
    plot(x,error3,'b',x,zeros(1,5000),'g','Linewidth',2);grid;axis([0,5000,-2,2]);
    title('Error magnitude of RLS','FontSize',22,'FontWeight','bold');
    xlabel('sample(n)','FontSize',18,'FontWeight','bold');
    ylabel('Error magnitude','FontSize',18,'FontWeight','bold');
    set(gca,'linewidth',2);
end

%SNR
snr_data=zeros(1,4);
snr_data(1)=snr(Data1,Data1-dn);
snr_data(2)=snr(Data1,Data1-en_LMS');
snr_data(3)=snr(Data1,Data1-en_NLMS');
snr_data(4)=snr(Data1,Data1-en_RLS');

snr_ORG=20*log10(abs(Data1)./abs(Data1-dn));
snr_LMS=20*log10(abs(Data1)./abs(Data1-en_LMS'));
snr_NLMS=20*log10(abs(Data1)./abs(Data1-en_NLMS'));
snr_RLS=20*log10(abs(Data1)./abs(Data1-en_RLS'));

snr_stable_data=zeros(1,4);
Data1_1=Data1(4001:5000);
dn_1=dn(4001:5000);
en_LMS_1=en_LMS(4001:5000)';
en_NLMS_1=en_NLMS(4001:5000)';
en_RLS_1=en_RLS(4001:5000)';
snr_stable_data(1)=snr(Data1_1,Data1_1-dn_1);
snr_stable_data(2)=snr(Data1_1,Data1_1-en_LMS_1);
snr_stable_data(3)=snr(Data1_1,Data1_1-en_NLMS_1);
snr_stable_data(4)=snr(Data1_1,Data1_1-en_RLS_1);

%MSE
MSE_LMS=(Data1-en_LMS').*(Data1-en_LMS');
MSE_NLMS=(Data1-en_NLMS').*(Data1-en_NLMS');
MSE_RLS=(Data1-en_RLS').*(Data1-en_RLS');
MSE_ORG=(Data1-dn).*(Data1-dn);

MSE_data=zeros(1,4);
MSE_data(1)=sum(MSE_ORG)/LENGTH;
MSE_data(2)=sum(MSE_LMS)/LENGTH;
MSE_data(3)=sum(MSE_NLMS)/LENGTH;
MSE_data(4)=sum(MSE_RLS)/LENGTH;
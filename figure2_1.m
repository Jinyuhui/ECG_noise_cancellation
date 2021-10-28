figure(1);
subplot(311);plot(WN_data,'b','Linewidth',1.5);axis([0,LENGTH,min(WN_data),max(WN_data)]);
title('ECG corrupted by WN','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);
subplot(312);plot(BWN_data,'b','Linewidth',1.5);axis([0,LENGTH,min(BWN_data),max(BWN_data)]);
title('ECG corrupted by BWN','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);
subplot(313);plot(EMN_data,'b','Linewidth',1.5);axis([0,LENGTH,min(EMN_data),max(EMN_data)]);
title('ECG corrupted by EMN','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2);
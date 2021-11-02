figure(1);
subplot(311);plot(wn,'b','Linewidth',1.5);axis([0,LENGTH,min(wn)-0.005,max(wn)+0.005]);
title('Reference signal of WN','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2,'FontSize',16);
subplot(312);plot(bwn,'b','Linewidth',1.5);axis([0,LENGTH,min(bwn)-0.005,max(bwn)+0.005]);
title('Reference signal of BWN','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2,'FontSize',16);
subplot(313);plot(emn,'b','Linewidth',1.5);axis([0,LENGTH,min(emn)-0.005,max(emn)+0.005]);
title('Reference signal of EMN','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2,'FontSize',16);
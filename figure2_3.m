figure(1);
plot(Data1,'b','Linewidth',1.5);axis([0,LENGTH,min(Data1)-0.005,max(Data1)+0.005]);
title('Desired ECG signal','FontSize',22,'FontWeight','bold')
xlabel('sample(n)','FontSize',18,'FontWeight','bold');
ylabel('Amplitude(mV)','FontSize',18,'FontWeight','bold');
set(gca,'linewidth',2,'FontSize',16);
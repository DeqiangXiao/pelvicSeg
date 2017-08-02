%draw diagrams
clear all;
load('ResUnet_Train.mat','loss');
ResUnet_Train=loss;
load('ResUnet_Test.mat','loss');
ResUnet_Test=loss;
load('FCN_Train.mat','loss');
FCN_Train=loss;
load('FCN_Test.mat','loss');
FCN_Test=loss;
load('Unet_Train.mat','loss');
Unet_Train=loss;
load('Unet_Test.mat','loss');
Unet_Test=loss;
load('Unet_deeper_Train.mat','loss');
Unet_deeper_Train=loss;
load('Unet_deeper_Test.mat','loss');
Unet_deeper_Test=loss;

ind=[1:100];
xind=(ind-1);

lw=1;
%legend show
h7=plot(xind,FCN_Train(ind),'k','LineWidth',lw);
set(h7,'DisplayName','FCN(Train)');
%legend show
hold on;
h8=plot(xind,FCN_Test(ind),'--k','LineWidth',lw);
set(h8,'DisplayName','FCN(Test)');
hold on;
h3=plot(xind,Unet_Train(ind),'r','LineWidth',lw);
set(h3,'DisplayName','Unet(Train)');
%legend show
hold on;
h4=plot(xind,Unet_Test(ind),'--r','LineWidth',lw);
set(h4,'DisplayName','Unet(Test)');
hold on;
h5=plot(xind,Unet_deeper_Train(ind),'g','LineWidth',lw);
set(h5,'DisplayName','DeeperUnet(Train)');
%legend show
hold on;
h6=plot(xind,Unet_deeper_Test(ind),'--g','LineWidth',lw);
set(h6,'DisplayName','DeeperUnet(Test)');
hold on;
%legend show
h1=plot(xind,ResUnet_Train(ind),'b','LineWidth',lw);
set(h1,'DisplayName','ResUnet(Train)');
%legend show
%axis([0 150 0 0.6])
axis([0 100 0 1.5])
hold on;
h2=plot(xind,ResUnet_Test(ind),'--b','LineWidth',lw);
set(h2,'DisplayName','ResUnet(Test)');
legend show
xlabel('Number of Iterations (*1e-3)','LineWidth',lw) % x-axis label
ylabel('Loss') % y-axis label
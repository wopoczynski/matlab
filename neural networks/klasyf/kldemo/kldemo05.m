clear
close all

p=[0 1 1 0 .5
   1 0 1 0 .5]
t=[1 0 0 0 0
   0 1 0 0 0
   0 0 1 0 0
   0 0 0 1 0
   0 0 0 0 1]
figure(1); show_trainset(p,t,[-0.5 1.5],[-0.5 1.5]);
disp('Pause...'); pause
net=newff([-0.5 1.5 ; -0.5 1.5],[8 5],{'tansig','logsig'},'trainlm');
net=train(net,p,t);
y=sim(net,p)
figure(1); show_regions(net,p,t,[-0.5 1.5],[-0.5 1.5]);

clear
close all

p=[0 1 1 0
   1 0 1 0]
t=[1 1 0 0]
figure(1); show_trainset(p,t,[-0.5 1.5],[-0.5 1.5]);
disp('Pause...'); pause
net=newp([-0.5 1.5 ; -0.5 1.5],[1]);
net=train(net,p,t);
y=sim(net,p)
figure(1); show_regions(net,p,t,[-0.5 1.5],[-0.5 1.5]);
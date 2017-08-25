clear
close all


p=[rand(2,10),rand(2,10)-1]
t=[ones(1,10),zeros(1,10)]
figure(1); show_trainset(p,t,[-1.5 1.5],[-1.5 1.5]);
disp('Pause...'); pause
net=newp([-1.5 1.5 ; -1.5 1.5],[1]);
net=train(net,p,t);
y=sim(net,p)
figure(1); show_regions(net,p,t,[-1.5 1.5],[-1.5 1.5]);
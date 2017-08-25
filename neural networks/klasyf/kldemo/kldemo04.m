clear
close all

L=20;
r=0:(2*pi)/L:(2*pi)*((L-1)/L);
p1(1,1:L)=sin(r); p1(2,1:L)=cos(r);
p2(1,1:L)=2*sin(r); p2(2,1:L)=2*cos(r);
p=[p1,p2]
t=[ones(1,L),zeros(1,L)]
figure(1); show_trainset(p,t,[-3 3],[-3 3]);
disp('Pause...'); pause
net=newff([-0.5 1.5 ; -0.5 1.5],[8  1],{'tansig','logsig'},'trainlm');
net=train(net,p,t);
y=sim(net,p)
figure(1); show_regions(net,p,t,[-3 3],[-3 3]);
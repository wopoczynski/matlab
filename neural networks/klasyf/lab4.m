
clear
close all
p=[tan(rand(2,20)),tan(rand(2,20)-1)];
t=[ones(1,20),zeros(1,20)];
figure(1); show_trainset(p,t,[-3 3],[-3 3]);
net=newp([2 2 ; 2 2],[1]);
net=train(net,p,t);
y=sim(net,p);
figure(1); show_regions(net,p,t,[-3 3],[-3 3]);
%%
clear
close all

p=[0 1 1 0 2 -1 -1 2
   1 0 1 0 2 0 2 0]
t=[1 1 1 1 0 0 0 0]
figure(1); show_trainset(p,t,[-3 3],[-3 3]);
net=newp([-3 3 ; -3 3],[1]);
net=train(net,p,t);
y=sim(net,p)
figure(1); show_regions(net,p,t,[-3 3],[-3 3]);
%%
clear
close all
p1=[rand(2,4),rand(2,4)-1];
p2=[rand(2,4),rand(2,4)-1];
p=[p1,p2];
t1=[1 1 1 1
    0 0 0 0
    0 0 0 0
    0 0 0 0];
t2=[0 0 0 0
    1 1 1 1
    0 0 0 0
    0 0 0 0];
t3=[0 0 0 0
    0 0 0 0
    0 0 0 0
    1 1 1 1];
t4=[0 0 0 0
    0 0 0 0
    1 1 1 1
    0 0 0 0];
t=[t1 t2 t3 t4];
figure(1); show_trainset(p,t,[-2 2],[-2 2]);
net=newff([-2 2 ; -2 2],[8 5],{'tansig','logsig'},'trainlm');
net=train(net,p,t);
y=sim(net,p)
figure(1); show_regions(net,p,t,[-0.5 1.5],[-0.5 1.5]);


%%

N=[8]
p1=randn(2,N)+0.5
p2=randn(2,N)-0.5

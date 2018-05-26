% dynamicrob.m
% This function compute for the dynamics of the robot

function [M,V,G]=dynamicrob(rob)
l1 = 10; % [mm]
l2 = 5; % [mm]

mr1=1;
mr2=1;

m1=2;
m2=3;

M1=mr1+m1;
M2=mr2+m2;

m=[M1;M2];

Pc{1}=[l1/2;0;0];
Pc{2}=[l2/2;0;0];

Ic{1}=[0,0,0;0,0,0;0,0,(mr1*(l1^2)/12)+m1*((l1/2)^2)];
Ic{2}=[0,0,0;0,0,0;0,0,(mr2*(l2^2)/12)+m2*((l2/2)^2)];

syms q1 q2 qd1 qd2 qdd1 qdd2 g
Q=[q1;q2];
Qd=[qd1;qd2];
Qdd=[qdd1;qdd2];

[~,Ti] = robFK(Q, rob);

g0=[0;0;-g];

u_ref=0;

% calculate tau
[tau, ~, ~, ~, ~, ~]=dynamics_lagrangian(m,Pc,Ic,Ti,Q,Qd,Qdd,g0,u_ref);

% get M, V, G
[M,V,G] = separate_mvg(tau,[qdd1;qdd2],g);
M=vpa(M,5);
V=vpa(V,5);
G=vpa(G,5);

end

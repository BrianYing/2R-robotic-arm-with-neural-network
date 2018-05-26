% createflower.m
% This function create the trajectory for the rob to draw
% Can be changed for other trajectories

function [trajectory,n]=createflower(rob,data)

thetat=0:pi/1000:2*pi;
p=sin(4*thetat);

[x,y] = pol2cart(thetat,p);

x=x+8*ones(1,length(x));
y=y+10*ones(1,length(y));

% desired position of end effector in cartisian space
p(1,:)=x;
p(2,:)=y;


% from home to origin of the flower
tf_hs=5;
dt_hs=0.01;
t_hs=0:dt_hs:tf_hs;
n_hs=length(t_hs);


% from origin of the flower to finish point of the flower
n_sf=length(x);
tf_sf=25;
dt_sf=20/n_sf;
t_sf=t_hs(n_hs):dt_sf:tf_sf;

t=[t_hs(1:n_hs-1),t_sf];

% initial joint position and angular velocity
w(:,1)=[0;0];

% direction from home to start position
dp=p(:,1)-[5;10];

h(:,1)=[5;10];

%============ Joint Angles ============%
[ ~, theta(:,1) ] = robIK(h(:,1),rob,data);
% joint angles from home to start position
for i=1:n_hs
    h(:,i+1)=h(:,i)+dp*(1/n_hs);
    [ ~, theta(:,i+1) ] = robIK(h(:,i+1),rob,data);
    w(:,i+1)=(theta(:,i+1)-theta(:,i))/dt_hs;
end

% joint angles from start to finished position
for i=1:n_sf-1 
    [ ~, theta(:,i+n_hs+1) ] = robIK(p(:,i+1),rob,data);

    w(:,i+n_hs+1)=(theta(:,i+n_hs+1)-theta(:,i+n_hs))/dt_sf;
end

trajectory(1,:) = t; %Time
trajectory(2:3,:) = theta; %Joint angles
trajectory(4:5,:) = w; %Joint velocities

n=length(w);

end
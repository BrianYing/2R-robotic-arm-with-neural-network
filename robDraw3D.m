% robDraw3D.m

function robDraw3D
%{    
Plot a graphical representation of the robot as it moves through a
series of poses defined by trajectory.
%}    

% Initialize the fanuc struct
rob = robInit();

% Draw initially in zero position
prev_angles = [5,10];
rob.handles = drawrob(prev_angles,rob);
hold on;
 
% load data for use
data = load('data.mat');

% create trajectory (can be changed for different trajectories)
[trajectory,n]=createflower(rob,data.data);

dt=trajectory(1,2)-trajectory(1,1);
 
a(:,1)=[0;0];
w(:,1)=[0;0];
theta(:,1)=trajectory(2:3,1);

% PD control gain
kp = 20000;
kv = 6000;

for i=1:n-1  
    % compute for dynamics
    M=[200*cos(theta(2,i))+579.17,100*cos(theta(2,i))+45.83;...
       100*cos(theta(2,i))+45.83,45.83];
    V=[-w(2,i)*sin(theta(2,i))*(200*theta(1,i)+100*w(2,i));...
       100*(theta(1,i)^2)*sin(theta(2,i))];
    G=[0;0];     
    
    % theta
    Theta_ref = trajectory(2:3,i+1);
    Theta_dot_ref = trajectory(4:5,i+1);
    
    % PD control law 
    Tau=-kp*(theta(:,i)-Theta_ref)-kv*(w(:,i)-Theta_dot_ref);
    
    % numerical integration
    a(:,i+1)= inv(M) * (Tau - V - G);
    w(:,i+1)=w(:,i)+0.5*(a(:,i)+a(:,i+1))*dt;
     
    theta(:,i+1)=theta(:,i)+0.5*(w(:,i)+w(:,i+1))*dt;
 
    % Move robot using setFanuc() if solution exists
    setrob(theta(:,i+1)',rob)  
    
    % plot the actual place using FK
    [T1,~] = robFK(theta(:,i+1)',rob);
    P1 = T1(1:3,4);
    plot3(P1(1),P1(2),P1(3),'.','Color','b')

end
end


% realposition.m


function realposition(rob,data)

[trajectory,n]=createflower(rob,data);
dt=trajectory(1,2)-trajectory(1,1);

a(:,1)=[0;0];
w(:,1)=[0;0];
theta(:,1)=[0;0];

for i=1:n   
    M=[200*cos(theta(2,i))+579.17,100*cos(theta(2,i))+45.83;...
       100*cos(theta(2,i))+45.83,45.83];

    V=[-w(2,i)*sin(theta(2,i))*(200*theta(1,i)+100*w(2,i));...
        100*(theta(1,i)^2)*sin(theta(2,i))];

    G=[0;0];
    
    
    Theta_ref = trajectory(2:3,i);
    Theta_dot_ref = trajectory(4:5,i);
    
    Tau=-kp*(theta(:,i)-Theta_ref)-kv*(w(:,i)-Theta_dot_ref);


    a(:,i+1)=vpa( inv(M) * (Tau' - V - G) ,4);
    
    w(:,i+1)=w(:,i)+0.5*(a(:,i)+a(:,i+1))*dt;
    
    theta(:,i+1)=theta(:,i)+0.5*(w(:,i)+w(:,i+1))*dt;

end
end
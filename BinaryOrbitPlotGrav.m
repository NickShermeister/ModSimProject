%Plotting A Binary Star System

function res = BinaryOrbitPlot(~)
clf;

state = [0, 0, .879e4, .879e4, 0, 3.2912e10, -2.99e4, -2.99e4];    %Intial state of stars (m,m,m/s,m/s)
tF = 20e6;                   %End time of simulation (s)

[T, S] = ode45(@BinaryOrbitFlows, [0,tF], state);

xA = S(:,1);         %x positions A
yA = S(:,2);         %y positions A
vxA = S(:,3);        %x velocities A
vyA = S(:,4);        %y velocities A
xB = S(:,5);         %x positions B
yB = S(:,6);         %y positions B
vxB = S(:,7);        %x velocities B
vyB = S(:,8);        %y velocities B

hold on
comet(xA, yA)
comet(xB, yB)
xlabel('x (m)')
ylabel('y (m)')
title('Binary Stars')

end

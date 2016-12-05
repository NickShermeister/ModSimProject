function gravassistrunner()
clf;
hold on;
%xlim([-1000 1000]);

states = [50000000000, 10000000000, -30000, -25000];        %x, y, vx, vy
time = 100000000;


[T,S] = ode45(@gravassist2, [0 time], states);

plot(0, 0, 'rx');

x = S(:,1);
y = S(:,2);
vx = S(:,3);
vy = S(:,4);

comet(x,y);
xlabel('x');
ylabel('y');
title('The Failed Gravitational Experiment');


end
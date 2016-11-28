function res = gravassist2(~, states)


mA = .6897;         %Mass of Keplar-16A (Solar Masses)
mB = .20255;        %Mass of Keplar-16B (Solar Masses)
SM = 1.99*10^30;     %Solar Mass
G = 6.67408 * 10^-11;         %Gravitation Constant (m3 kg-1 s-2)
mtwo = 2*10^6;      %mass of spaceship
mone = SM*mA;
sunloc = [0, 0];


x = states(1);
y = states(2);
vx = states(3)
vy = states(4)

R = sunloc - [x,y];
r = norm(R);
Rhat = R/r;

r = sqrt((sunloc(2)-y)^2 + (sunloc(1)-x)^2);

Fg = G*mone*mtwo/r^2*Rhat;
Fx = Fg(1)/mtwo;
Fy = Fg(2)/mtwo;

dxdt = vx;
dydt = vy;
dvxdt = Fx;
dvydt = Fy;

res = [dxdt; dydt; dvxdt; dvydt];

end
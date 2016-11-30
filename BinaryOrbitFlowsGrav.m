%Plotting a Binary Star System
%Physics links:
%http://hyperphysics.phy-astr.gsu.edu/hbase/orbv.html#bo
%https://en.wikipedia.org/wiki/Kepler-16
%https://en.wikipedia.org/wiki/Binary_star
function res = BinaryOrbitFlows(~, state)

%Variables
mA = .6897*1.98855e30;         %Mass of Keplar-16A (Solar Masses to kg)
mB = .20255*1.98855e30;        %Mass of Keplar-16B (Solar Masses to kg)
mS = 2*10^6;                   %Mass of spaceship
rA = 451439.73*1000;           %Orbit Radius of Keplar-16A (km to m)
rB = 157388.211*1000;          %Orbit Radius of Keplar-16B (km to m)
a = 3.2912e7;                  %Distance between stars (.22AU to km)
G = 6.67408 * 10^-11;          %Gravitation Constant (Nm^2/kg^2)

%State Variables
xA = state(1);       %x position A (m)
yA = state(2);       %y position A (m)
vxA = state(3);      %x velocity A (m/s)
vyA = state(4);      %y velocity A (m/s)
xB = state(5);       %x position B (m)
yB = state(6);       %y position B (m)
vxB = state(7);      %x velocity B (m/s)
vyB = state(8);      %y velocity B (m/s)
xS = state(9);       %x position S (m)
yS = state(10);      %y position S (m)
vxS = state(11);     %x velocity S (m)
vyS = state(12);     %y velosity S (m)

%Directions
PA = [xA, yA];
PB = [xB, yB];
PS = [xS, yS];
R = PB - PA;
RAS = PS - PA;
RBS = PS - PB;
r = norm(R);
ras = norm(RAS);
rbs = norm(RBS);
Rhat = R / r;
Rhatas = RAS / ras;
Rhatbs = RBS / rbs;

%Forces
%Fg = G*(m1*m2/r^2)
Fg = (G.*(mA.*mB./r.^2)) .* Rhat;        %Force of gravity(kgm/s^2)
Fgsa = G*mS*mA/ras^2 .* Rhatas;     %Force of A on S
Fgsb = G*mS*mB/rbs^2 .* Rhatbs;     %Force of B on S
Fts = Fgsa + Fgsb;                       %Total force on S

%'Flows'
dxAdt = vxA;      %Rate of change of x position A
dyAdt = vyA;      %Rate of change of y position A
dvxAdt = Fg(1)./mA; %Rate of change of x velocity A
dvyAdt = Fg(2)./mA; %Rate of change of y velocity A
dxBdt = vxB;      %Rate of change of x position B
dyBdt = vyB;      %Rate of change of y position B
dvxBdt = -Fg(1)./mB; %Rate of change of x velocity B
dvyBdt = -Fg(2)./mB; %Rate of change of y velocity B
dxSdt = vxS;      %Rate of change of x position S
dySdt = vyS;      %Rate of change of y position S
dvxSdt = -Fts(1)./mS %Rate of change of x velocity S
dvySdt = -Fts(2)./mS %Rate of change of y velocity S


res = [dxAdt; dyAdt; dvxAdt; dvyAdt; dxBdt; dyBdt; dvxBdt; dvyBdt; dxSdt; dySdt; dvxSdt; dvySdt];
end

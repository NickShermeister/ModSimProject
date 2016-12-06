%Plotting A Binary Star System
%He survives rn but we need to determine how fast he should be going
%  USE ISDEAD IN ORDER TO DETERMINE IF CRASHED INTO STAR!
function res = BinaryOrbitPlotGrav(r, v, thetad)
clf;
xstart = r*cosd(thetad);
ystart = r*sind(thetad);
xv = -v*cosd(thetad);
yv = -v*sind(thetad);
state = [2.25e9, -4e9, .879e4, .879e4, 2.25e9, 2.8912e10, -2.99e4, -2.99e4, -5e10/sqrt(2), 5e10/sqrt(2), 80000, -80000, 0];    %Intial state of stars (m,m,m/s,m/s)
tF = 1e7;                   %End time of simulation (s)
state(9) = xstart;
state(10) = ystart;
state(11) = xv;
state(12) = yv;
isdead = -10;
crashship = -1;

options = odeset('Events', @events, 'RelTol', 1e-3); 

[T, S] = ode45(@BinaryOrbitFlowsGrav, [0, tF], state, options);     %add ,1000???


% xA = S(:,1);         %x positions A
% yA = S(:,2);         %y positions A
% vxA = S(:,3);        %x velocities A
% vyA = S(:,4);        %y velocities A
% xB = S(:,5);         %x positions B
% yB = S(:,6);         %y positions B
% vxB = S(:,7);        %x velocities B
% vyB = S(:,8);        %y velocities B
xS = S(:,9);         %x positions S
yS = S(:,10);         %y positions S
vxS = S(:,11);        %x velocities S
vyS = S(:,12);        %y velocities S
Af = S(:,13);         %A veloities

if (Af(end)>=50)
    fprintf('Hes dead, Jim.');
    Af(end)
    isdead = 1;
end


hold on
% comet(xA, yA)
% comet(xB, yB)
% comet(xS, yS)
% xlabel('x (m)')
% ylabel('y (m)')
% title('Binary Stars')
% animate_func(T,S);

function animate_func(T,S)
        
        X1 = S(:,1);
        Y1 = S(:,2);
        X2 = S(:,5);
        Y2 = S(:,6);
        X3 = S(:,9);
        Y3 = S(:,10);
        minmax = [min([X1;X2;X3]), max([X1;X2;X3]), min([Y1;Y2;Y3]), max([Y1;Y2;Y3])];
        for i=1:2500:length(T)
            clf;
            hold on;
            axis(minmax);
            draw_func(X1(i), Y1(i), X2(i), Y2(i), X3(i), Y3(i));
            drawnow;
            if i < length(T)
                dt = T(i+1) - T(i);
                speedup = 10000000000;
                pause(dt/speedup);
            end
        end
        hold off
end
    
    function draw_func(x1, y1, x2, y2, x3, y3)
        plot(x1, y1, 'r.', 'MarkerSize', 50);
        plot(x2, y2, 'b.', 'MarkerSize', 20);
        plot(x3, y3, 'g.', 'MarkerSize', 10);
    end
vf = sqrt(vxS(end)^2 + vyS(end)^2);
thetaxy = atand(yS(end)/xS(end));
thetav = atand(vyS(end)/vxS(end));

if(vxS(end) < 0 && vyS(end) > 0)
   thetav = pi-thetav;
end
if (vxS(end) < 0 && vyS(end) < 0)
   thetav = pi+thetav;
end

if(xS(end) < 0 && yS(end) > 0)
   thetaxy = pi-thetaxy;
end
if (xS(end) < 0 && yS(end) < 0)
   thetaxy = pi+thetaxy;
end
%theta = theta*100;
%xS(end)
%yS(end)

res = [vf, thetaxy, thetav, isdead, crashship];


    function [value,isterminal,direction] = events(~,h)
        xA = h(1);
        yA = h(2);
        xB = h(5);
        yB = h(6);
        a = h(13);
        x = h(9);
        y = h(10);
        hi = 1;
        if((sqrt((xA-x)^2+(yA-y)^2) <= 300000) | (sqrt((xB-x)^2+(yB-y)^2) <= 300000))
            hi = 0;
            crashship = 1;
            isdead = 1;
        end
        value = [60-a; 5e10-sqrt(x^2+y^2); hi]; 
        isterminal = [1;1;1]; % Stop the integration if a crosses zero.
        direction = [-1;-1;0]; % But only if the height is decreasing.
    end


end

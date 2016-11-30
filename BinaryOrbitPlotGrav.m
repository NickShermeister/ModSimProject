%Plotting A Binary Star System

function res = BinaryOrbitPlotGrav(~)
clf;

state = [0, 0, .879e4, .879e4, 0, 3.2912e10, -2.99e4, -2.99e4, 50000000000, 50000000000, -110000, -90000];    %Intial state of stars (m,m,m/s,m/s)
tF = 1e6;                   %End time of simulation (s)

[T, S] = ode45(@BinaryOrbitFlowsGrav, [0,tF], state);

xA = S(:,1);         %x positions A
yA = S(:,2);         %y positions A
vxA = S(:,3);        %x velocities A
vyA = S(:,4);        %y velocities A
xB = S(:,5);         %x positions B
yB = S(:,6);         %y positions B
vxB = S(:,7);        %x velocities B
vyB = S(:,8);        %y velocities B
xS = S(:,9);         %x positions S
yS = S(:,10);         %y positions S
vxS = S(:,11);        %x velocities S
vyS = S(:,12);        %y velocities S

hold on
% comet(xA, yA)
% comet(xB, yB)
% comet(xS, yS)
 xlabel('x (m)')
 ylabel('y (m)')
 title('Binary Stars')
 animate_func(T,S);

    function animate_func(T,S)
        
        X1 = S(:,1);
        Y1 = S(:,2);
        X2 = S(:,5);
        Y2 = S(:,6);
        X3 = S(:,9);
        Y3 = S(:,10);
        minmax = [min([X1;X2;X3]), max([X1;X2;X3]), min([Y1;Y2;Y3]), max([Y1;Y2;Y3])];
        for i=1:length(T)
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

end

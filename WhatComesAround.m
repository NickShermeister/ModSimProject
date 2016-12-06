function WhatComesAround()

r = 5e10; %r in m
speeds = 90000:1000:110000;
angles = 0:1:360;


numSpeeds = length(speeds);
numAngles = length(angles);
vf = zeros(numSpeeds, numAngles);
thetaxy = zeros(numSpeeds, numAngles);
thetav = zeros(numSpeeds, numAngles);
isdead = zeros(numSpeeds, numAngles);
crash = zeros(numSpeeds, numAngles);

for row = 1:numSpeeds
    for col = 1:numAngles-1
        temp = BinaryOrbitPlotGrav(r, speeds(row), angles(col));
        vf(row, col) = temp(1);
        thetaxy(row, col) = temp(2);
        thetav(row, col) = temp(3);
        isdead(row, col) = temp(4);
        crash(row, col) = temp(5);
%         if(isdead(row,col)==1)
%            vf(row, col) = NaN; 
%         end
    end
end

 csvwrite('velocityfinalFINAL.csv',vf);
 csvwrite('thetaxysFINAL.csv',thetaxy);
 csvwrite('thetavsFINAL.csv', thetav);
 csvwrite('isdeadsFINAL.csv',isdead);
 csvwrite('crashesFINAL.csv',isdead);

pcolor(angles, speeds, vf)
shading interp
colorbar

hold on

 xlabel('Angle (degrees)');
 ylabel('Speed (m/s)');
 title('Just some code. Move along.');



end
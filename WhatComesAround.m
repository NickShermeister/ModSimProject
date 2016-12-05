function WhatComesAround()

r = 5e10; %r in m
speeds = 90000:1000:120000;
angles = 0:15:360;


numSpeeds = length(speeds);
numAngles = length(angles);
vf = zeros(numSpeeds, numAngles);
theta = zeros(numSpeeds, numAngles);
isdead = zeros(numSpeeds, numAngles);

for row = 1:numSpeeds
    for col = 1:numAngles-1
        temp = BinaryOrbitPlotGrav(r, speeds(row), angles(col));
        vf(row, col) = temp(1);
        theta(row, col) = temp(2);
        isdead(row, col) = temp(3);
        if(isdead(row,col)==1)
           vf(row, col) = -1; 
        end
    end
end

csvwrite('velocityfinal15d.csv',vf);
csvwrite('thetas15d.csv',theta);
csvwrite('isdeads15d.csv',isdead);

pcolor(angles, speeds, vf)
shading interp
colorbar

hold on

 xlabel('Angle (degrees)');
 ylabel('Speed (m/s)');
 title('Just some code. Move along.');



end
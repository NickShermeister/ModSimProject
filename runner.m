speeds = 90000:1000:120000;
angles = 0:15:360;
numSpeeds = length(speeds);
numAngles = length(angles);
checkers = isdeads15d;
checkers2 = velocityfinal15d;
for row = 1:numSpeeds
    for col = 1:numAngles-1
        if(checkers(row,col)==1)
           checkers2(row, col) = NaN; 
        end
    end
end

pcolor(angles, speeds, checkers2)
shading interp
colorbar

hold on

 xlabel('Angle (degrees)');
 ylabel('Speed (m/s)');
 title('Just some code. Move along.');
function [ outputPoints ] = CubePointsGenerator( numberOfPointsEachLine )

u=linspace(0,1,numberOfPointsEachLine);
v=linspace(0,1,numberOfPointsEachLine);
w=[0 1];

[U,V,W] = ndgrid(u,v,w);
uvw = [U(:),V(:),W(:)];
uvw = cat(1,uvw(:,[1 2 3]),uvw(:,[2 3 1]),uvw(:,[3 1 2]));
outputPoints = unique(uvw,'rows')';
outputPoints=[outputPoints;ones(1,size(outputPoints,2))];

end


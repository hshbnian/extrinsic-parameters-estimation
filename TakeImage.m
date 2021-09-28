function [ outputPoints ] = TakeImage(inputPoints, Lambda, Omega, Tau, removeLambda)

Rotation=[Omega,Tau;[0 0 0 1]];
outputPoints= Lambda * Rotation * inputPoints;

if removeLambda==true
    outputPoints=outputPoints./(repmat(outputPoints(3,:),[3,1]));
end

end


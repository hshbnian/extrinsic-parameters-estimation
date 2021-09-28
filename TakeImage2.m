function [ outImage ] = TakeImage2( inputPoints, rotationMatrix )
% Get the image (implement by details. my implementation of equation 14.8 from book
t1=phiX*(R(1,1)*InputPoints(1,:) + R(1,2)*InputPoints(2,:) + R(1,3)*InputPoints(3,:) + Tau(1));
t2=(R(2,1)*InputPoints(1,:) + R(2,2)*InputPoints(2,:) + R(2,3)*InputPoints(3,:) + Tau(2));
t3=R(3,1)*InputPoints(1,:) + R(3,2)*InputPoints(2,:) + R(3,3)*InputPoints(3,:) + Tau(3);

OutData3=zeros(2,size(InputPoints,2));
OutData3(1,:)=((t1+ (gamma*t2))./t3)+deltaX;
OutData3(2,:)=((phiY*t2)./t3)+deltaY;

end


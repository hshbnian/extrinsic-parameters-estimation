function [ Omega,Tau] = EstimateExtrinsic( inputPoints,outputPoints)
BigMatrix=[];

partZero=[0 0 0 0];
for i=1: size(inputPoints,2)
    w=inputPoints(1:3,i)';
    u=outputPoints(1:2,i);
    
    if(sum(isnan(w))==0 && sum(isnan(u))==0 && sum(isinf(w))==0 && sum(isinf(u))==0 )
        part1=[ -w(1)*u(1) , -w(2)*u(1) , -w(3)*u(1) , -u(1)];
        part2=[ -w(1)*u(2) , -w(2)*u(2) , -w(3)*u(2) , -u(2)];
        line1=[w,1,partZero,part1];
        line2=[partZero,w,1,part2];
        BigMatrix=[BigMatrix;line1;line2];
    end
end

[~,~,V] = svd(BigMatrix);
V=V';
estimatedParams=V(:,end);
estimatedParams=(reshape(estimatedParams,[4,3]))';

% some refinements proposed at equation 14.31 of book
TauE=estimatedParams(:,end);
OmegaE=estimatedParams(:,1:3);
[UO,~,VO] = svd(OmegaE);
Omega=UO*VO;

ra=sum(sum(Omega./Omega));
Tau=  ra*TauE;
end


function []=extrinsic_estimation()


%% Generate Cube

showNumbersFlag=false;
numberOfPointsEachLine=30;
inputPoints = CubePointsGenerator( numberOfPointsEachLine );
%InputPoints=InputPoints(:,20:30);

% plot the cube
subplot(3,2,1);
scatter3(inputPoints(1,:),inputPoints(2,:),inputPoints(3,:),50,inputPoints(1:3,:)','filled');
xlabel('U'); ylabel('V'); zlabel('W');
title('1-  3D cube (U,V,W)');
a = [1:size(inputPoints,2)]';
b = num2str(a); 
c = cellstr(b);
d=0.02;
if showNumbersFlag 
    text(inputPoints(1,:)+d, inputPoints(2,:)+d,inputPoints(3,:)+d, c);
end

%% Transformation Parameters

% Intrinsic Params
phiX=1;
phiY=1;
gamma=0;
deltaX=0;
deltaY=0;

Lambda=[ phiX gamma deltaX 0;
         0    phiY  deltaY 0;
         0      0     1    0
        ];

% Extrinsic Parameters
n=[0;0;1];
theta=pi/4;
I=eye(3);
S=[ 0  -n(3) n(2)
    n(3) 0   -n(1)
    -n(2) n(1) 0
    ];
Omega= (I + sin(theta)*S + (1-cos(theta))* (S*S))';
Tau=[0;0;0];

%Omega=[[R,Tau];[0 0 0 1]];

%% Get the image
removeLambda=false;
outputPoints1  = TakeImage(inputPoints, Lambda, Omega, Tau, removeLambda);


subplot(3,2,3);
scatter(outputPoints1(1,:),outputPoints1(2,:),50,inputPoints(1:3,:)','filled');
title('3-  Result without division by lambda');

% remove Lamda effect
removeLambda=true;
outputPoints2  = TakeImage(inputPoints, Lambda, Omega, Tau, removeLambda);
subplot(3,2,4);
scatter(outputPoints2(1,:),outputPoints2(2,:),50,inputPoints(1:3,:)','filled');
title('4-  Result with division by lambda');
%text(X+d, Y+d , c);

%% estimate Extrinsic Parameters

[ OmegaE1,TauE1] = EstimateExtrinsic( inputPoints,outputPoints1);

outputPointsEstimated = TakeImage(inputPoints, Lambda, OmegaE1, TauE1, false);
subplot(3,2,5);
scatter(outputPointsEstimated(1,:),outputPointsEstimated(2,:),50,inputPoints(1:3,:)','filled');
title('5-  results with estimated parameters');

[ OmegaE1,TauE1] = EstimateExtrinsic( inputPoints,outputPoints2);
outputPointsEstimated = TakeImage(inputPoints, Lambda, OmegaE1, TauE1, true);
subplot(3,2,6);
scatter(outputPointsEstimated(1,:),outputPointsEstimated(2,:),50,inputPoints(1:3,:)','filled');
title('6-  result with estimated parameters');
%%


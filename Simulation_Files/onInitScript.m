
controlOn = 'no'; % yes for active control, i.e. "regulation case"; no for "base case".
filename = []; %'initData_R5_2500_1.mat';
% --> only used when controlOn = 'yes'. Contains temperature initializations.
balancingSignalName = 'regSigNorm'; % variable stored in .mat must be "refSignal"

powArray=zeros(10000,1); 
acOnArray=zeros(10000,1); 
timeArray = zeros(10000,1); 
switchArray = zeros(10000,1); 
targetArray = zeros(10000,1);
n=1; 
j = 1;
integratedErrorArray = zeros(10000,1); 
integratedError = 0;
target = 0;

if strcmp(controlOn,'yes') == 1 
    load(filename)
    load(balancingSignalName); 

    KI = 0;
    Kset = 1.75; 
    amp = initData.refAmplitude;
    refSignal = refSignal*amp;
    settlingTime = initData.settlingTime; % minutes
    avgOffset = initData.avgOffset;  
    baselineIntercept = initData.baselineIntercept;
    baselineSlope = initData.baselineSlope;
    hvacPowAvg = initData.hvacPowAvg;
end



ans=GLD_OK; 

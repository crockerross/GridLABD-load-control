
controlOn = 'no';
filename = []; %'initData_R5_2500_1.mat';
% --> only used when controlOn = 'yes'. Contains temp. initializations.
useSineSignal = 0;
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
    if useSineSignal == 0
        load(balancingSignalName); 
    end
    KI = 0;
    Kset = 1.75; 
    %capacityScale = initData.capacityScale; 
    amp = initData.refAmplitude;
    if useSineSignal == 1
        freq = initData.refFrequency;
        refSignal = amp*sin(2*pi*(1:1800)/1800*freq);
    else refSignal = refSignal*amp;
    end
    settlingTime = initData.settlingTime; % minutes
    avgOffset = initData.avgOffset;  
    baselineIntercept = initData.baselineIntercept;
    baselineSlope = initData.baselineSlope;
    hvacPowAvg = initData.hvacPowAvg;
end



ans=GLD_OK; 

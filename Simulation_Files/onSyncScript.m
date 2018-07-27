
%Chosen parameters
if n == 1
    if strcmp(controlOn,'yes') == 1 
        startControl = 60*settlingTime; % time at which we want to start forcing TCLs
        endControl = 60*(60+settlingTime)-2; % time at which we want to stop forcing TCLs
        %capacity = avgOffset*capacityScale; 
    end
end

if mod(n,2) ~= 0
    
    timeStep = gld.global.clock;

    if n == 1
        initTime = timeStep;
    end;
    time = timeStep-initTime;
    
    if strcmp(controlOn,'yes') == 1
        if time == startControl
            nStart = j;
            k = 1;
            K = 0.5;
        elseif time == endControl
            nEnd = j;
        end
                      
        if time > startControl && time < endControl
            % gradually increase gain so we don't have overshoot from the initial
            % tracking error
            if K < Kset    
                 K = K + 0.05;
            end
        
            % Create target signal
            baseline = baselineIntercept+baselineSlope*(time-startControl);
            target = refSignal(k)*avgOffset + baseline;  
            
            % Control algorithm
            integratedError = integratedError + (target-hvacPower);
            if (target - hvacPower) > 0
                if availableToSwitchOn>0
                    switchProb =(K*(target-hvacPower)+integratedError*KI)/(hvacPowAvg*availableToSwitchOn);
                else switchProb = 0;
                end
            else 
                if availableToSwitchOff > 0
                    switchProb = (K*(target-hvacPower)+integratedError*KI)/(hvacPowAvg*availableToSwitchOff);
                else switchProb = 0;
                end
            end
            k = k+1;  % time step that starts when tracking starts
       else  target = 0;
             switchProb = 0;
             integratedError = 0;
       end
    else switchProb = 0;    
    end
    
    timeArray(j)=time;
    powArray(j) = hvacPower; 
    acOnArray(j) = numOn; 
    switchArray(j) = switchProb; 
    integratedErrorArray(j) = integratedError;
    targetArray(j) = target;
    
    j = j + 1;  % time step that doesn't double count each step
else switchProb = 0; % If no control is desired.
         
end
    
n=n+1; % "time" step that counts up for every gridlabd sync



ans=TS_NEVER; 

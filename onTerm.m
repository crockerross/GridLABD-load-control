
if strcmp(controlOn,'yes')
    figure(1)
    time = timeArray(1:j-1)/60-settlingTime;
    plot(time,powArray(1:j-1),time,targetArray(1:j-1)); 
    xlabel('Time (min)');
    ylabel('Residential Air Conditioner Power (kW)');
    trackError = rms((powArray(nStart:nEnd)-targetArray(nStart:nEnd))/avgOffset);
    figure(2)
    plot(timeArray(nStart:nEnd),switchArray(nStart:nEnd));
    xlabel('Time (sec)');
    ylabel('Switching probability');
    simData = struct('integratedError', integratedErrorArray(nStart:nEnd), 'trackError', trackError, ...
    'switchProb', switchArray(nStart:nEnd), 'powArray', powArray(nStart:nEnd), ...
    'targetArray', targetArray(nStart:nEnd), 'timeArray',timeArray(nStart:nEnd),...
    'K', K, 'KI' , KI, 'refAmp',amp); 
    if useSineSignal ==1
        simData.refFreq = freq;
    end
    save('simData.mat','simData');
else 
    plot(timeArray(1:j-1),powArray(1:j-1)); 
    xlabel('Time (sec)');
    ylabel('Residential Air Conditioner Power (kW)');
    simData = struct('powArray', powArray(1:j), 'timeArray', timeArray(1:j),'acOnArray',acOnArray(1:j)); 
    save('simData.mat','simData');
end

ans=GLD_OK;

function [adjustWeight, detectIndex] = MaliciousDetection(oldweight, newweight)
    interFactor = oldweight ./(newweight + 1e-10);
    [maxvalue , maxIndex]= max(interFactor);
    [minvalue , minIndex]= min(interFactor);
    
    if (maxvalue/mean(interFactor) > minvalue/mean(interFactor))
        detectIndex = maxIndex;
    else
        detectIndex = minIndex;
    end
    adjustWeight = newweight;
    adjustWeight(detectIndex) = oldweight(detectIndex);
end
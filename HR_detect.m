function [VFilt, vInt, locs] = HR_detect(V, sampleRate, filterObj)

VFilt = filtfilt(filterObj, V);%bandpass filter 

dV = gradient(VFilt); %derivative of the slope of the filtered ecg 

vSq = dV.^2; %square it so they all become positive

nInt = round(0.050 * sampleRate); %get only small portion of the data into samples otherwise too much 

k = ones(1, nInt) * (1/nInt);%integration 

vInt = conv(vSq, k, "same"); % convolution term to find vInt

MPH = 2 * mean(vInt);%minimum peaks
MPD = round(0.200 * sampleRate);%minimu peak distance 

% V > .2*app.sampleRate
if MPD < length(V) % look for peaks when signal is longer than 0.2 s
 [~, locs] = findpeaks(vInt, 'MinPeakDistance', MPD, ...
 'MinPeakHeight', MPH);
else
 locs = []; % if not looking for peaks set locs to empty
end

end


function En = SpectralEntropy(signal,windowLength,windowStep, fftLength, numOfBins,name,path)
signal = signal / max(abs(signal));
curPos = 1;
L = length(signal);
numOfFrames = floor((L-windowLength)/windowStep) + 1;
H = hamming(windowLength);
En = zeros(numOfFrames,1);
h_step = fftLength / numOfBins;

for (i=1:numOfFrames)
    window = (H.*signal(curPos:curPos+windowLength-1));
    fftTemp = abs(fft(window,2*fftLength));
    fftTemp = fftTemp(1:fftLength);
    S = sum(fftTemp);    
    
    for (j=1:numOfBins)
        p(j) = sum(fftTemp((j-1)*h_step + 1: j*h_step)) / S;
    end
    En(i) = -sum(p.*log2(p));
    curPos = curPos + windowStep;
end
 % [M,N]=size(En);
% if M>N
    % En=En';
    % [M,N]=size(En);
% end
 % ma = max(En);
 % mi = min(En);
 % for i=1:N
 % En(i) = (En(i)-mi)/(ma-mi);
 % end
 %En = En / max(abs(En));
varStr = name;
 pathStr=path;
 newStr=[pathStr,varStr];
 dlmwrite(newStr,En);
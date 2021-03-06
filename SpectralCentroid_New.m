function C = SpectralCentroid_New(signal,windowLength,step,fs,name,path)
signal = signal / max(abs(signal));
curPos = 1;
L = length(signal);
numOfFrames = floor((L-windowLength)/step) + 1;
H = hamming(windowLength);
m = ((fs/(2*windowLength))*[1:windowLength])';
C = zeros(numOfFrames,1);
for i=1:numOfFrames
    window = H.*(signal(curPos:curPos+windowLength-1));    
    FFT = (abs(fft(window,2*windowLength)));
    FFT = FFT(1:windowLength);  
    FFT = FFT / max(FFT);
    Pow = FFT.^2;
    C(i) = sum(m.*Pow)/sum(Pow);
    curPos = curPos + step;
end
%C = C / (fs/2);
% [M,N]=size(C);
% if M>N
%     C=C';
%     [M,N]=size(C);
% end
% ma = max(C);
% mi = min(C);
% for i=1:N
% C(i) = (C(i)-mi)/(ma-mi);
% end
% C = C/max(abs(C));
varStr = name;
 pathStr=path;
 newStr=[pathStr,varStr];
 dlmwrite(newStr,C);
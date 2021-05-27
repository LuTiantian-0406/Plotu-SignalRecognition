function [pknum] = FindPeakNum(signal)
mpd = length(signal)/40;
Signal_fft = fftshift(abs(fft(signal)));
flag = true;
pknum = 0;
maxpk = max(Signal_fft);
meanpk = mean(Signal_fft);
while(flag)
    [pks,locs] = findpeaks(Signal_fft, 'minpeakdistance', mpd);
    if max(pks) >= 5*(sum(pks)-max(pks))/length(pks) && max(pks) > (maxpk-meanpk) * 0.3
        flag = true;
        pknum = pknum + 1;
    else
        flag = false;
    end
    if locs(pks==max(pks))-100 < 1
        pkstart = 1;
    else
        pkstart = locs(pks==max(pks))-100;
    end
    if locs(pks==max(pks))+100 > length(Signal_fft)
        pkstop = length(Signal_fft);
    else
        pkstop = locs(pks==max(pks))+100;
    end
    Signal_fft(pkstart:pkstop) = 0;  %将峰值置零以便寻找第二个峰值
    if max(Signal_fft) <= 20
        flag = false;
    end
end
end
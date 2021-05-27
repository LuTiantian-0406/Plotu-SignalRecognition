function B = calc_B(f, signal, percent)
Signal_fft = fftshift(abs(fft(signal)));
N = length(f);
Peak_value = max(Signal_fft);
B_value = Peak_value * percent;
B_start = 1;B_stop = 1;
for i = 1:N
    if Signal_fft(i) < B_value && Signal_fft(i+1) > B_value
        B_start = i;
        break;
    end
end
for i = N:-1:2
    if Signal_fft(i) < B_value && Signal_fft(i-1) > B_value
        B_stop = i;
        break;
    end
end
B = abs((f(B_start)+f(B_start+1))/2-(f(B_stop)+f(B_stop-1))/2);
end
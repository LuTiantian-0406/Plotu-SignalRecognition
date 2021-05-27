close all;clc;clear all;

T = 2e-6;  % 脉宽2us
fc = 0.1e9;
fs = 3e9; % 采样率
N = T*fs;
signal = Single_Signal(T, fc, fs);
s1 = signal(1:1000);
s2 = signal(1001:2000);
s = s1 .* conj(s2);

%% 频谱
fft_signal = fftshift(abs(fft(s)));
N = 1000;
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f, fft_signal);grid on;
xlabel('f/Hz');title('幅度谱');

%% 平方
pow_signal = signal.^2;
pow_fft = fftshift(abs(fft(pow_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_fft);grid on;
xlabel('f/Hz');title('平方后的幅度谱');

%% 识别
SignalRecognition(f, signal, 0.5, 0.05);

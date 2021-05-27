close all;clc;clear all;

%% LFM ：linear frequency modulation
% 信号参数
B = 200e6;  % 带宽10MHz
T = 2e-6;  % 脉宽2us
fc = 0.1e9;
fs = 3e9; % 采样率
N = T*fs;
t = linspace(-T/2, T/2, N);
K = B/T;
FFT_Len = 2^nextpow2(2 * N);

% 生成LFM信号
St = exp(1j*(2*pi*fc*t+pi*K*t.^2)); %信号

%% 信号参数图
figure(1);
plot(real(St));title('信号实部');
figure(2);
f = (0:N-1)*fs/N-fs/2;
LFM_FFT = fftshift(abs(fft(St)));
plot(f, LFM_FFT);title('信号频谱');
grid on;
axis tight;

%% 信号识别
SignalRecognition(f, St, 0.6, 0.01);

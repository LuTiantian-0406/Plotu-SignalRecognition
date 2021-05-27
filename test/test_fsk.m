close all;clc;clear all;

%% 参数设置
Rb = 0.05e6;        % 码元速率
fc1 = 0.1e6;       % 载波频率
fc2 = 0.02e6;       % 载波频率
fs = 1e6;          % 采样频率

k = 10;           % 码元长度
N = k/Rb*fs;

%% FSK信号调制
[fsk_signal] = FSK_Signal(Rb, fc1, fc2, fs, k);

%% 信号图
figure(1)
t = 0:1/fs:(N-1)/fs;
plot(t, fsk_signal,'r'); grid on;
xlabel('时间t/s');ylabel('幅值');
title('BPSK调制信号');

%% 频谱
fsk_fft = fftshift(abs(fft(fsk_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f, fsk_fft);grid on;
xlabel('f/Hz');title('FSK信号的幅度谱');

%% 平方
pow_bpsk = fsk_signal.^2;
pow_bpsk_fft = fftshift(abs(fft(pow_bpsk)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_bpsk_fft);grid on;
xlabel('f/Hz');title('FSK信号的平方后的幅度谱');

%{
%% 识别
f = (0:N-1)*fs/N-fs/2;
SignalRecognition(f, fsk_signal, 0.6, 0.01);
%}
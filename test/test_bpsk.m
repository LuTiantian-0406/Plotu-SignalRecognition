close all;clc;clear all;

%% 参数设置
Rb = 0.05e6;       % 码元速率
fc = 0.04e6;       % 载波频率
fs = 1e6;     % 采样频率
k = 499;         % 码元长度
N = k/Rb*fs;

%% BPSK信号调制
[bpsk_signal] = BPSK_Signal(Rb, fc, fs, k);
% s_omega = randi(2, 1, 499) - 1;  % 499个码元，码元宽度20个采样点，取值0, 1
% fc = 0.04e6;  % 载频
% sc0 = exp(1j*(2 .* pi .* fc .* [1: 10000]' ./ fs));  % 载波0
% sc1 = exp(1j*(2 .* pi .* fc .* [1: 10000]' ./ fs + pi));  % 载波1
% s = zeros(1, N);  % 调制信号
% for i = 1: length(s_omega)
%     if s_omega(i)
%         s(20 * (i-1) +1: 20 * (i - 1) + 20) = sc1(20 * (i-1) +1: 20 * (i - 1) + 20);
%     else
%         s(20 * (i-1) +1: 20 * (i - 1) + 20) = sc0(20 * (i-1) +1: 20 * (i - 1) + 20);
%     end
% end
% bpsk_signal = s';

%% 信号图
figure(1)
t = 0:1/fs:(N-1)/fs;
plot(t, bpsk_signal,'r'); grid on;
xlabel('时间t/s');ylabel('幅值');
title('BPSK调制信号');

%% 频谱
bpsk_fft = fftshift(abs(fft(bpsk_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f, bpsk_fft);grid on;
xlabel('f/Hz');title('BPSK信号的幅度谱');

%% 平方
pow_bpsk = bpsk_signal.^2;
pow_bpsk_fft = fftshift(abs(fft(pow_bpsk)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_bpsk_fft);grid on;
xlabel('f/Hz');title('BPSK信号的平方后的幅度谱');

%% 识别
f = (0:N-1)*fs/N-fs/2;
SignalRecognition(f, bpsk_signal, 0.6, 0.01);
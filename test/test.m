close all;clc;clear all;

T = 2e-3;      %����
fc = [0.02e6, 0.1e6, 0.2e6, 0.3e6];   %�ز�Ƶ��
fs = 1e6;      %������
Rb = 0.05e6;   %��Ԫ����
k = 50;        %��Ԫ����
B = 0.04e6;    %����

signal = Signal_generation(T, fc, fs, Rb, k, B);
N = length(signal);
s1 = signal(1:N/2);
s2 = signal(N/2+1:N);
s = s1 .* conj(s2);

%% �ź�ͼ
figure(1)
t = 0:1/fs:(N-1)/fs;
plot(t, signal,'r'); grid on;
xlabel('ʱ��t/s');ylabel('��ֵ');
title('�ź�ʱ��ͼ');

%% Ƶ��
fsk_fft = fftshift(abs(fft(s)));
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f(1:N/2), fsk_fft);grid on;
xlabel('f/Hz');title('�źŵķ�����');

%% ƽ��
pow_signal = signal.^4;
pow_signal_fft = fftshift(abs(fft(pow_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_signal_fft);grid on;
xlabel('f/Hz');title('ƽ����ķ�����');

%% ʶ��
f = (0:N-1)*fs/N-fs/2;
SignalRecognition(f, fc, signal, 0.6, 0.001);

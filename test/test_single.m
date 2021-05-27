close all;clc;clear all;

T = 2e-6;  % ����2us
fc = 0.1e9;
fs = 3e9; % ������
N = T*fs;
signal = Single_Signal(T, fc, fs);
s1 = signal(1:1000);
s2 = signal(1001:2000);
s = s1 .* conj(s2);

%% Ƶ��
fft_signal = fftshift(abs(fft(s)));
N = 1000;
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f, fft_signal);grid on;
xlabel('f/Hz');title('������');

%% ƽ��
pow_signal = signal.^2;
pow_fft = fftshift(abs(fft(pow_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_fft);grid on;
xlabel('f/Hz');title('ƽ����ķ�����');

%% ʶ��
SignalRecognition(f, signal, 0.5, 0.05);

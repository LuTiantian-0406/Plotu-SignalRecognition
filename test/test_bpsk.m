close all;clc;clear all;

%% ��������
Rb = 0.05e6;       % ��Ԫ����
fc = 0.04e6;       % �ز�Ƶ��
fs = 1e6;     % ����Ƶ��
k = 499;         % ��Ԫ����
N = k/Rb*fs;

%% BPSK�źŵ���
[bpsk_signal] = BPSK_Signal(Rb, fc, fs, k);
% s_omega = randi(2, 1, 499) - 1;  % 499����Ԫ����Ԫ���20�������㣬ȡֵ0, 1
% fc = 0.04e6;  % ��Ƶ
% sc0 = exp(1j*(2 .* pi .* fc .* [1: 10000]' ./ fs));  % �ز�0
% sc1 = exp(1j*(2 .* pi .* fc .* [1: 10000]' ./ fs + pi));  % �ز�1
% s = zeros(1, N);  % �����ź�
% for i = 1: length(s_omega)
%     if s_omega(i)
%         s(20 * (i-1) +1: 20 * (i - 1) + 20) = sc1(20 * (i-1) +1: 20 * (i - 1) + 20);
%     else
%         s(20 * (i-1) +1: 20 * (i - 1) + 20) = sc0(20 * (i-1) +1: 20 * (i - 1) + 20);
%     end
% end
% bpsk_signal = s';

%% �ź�ͼ
figure(1)
t = 0:1/fs:(N-1)/fs;
plot(t, bpsk_signal,'r'); grid on;
xlabel('ʱ��t/s');ylabel('��ֵ');
title('BPSK�����ź�');

%% Ƶ��
bpsk_fft = fftshift(abs(fft(bpsk_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f, bpsk_fft);grid on;
xlabel('f/Hz');title('BPSK�źŵķ�����');

%% ƽ��
pow_bpsk = bpsk_signal.^2;
pow_bpsk_fft = fftshift(abs(fft(pow_bpsk)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_bpsk_fft);grid on;
xlabel('f/Hz');title('BPSK�źŵ�ƽ����ķ�����');

%% ʶ��
f = (0:N-1)*fs/N-fs/2;
SignalRecognition(f, bpsk_signal, 0.6, 0.01);
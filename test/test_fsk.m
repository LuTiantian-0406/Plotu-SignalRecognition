close all;clc;clear all;

%% ��������
Rb = 0.05e6;        % ��Ԫ����
fc1 = 0.1e6;       % �ز�Ƶ��
fc2 = 0.02e6;       % �ز�Ƶ��
fs = 1e6;          % ����Ƶ��

k = 10;           % ��Ԫ����
N = k/Rb*fs;

%% FSK�źŵ���
[fsk_signal] = FSK_Signal(Rb, fc1, fc2, fs, k);

%% �ź�ͼ
figure(1)
t = 0:1/fs:(N-1)/fs;
plot(t, fsk_signal,'r'); grid on;
xlabel('ʱ��t/s');ylabel('��ֵ');
title('BPSK�����ź�');

%% Ƶ��
fsk_fft = fftshift(abs(fft(fsk_signal)));
f = (0:N-1)*fs/N-fs/2;
figure(3)
plot(f, fsk_fft);grid on;
xlabel('f/Hz');title('FSK�źŵķ�����');

%% ƽ��
pow_bpsk = fsk_signal.^2;
pow_bpsk_fft = fftshift(abs(fft(pow_bpsk)));
f = (0:N-1)*fs/N-fs/2;
figure(4)
plot(f, pow_bpsk_fft);grid on;
xlabel('f/Hz');title('FSK�źŵ�ƽ����ķ�����');

%{
%% ʶ��
f = (0:N-1)*fs/N-fs/2;
SignalRecognition(f, fsk_signal, 0.6, 0.01);
%}
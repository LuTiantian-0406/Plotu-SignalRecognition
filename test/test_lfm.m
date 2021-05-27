close all;clc;clear all;

%% LFM ��linear frequency modulation
% �źŲ���
B = 200e6;  % ����10MHz
T = 2e-6;  % ����2us
fc = 0.1e9;
fs = 3e9; % ������
N = T*fs;
t = linspace(-T/2, T/2, N);
K = B/T;
FFT_Len = 2^nextpow2(2 * N);

% ����LFM�ź�
St = exp(1j*(2*pi*fc*t+pi*K*t.^2)); %�ź�

%% �źŲ���ͼ
figure(1);
plot(real(St));title('�ź�ʵ��');
figure(2);
f = (0:N-1)*fs/N-fs/2;
LFM_FFT = fftshift(abs(fft(St)));
plot(f, LFM_FFT);title('�ź�Ƶ��');
grid on;
axis tight;

%% �ź�ʶ��
SignalRecognition(f, St, 0.6, 0.01);

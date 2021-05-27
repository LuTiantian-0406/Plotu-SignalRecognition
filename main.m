close all;clc;clear all;
addpath lib

%% ��������
T = 2e-3;                                %����
fc = [0.02e6, 0.1e6, 0.2e6, 0.3e6];      %�ز�Ƶ��
fs = 1e6;                                %������
Rb = 0.05e6;                             %��Ԫ����
k = 50;                                  %��Ԫ����
B = 0.1e6;                               %����
BasebandSampleRate = 1e6;                %����Ƶ�� 0.1GHZ
CenterFrequency = 2.5e9;                 %���������� 0.5GHz

%% pluto tx ����
txPluto = sdrtx('Pluto');
txPluto.RadioID = 'usb:1';
txPluto.CenterFrequency = CenterFrequency;         
txPluto.BasebandSampleRate = BasebandSampleRate;       
txPluto.ChannelMapping = 1;
txPluto.Gain = 0;

%% pluto rx ����
rxPluto = sdrrx('Pluto');
rxPluto.RadioID = 'usb:0';
rxPluto.CenterFrequency = CenterFrequency;        
rxPluto.BasebandSampleRate = BasebandSampleRate;
rxPluto.SamplesPerFrame = 0.5e5;       %���ò���������1024
N = rxPluto.SamplesPerFrame;
freq = (-N/2:N/2-1)/N* fs;

%% �����ź�
[signal, num] = Signal_generation(T, fc, fs, Rb, k, B);

%% �źŲ���ͼ
figure(1);
% subplot(2,2,1);plot(real(St));title('�ź�ʵ��');
signal_fft = fftshift(abs(fft(signal)));
n = length(signal);
f = (0:n-1)*fs/n-fs/2;
plot(f, signal_fft);title('�ź�Ƶ��');
grid on;
axis tight;

%% �Է������ź�
while(true)
    transmitRepeat(txPluto, signal');
    % data���յ����źţ�datavalidָʾ�����Ƿ���Ч��overflowָʾ�����Ƿ������
    [data, datavalid, overflow] = rxPluto(); %����pluto�������ݽ���
    SignalRecognition(freq, fc, data, 0.6, 0.001, num);
    n = length(data);
    f = (0:n-1)*fs/n-fs/2;
    data = double(data);
%     s = data(1:n/2) .* conj(data(n/2+1:n));
%     XK = fft(double(s)); %fft�任
%     figure(2);
%     plot(f(1:n/2), fftshift(abs(XK))); %�������ݵ�Ƶ��
    XK = fft(double(data)); %fft�任
    figure(2);
    plot(f, fftshift(abs(XK))); %�������ݵ�Ƶ��
%     figure(3);
%     plot(real(data));  %��������ʵ��
end

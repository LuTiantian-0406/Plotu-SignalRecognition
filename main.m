close all;clc;clear all;
addpath lib

%% 参数设置
T = 2e-3;                                %脉宽
fc = [0.02e6, 0.1e6, 0.2e6, 0.3e6];      %载波频率
fs = 1e6;                                %采样率
Rb = 0.05e6;                             %码元速率
k = 50;                                  %码元长度
B = 0.1e6;                               %带宽
BasebandSampleRate = 1e6;                %中心频率 0.1GHZ
CenterFrequency = 2.5e9;                 %基带采样率 0.5GHz

%% pluto tx 设置
txPluto = sdrtx('Pluto');
txPluto.RadioID = 'usb:1';
txPluto.CenterFrequency = CenterFrequency;         
txPluto.BasebandSampleRate = BasebandSampleRate;       
txPluto.ChannelMapping = 1;
txPluto.Gain = 0;

%% pluto rx 设置
rxPluto = sdrrx('Pluto');
rxPluto.RadioID = 'usb:0';
rxPluto.CenterFrequency = CenterFrequency;        
rxPluto.BasebandSampleRate = BasebandSampleRate;
rxPluto.SamplesPerFrame = 0.5e5;       %设置采样点数：1024
N = rxPluto.SamplesPerFrame;
freq = (-N/2:N/2-1)/N* fs;

%% 生成信号
[signal, num] = Signal_generation(T, fc, fs, Rb, k, B);

%% 信号参数图
figure(1);
% subplot(2,2,1);plot(real(St));title('信号实部');
signal_fft = fftshift(abs(fft(signal)));
n = length(signal);
f = (0:n-1)*fs/n-fs/2;
plot(f, signal_fft);title('信号频谱');
grid on;
axis tight;

%% 自发自收信号
while(true)
    transmitRepeat(txPluto, signal');
    % data即收到的信号，datavalid指示数据是否有效，overflow指示数据是否溢出。
    [data, datavalid, overflow] = rxPluto(); %利用pluto进行数据接收
    SignalRecognition(freq, fc, data, 0.6, 0.001, num);
    n = length(data);
    f = (0:n-1)*fs/n-fs/2;
    data = double(data);
%     s = data(1:n/2) .* conj(data(n/2+1:n));
%     XK = fft(double(s)); %fft变换
%     figure(2);
%     plot(f(1:n/2), fftshift(abs(XK))); %绘制数据的频谱
    XK = fft(double(data)); %fft变换
    figure(2);
    plot(f, fftshift(abs(XK))); %绘制数据的频谱
%     figure(3);
%     plot(real(data));  %绘制数据实部
end

function [lfm_signal] = LFM_Signal(B, T, fc, fs)
%% LFM ：linear frequency modulation
% B：带宽
% T：脉宽
% fc：载波频率
% fs：采样频率

%% 生成LFM信号
N = T * fs;
t = linspace(-T/2, T/2, N);
K = B/T;
lfm_signal = exp(1j*(2*pi*fc*t+pi*K*t.^2)); %信号
end
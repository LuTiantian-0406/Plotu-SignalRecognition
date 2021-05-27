function [signal] = Single_Signal(T, fc, fs)
%% 单音信号
% T：脉宽
% fc：载波频率
% fs：采样率

%% 生成单音信号
N = T * fs;
t = linspace(-T/2, T/2, N);
signal = exp(1j*(2*pi*fc*t));
end

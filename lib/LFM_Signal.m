function [lfm_signal] = LFM_Signal(B, T, fc, fs)
%% LFM ��linear frequency modulation
% B������
% T������
% fc���ز�Ƶ��
% fs������Ƶ��

%% ����LFM�ź�
N = T * fs;
t = linspace(-T/2, T/2, N);
K = B/T;
lfm_signal = exp(1j*(2*pi*fc*t+pi*K*t.^2)); %�ź�
end
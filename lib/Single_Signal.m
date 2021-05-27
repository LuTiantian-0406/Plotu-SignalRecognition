function [signal] = Single_Signal(T, fc, fs)
%% �����ź�
% T������
% fc���ز�Ƶ��
% fs��������

%% ���ɵ����ź�
N = T * fs;
t = linspace(-T/2, T/2, N);
signal = exp(1j*(2*pi*fc*t));
end

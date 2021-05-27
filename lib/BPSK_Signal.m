function [bpsk_signal] = BPSK_Signal(Rb, fc, fs, k)
%% BPSK�ź�
% Rb����Ԫ����
% fc���ز�Ƶ��
% fs������Ƶ��
% k����Ԫ����

%% BPSK�źŵ���
binary_code = randi([0,1],1,k);    % ����0 1����
N = k/Rb*fs;
Npc = 1/Rb*fs;
l = 0;
bpsk_signal = zeros(1,N);
for i=1:k
   for j = l:l+Npc-1
       if binary_code(1,i) == 0
         bpsk_signal(j+1) = exp(1j*(2*pi*fc*j/fs));
       elseif binary_code(1,i) == 1
         bpsk_signal(j+1) = exp(1j*(2*pi*fc*j/fs+pi));
       end
   end
   l = l+Npc;
end
end

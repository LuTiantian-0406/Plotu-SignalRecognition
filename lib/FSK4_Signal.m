function [bpsk_signal] = FSK4_Signal(Rb, fc1, fc2, fc3, fc4, fs, k)
%% BPSK�ź�
% Rb����Ԫ����
% fc1���ز�Ƶ��1
% fc2���ز�Ƶ��2
% fc3���ز�Ƶ��3
% fc4���ز�Ƶ��4
% fs������Ƶ��
% k����Ԫ����

%% BPSK�źŵ���
binary_code = randi([0,3],1,k);    % ����0 1����
N = k/Rb*fs;
Npc = 1/Rb*fs;
l = 0;
bpsk_signal = zeros(1,N);
for i=1:k
    for j = l:l+Npc-1
        if binary_code(1,i) == 0
            bpsk_signal(j+1) = exp(1j*(2*pi*fc1*j/fs));
        elseif binary_code(1,i) == 1
            bpsk_signal(j+1) = exp(1j*(2*pi*fc2*j/fs));
        elseif binary_code(1,i) == 2
            bpsk_signal(j+1) = exp(1j*(2*pi*fc3*j/fs));
        elseif binary_code(1,i) == 3
            bpsk_signal(j+1) = exp(1j*(2*pi*fc4*j/fs));
        end
    end
    l = l+Npc;
end

end

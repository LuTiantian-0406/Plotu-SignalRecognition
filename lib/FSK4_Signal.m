function [bpsk_signal] = FSK4_Signal(Rb, fc1, fc2, fc3, fc4, fs, k)
%% BPSK信号
% Rb：码元速率
% fc1：载波频率1
% fc2：载波频率2
% fc3：载波频率3
% fc4：载波频率4
% fs：采样频率
% k：码元长度

%% BPSK信号调制
binary_code = randi([0,3],1,k);    % 产生0 1序列
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

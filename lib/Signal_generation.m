function [signal, num] = Signal_generation(T, fc, fs, Rb, k, B)
%% 函数参数说明
% T：脉宽
% fc：载波频率
% fs：采样率
% Rb：码元速率
% k：码元长度
% B：带宽

%% 生成信号
disp('请输入需要的信号:');
disp('  (1)单音信号');
disp('  (2)FM信号');
disp('  (3)2FSK信号');
disp('  (4)4FSK信号');
disp('  (5)BPSK信号');
disp('  (6)QPSK信号');

num = input('');
switch num
    case 1
        signal = Single_Signal(T, fc(1), fs);
    case 2
        signal = LFM_Signal(B, T, 0.04e6, fs);
    case 3
        signal = FSK2_Signal(Rb, fc(1), fc(2), fs, k);
    case 4
        signal = FSK4_Signal(Rb, fc(1), fc(2), fc(3), fc(4), fs, k);
    case 5
        signal = BPSK_Signal(Rb, fc(1), fs, k);
    case 6
        signal = QPSK_Signal(Rb, fc(1), fs, k);
    otherwise
        disp('无此信号');
end
end
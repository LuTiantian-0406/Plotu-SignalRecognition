function [signal, num] = Signal_generation(T, fc, fs, Rb, k, B)
%% ��������˵��
% T������
% fc���ز�Ƶ��
% fs��������
% Rb����Ԫ����
% k����Ԫ����
% B������

%% �����ź�
disp('��������Ҫ���ź�:');
disp('  (1)�����ź�');
disp('  (2)FM�ź�');
disp('  (3)2FSK�ź�');
disp('  (4)4FSK�ź�');
disp('  (5)BPSK�ź�');
disp('  (6)QPSK�ź�');

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
        disp('�޴��ź�');
end
end
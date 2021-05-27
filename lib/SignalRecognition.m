function [] = SignalRecognition(f, fc, signal, percent, precision, num)
%% ��������
% f��Ƶ������
% signal�������ź�
% percent���������������ռƵ�׷�ֵ�İٷֱ�
% precision������Ƚ϶�̬��Χ

%% ���Ƶ�׷������
signal = double(signal);
pknum = FindPeakNum(signal);

%% ���ƽ����Ƶ�׷������
Pow_signal = signal.^2;
Powpknum = FindPeakNum(Pow_signal);

%% ����Ĵη���Ƶ�׷������
Pow4_signal = signal.^4;
Pow4pknum = FindPeakNum(Pow4_signal);

%% �����źŴ���
B = calc_B(f, signal, percent);

%% ���㹲�����
N = length(signal);
s1 = signal(1:N/2);
s2 = signal(N/2+1:N);
s = s1 .* conj(s2);
f1 = f(1:N/2);
conj_B = calc_B(f1, s, percent);
half_B = calc_B(f1, signal(1:N/2), 0.6);


%% �����ź�ƽ�������
Pow_signal = signal.^2;
Pow_B = calc_B(f, Pow_signal, percent);

%% �����ź��Ĵη������
Pow4_signal = signal.^4;
Pow4_B = calc_B(f, Pow4_signal, percent);

%% �ź�ʶ��
f_domain = f(end) - f(1);
PowSignal_fft = fftshift(abs(fft(Pow_signal)));
if all(PowSignal_fft(find(f == 2*fc(1))-150 : find(f == 2*fc(1))+150) > max(PowSignal_fft)*0.02) ...
        || all(PowSignal_fft(find(f == -2*fc(1))-150 : find(f == -2*fc(1))+150) > max(PowSignal_fft)*0.02)
    disp('FM�ź�');
    % if half_B / conj_B >= 12
    %     disp('FM�ź�')
else
    if pknum == 1 || Powpknum == 1 || Pow4pknum == 1
        if B <= Pow_B + f_domain*precision && B >= Pow_B - f_domain*precision ...
                && Pow_B <= Pow4_B + f_domain*precision && Pow_B >= Pow4_B - f_domain*precision
            disp('�����ź�');
        elseif B > Pow_B + f_domain*precision && Pow_B <= Pow4_B + f_domain*precision ...
                && Pow_B >= Pow4_B - f_domain*precision
            disp('BPSK�ź�');
        elseif B > Pow4_B + f_domain*precision
            disp('QPSK�ź�')
        else
            disp('ʶ��ʧ��1');
        end
    elseif pknum == 2 || Powpknum == 2
        disp('2FSK�ź�');
    elseif pknum >= 4 || Powpknum >= 4
        disp('4FSK�ź�');
    else
        disp('ʶ��ʧ��2')
    end
end

end
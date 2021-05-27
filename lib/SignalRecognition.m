function [] = SignalRecognition(f, fc, signal, percent, precision, num)
%% 函数参数
% f：频谱区间
% signal：输入信号
% percent：计算带宽两端所占频谱峰值的百分比
% precision：带宽比较动态范围

%% 检测频谱峰的数量
signal = double(signal);
pknum = FindPeakNum(signal);

%% 检测平方后频谱峰的数量
Pow_signal = signal.^2;
Powpknum = FindPeakNum(Pow_signal);

%% 检测四次方后频谱峰的数量
Pow4_signal = signal.^4;
Pow4pknum = FindPeakNum(Pow4_signal);

%% 计算信号带宽
B = calc_B(f, signal, percent);

%% 计算共轭带宽
N = length(signal);
s1 = signal(1:N/2);
s2 = signal(N/2+1:N);
s = s1 .* conj(s2);
f1 = f(1:N/2);
conj_B = calc_B(f1, s, percent);
half_B = calc_B(f1, signal(1:N/2), 0.6);


%% 计算信号平方后带宽
Pow_signal = signal.^2;
Pow_B = calc_B(f, Pow_signal, percent);

%% 计算信号四次方后带宽
Pow4_signal = signal.^4;
Pow4_B = calc_B(f, Pow4_signal, percent);

%% 信号识别
f_domain = f(end) - f(1);
PowSignal_fft = fftshift(abs(fft(Pow_signal)));
if all(PowSignal_fft(find(f == 2*fc(1))-150 : find(f == 2*fc(1))+150) > max(PowSignal_fft)*0.02) ...
        || all(PowSignal_fft(find(f == -2*fc(1))-150 : find(f == -2*fc(1))+150) > max(PowSignal_fft)*0.02)
    disp('FM信号');
    % if half_B / conj_B >= 12
    %     disp('FM信号')
else
    if pknum == 1 || Powpknum == 1 || Pow4pknum == 1
        if B <= Pow_B + f_domain*precision && B >= Pow_B - f_domain*precision ...
                && Pow_B <= Pow4_B + f_domain*precision && Pow_B >= Pow4_B - f_domain*precision
            disp('单音信号');
        elseif B > Pow_B + f_domain*precision && Pow_B <= Pow4_B + f_domain*precision ...
                && Pow_B >= Pow4_B - f_domain*precision
            disp('BPSK信号');
        elseif B > Pow4_B + f_domain*precision
            disp('QPSK信号')
        else
            disp('识别失败1');
        end
    elseif pknum == 2 || Powpknum == 2
        disp('2FSK信号');
    elseif pknum >= 4 || Powpknum >= 4
        disp('4FSK信号');
    else
        disp('识别失败2')
    end
end

end
function [qpsk_signal] = QPSK_Signal(Rb, fc, fs, k)
bitstream = randi([0,1], 1, 2*k);
bitstream = 2 * bitstream - 1;
I = [];Q = [];
for i = 1:2*k
    if mod(i,2) ~= 0
        I = [I, bitstream(i)];
    else
        Q = [Q, bitstream(i)];
    end
end
I_data=[];Q_data=[];
for i = 1 : k
    I_data = [I_data, I(i)*ones(1, 2*fs/Rb)];
    Q_data = [Q_data, Q(i)*ones(1, 2*fs/Rb)];
end
bit_t = 0 : 1/fs : 2/Rb-1/fs;
I_carrier=[];Q_carrier=[];
for i = 1 : k
    I_carrier = [I_carrier, I(i)*exp(1j*2*pi*fc*bit_t)];
    Q_carrier = [Q_carrier, Q(i)*exp(1j*(2*pi*fc*bit_t+pi/2))];
end
qpsk_signal = I_carrier + Q_carrier;
end

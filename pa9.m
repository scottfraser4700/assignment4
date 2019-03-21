%defining component values
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
R5 = 1000;
g1 = 1/R1;
g2 = 1/R2;
g3 = 1/R3;
g4 = 1/R4;
g5 = 1/R5;
L = 0.2;
C = .25;
a = 100;

%Capacitive matrix
C = [C -C 0 0 0 0 0;
    -C C 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 -L;
     0 0 0 0 0 0 0];
%Conductivity matrix
 G =   [g1 -g1 0 0 0 1 0 ;
        -g1 g1+g2 0 0 0 0 1;
        0 0 g3 0 0 0 -1;
        0 0 0 1 0 0 -a;
        0 0 0 -g4 g4+g5 0 0 ;
        0 1 -1 0 0 0 0 ;
        1 0 0 0 0 0 0];
    Vmid = zeros(1,21);
    Vout = zeros(1,21);
    
    %input DC voltage sweep
    for Vin = -10:10
    F = [0 0 0 0 0 0 Vin]';
    V = G\F;
    Vmid(Vin+11) = V(3);
    Vout(Vin+11) = V(5);
    end
    %plot DC voltage characteristic across gain stage
    Vin = -10:10;
    figure(1)
    subplot(1,2,1);
    plot(Vin,real(Vmid))
    title('Node 3 Voltage')
    subplot(1,2,2);
    plot(Vin,real(Vout))
    title('Output Voltage')
    
    Vout = zeros(1,100);
    %frequency domain sweep
    Vin=1;
for w=1:100
    %sweep from 1 to 100 rad/s
    %F stays at constant, Vin = 1V
    F = [0 0 0 0 0 0 Vin]';
    V = (G+1i*w*C)\F;
    %storing values of Vout for each iteration of frequency
    Vout(w) = V(5);
end
w=1:100;
figure(2)
%plot frequency response of Vout
plot(w,real(Vout))
title('Frequency Response of Vout')
figure(3)
%plotting gain in dB's
semilogx(w,10*log10(real(Vout)/Vin))
title('Frequency Response in dB')

%I need to make a histogram of the gain values
%frequency domain
%constant voltage
%thing changing in the loop is w, which will be a vector of values chosen
%randomly from a gaussian distribution with an average of pi and std of
%0.05.

w = pi+randn(1,10000)*0.05;
Vout = zeros(1,10000);
for n = 1:10000
    F = [0 0 0 0 0 0 Vin]';
    V = (G+1i*w(n)*C)\F;
    Vout(n) = V(5);
end
gain = 10*log10(real(Vout)/Vin);
%plotting frequency response to gaussian perturbations
figure(4)
histogram(gain,20)
title('Gain Histogram')
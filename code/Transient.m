%% Section 2 - Transient Circuit Simulation
% In this section, we use a finite difference approach to numerically
% simulate the time domain response of the circuit analyzed in the previous
% section. The circuit is a low pass filter/amplifier. It comes with an expected
% frequency response of high gain for low frequency inputs, and a rolloff
% in gain for frequencies above its corner frequency.
% Various input types are analyzed in the time and frequency domain. A
% step, sine, and gaussian input are fed into the system, and plots of
% input/output voltages are produced. In addition, the fft and fftshift
% techniques are used to expose the frequencies present in these signals.
% The fft plots show a two sided frequency spectrum, although the negative
% frequencies don't really have much physical meaning in this analysis.

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
t=0;
dt=1e-3;
Tstop = 1000*dt;
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
   
 A = (1/dt)*C +G;
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(7,1);
 vin = 0;
 iteration=1;
 while t<Tstop
     %defining input function
     if (t>30*dt)
         vin = 1;
     end
     F = [0 0 0 0 0 0 vin]'; 
     V = A\(C*Vold/dt + F);
     Vin(iteration) = vin;
     Vout(iteration) = V(5);
     Vold = V;
     t = t+dt;
     iteration=iteration+1;
 end
 t = 0:dt:999*dt;
 Frequency=linspace(-100,100,1000);
 %plotting step response
  figure(5)
  subplot(2,1,1);
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  title('Step Response')
  subplot(2,1,2);
  plot(Frequency,10*log10(abs(fftshift(fft(Vout)))))
  title('Fourier Transform of Step Response')
  
  %resetting variables
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(7,1);
 vin = 0;
 t=0;
 f = 1/0.03;
 iteration=1;
 while t<Tstop
     vin = sin(2*pi*f*t);
     F = [0 0 0 0 0 0 vin]'; 
     V = A\(C*Vold/dt + F);
     Vin(iteration) = vin;
     Vout(iteration) = V(5);
     Vold = V;
     iteration=iteration+1;
     t = t+dt;
 end
 t = 0:1:999;
 %plotting sinusoidal response
  figure(6)
  subplot(2,1,1);
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  title('Sinusoidal Response')
  subplot(2,1,2);
  plot(Frequency,10*log10(abs(fftshift(fft(Vout)))))
  title('Fourier Transform of Sinusoidal Response')
  
  
  %resetting variables
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(7,1);
 vin = 0;
 t=0;
 iteration=1;
 delay=0.06;
 sigma=0.03;
 while t<Tstop
    %set up gaussian pulse
     vin = (1/(sqrt(2*pi)*sigma))*exp(-((delay-t)^2)/(2*sigma^2));
     F = [0 0 0 0 0 0 vin]'; 
     V = A\(C*Vold/dt + F);
     Vin(iteration) = vin;
     Vout(iteration) = V(5);
     Vold = V;
     iteration=iteration+1;
     t = t+dt;
 end
 t = 0:1:999;
 %plotting gaussian response
  figure(7)
  subplot(2,1,1);
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  title('Gaussian Response')
  subplot(2,1,2);
  plot(Frequency,10*log10(abs(fftshift(fft(Vout)))))
  title('Fourier Transform of Gaussian Response')
  
  
 
 
 
 
 